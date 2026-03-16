#include "scope_table.h"

class symbol_table
{
private:
    scope_table *current_scope;
    int bucket_count;
    int current_scope_id;   // monotonically increasing; gives each scope a unique id

public:
    // ---- constructor / destructor ----

    symbol_table(int bucket_count)
        : bucket_count(bucket_count), current_scope(NULL), current_scope_id(0)
    {}

    ~symbol_table()
    {
        // Pop and free every remaining scope
        while (current_scope != NULL)
        {
            scope_table *temp = current_scope;
            current_scope = current_scope->get_parent_scope();
            delete temp;
        }
    }

    // ---- scope management ----

    // Create a new scope table and push it on top of the stack.
    void enter_scope()
    {
        current_scope_id++;
        scope_table *new_scope = new scope_table(bucket_count, current_scope_id, current_scope);
        current_scope = new_scope;
    }

    // Print the current scope table, then pop and destroy it.
    void exit_scope()
    {
        if (current_scope == NULL) return;

        scope_table *temp = current_scope;
        current_scope = current_scope->get_parent_scope();
        delete temp;
    }

    // ---- insert / remove in current scope ----

    bool insert(symbol_info *symbol)
    {
        if (current_scope == NULL) return false;
        return current_scope->insert_in_scope(symbol);
    }

    bool remove(symbol_info *symbol)
    {
        if (current_scope == NULL) return false;
        return current_scope->delete_from_scope(symbol);
    }

    // ---- lookup: search from current scope upward ----

    symbol_info *lookup(symbol_info *symbol)
    {
        scope_table *scope = current_scope;
        while (scope != NULL)
        {
            symbol_info *found = scope->lookup_in_scope(symbol->get_name());
            if (found != NULL) return found;
            scope = scope->get_parent_scope();
        }
        return NULL;
    }

    // Convenience overload accepting a plain name string.
    symbol_info *lookup(const string &name)
    {
        scope_table *scope = current_scope;
        while (scope != NULL)
        {
            symbol_info *found = scope->lookup_in_scope(name);
            if (found != NULL) return found;
            scope = scope->get_parent_scope();
        }
        return NULL;
    }

    // ---- print helpers ----

    void print_current_scope(ofstream &outlog)
    {
        if (current_scope != NULL)
            current_scope->print_scope_table(outlog);
    }

    // Overload without argument kept for callers that don't pass the stream.
    void print_current_scope()
    {
        // No-op variant; callers should prefer the ofstream overload.
    }

    void print_all_scopes(ofstream &outlog)
    {
        outlog << "################################" << endl << endl;
        scope_table *temp = current_scope;
        while (temp != NULL)
        {
            temp->print_scope_table(outlog);
            temp = temp->get_parent_scope();
        }
        outlog << "################################" << endl << endl;
    }

    // ---- additional helpers ----

    scope_table *get_current_scope() { return current_scope; }
    int          get_current_scope_id() { return current_scope_id; }
};