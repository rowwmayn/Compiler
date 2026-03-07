#include<bits/stdc++.h>
using namespace std;

class symbol_info
{
private:
    string name;
    string type;

    // What kind of symbol it is: "variable", "array", "function"
    string symbol_kind;

    // Data type for variables/arrays, return type for functions: "int", "float", "void"
    string data_type;

    // Array size (only used when symbol_kind == "array")
    int array_size;

    // Function parameters stored as <param_name, param_type>
    // param_name may be "" for unnamed parameters
    vector<pair<string, string>> param_list;

public:
    symbol_info(string name, string type)
    {
        this->name        = name;
        this->type        = type;
        this->symbol_kind = "";
        this->data_type   = "";
        this->array_size  = 0;
    }

    // ---- basic getters / setters (kept exactly as provided) ----
    string get_name() { return name; }
    string getname()  { return name; }   // alias used by syntax_analyser.y
    string get_type() { return type; }

    void set_name(string name) { this->name = name; }
    void set_type(string type) { this->type = type; }

    // ---- symbol kind ----
    void   set_symbol_kind(string kind) { symbol_kind = kind; }
    string get_symbol_kind()            { return symbol_kind; }
    bool   is_variable()  { return symbol_kind == "variable"; }
    bool   is_array()     { return symbol_kind == "array"; }
    bool   is_function()  { return symbol_kind == "function"; }

    // ---- data type / return type ----
    void   set_data_type(string dt) { data_type = dt; }
    string get_data_type()          { return data_type; }

    // ---- array size ----
    void set_array_size(int sz) { array_size = sz; }
    int  get_array_size()       { return array_size; }

    // ---- function parameters ----
    void add_param(string param_name, string param_type)
    {
        param_list.push_back({param_name, param_type});
    }
    void set_param_list(const vector<pair<string, string>>& pl)
    {
        param_list = pl;
    }
    const vector<pair<string, string>>& get_param_list() { return param_list; }
    int get_param_count() { return (int)param_list.size(); }

    ~symbol_info()
    {
        // All members are value types; nothing to manually free.
    }
};