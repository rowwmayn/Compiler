#include "symbol_info.h"

class scope_table
{
private:
    int bucket_count;
    int unique_id;
    scope_table *parent_scope = NULL;
    vector<list<symbol_info *>> table;

    // djb2-inspired hash: accumulate each character with a prime multiplier,
    // then mod by bucket_count to stay in range.
    int hash_function(string name)
    {
        unsigned long long h = 0;
        for (char c : name)
            h = h * 31 + (unsigned char)c;
        return (int)(h % (unsigned long long)bucket_count);
    }

public:
    // ---- constructors ----

    // Default constructor (required by the header skeleton)
    scope_table()
        : bucket_count(10), unique_id(0), parent_scope(NULL)
    {
        table.resize(bucket_count);
    }

    scope_table(int bucket_count, int unique_id, scope_table *parent_scope)
        : bucket_count(bucket_count), unique_id(unique_id), parent_scope(parent_scope)
    {
        table.resize(bucket_count);
    }

    // ---- basic getters ----
    scope_table *get_parent_scope() { return parent_scope; }
    int          get_unique_id()    { return unique_id; }

    // ---- lookup ----
    // Search only within THIS scope table. Returns nullptr if not found.
    symbol_info *lookup_in_scope(symbol_info *symbol)
    {
        int bucket = hash_function(symbol->get_name());
        for (symbol_info *s : table[bucket])
            if (s->get_name() == symbol->get_name())
                return s;
        return NULL;
    }

    // Convenience overload that accepts a plain name string.
    symbol_info *lookup_in_scope(const string &name)
    {
        int bucket = hash_function(name);
        for (symbol_info *s : table[bucket])
            if (s->get_name() == name)
                return s;
        return NULL;
    }

    // ---- insert ----
    // Insert into THIS scope only. Returns false (duplicate) if name already exists here.
    bool insert_in_scope(symbol_info *symbol)
    {
        int bucket = hash_function(symbol->get_name());

        // Duplicate check in this scope
        for (symbol_info *s : table[bucket])
            if (s->get_name() == symbol->get_name())
                return false;

        // Store a deep copy so the scope table owns its entries
        symbol_info *copy = new symbol_info(*symbol);
        table[bucket].push_back(copy);
        return true;
    }

    // ---- delete ----
    // Delete by name from THIS scope. Returns false if not found.
    bool delete_from_scope(symbol_info *symbol)
    {
        int bucket = hash_function(symbol->get_name());
        for (auto it = table[bucket].begin(); it != table[bucket].end(); ++it)
        {
            if ((*it)->get_name() == symbol->get_name())
            {
                delete *it;
                table[bucket].erase(it);
                return true;
            }
        }
        return false;
    }

    // ---- print ----
    void print_scope_table(ofstream &outlog)
    {
        outlog << "ScopeTable # " + to_string(unique_id) << endl;

        for (int i = 0; i < bucket_count; i++)
        {
            if (table[i].empty()) continue;

            outlog << i << " --> ";
            bool first = true;
            for (symbol_info *s : table[i])
            {
                if (!first) outlog << " --> ";
                first = false;

                // Format:  < name : KIND data_type [extra info] >
                outlog << "< " << s->get_name() << " : ";

                if (s->is_function())
                {
                    outlog << "FUNCTION"
                           << ", return_type: " << s->get_data_type()
                           << ", #params: "     << s->get_param_count();
                    if (s->get_param_count() > 0)
                    {
                        outlog << " (";
                        const auto &pl = s->get_param_list();
                        for (int j = 0; j < (int)pl.size(); j++)
                        {
                            if (j) outlog << ", ";
                            outlog << pl[j].second;
                            if (!pl[j].first.empty())
                                outlog << " " << pl[j].first;
                        }
                        outlog << ")";
                    }
                }
                else if (s->is_array())
                {
                    outlog << "ARRAY"
                           << ", element_type: " << s->get_data_type()
                           << ", size: "         << s->get_array_size();
                }
                else
                {
                    // plain variable — show its data type if set, else fall back to token type
                    string dt = s->get_data_type();
                    outlog << (dt.empty() ? s->get_type() : dt);
                }

                outlog << " >";
            }
            outlog << endl;
        }
        outlog << endl;
    }

    // ---- destructor ----
    ~scope_table()
    {
        for (int i = 0; i < bucket_count; i++)
            for (symbol_info *s : table[i])
                delete s;
        table.clear();
    }

    // ---- additional helpers (declared "you can add more methods if you need") ----

    // Get a modifiable pointer to the stored entry (used by syntax analyser to update info).
    symbol_info *get_entry(const string &name)
    {
        return lookup_in_scope(name);
    }
};