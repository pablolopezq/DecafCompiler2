#if !defined(FUNCDEF)
#define FUNCDEF

#include <string>
#include <unordered_map>

#include "build/decaf_ast.h"
#include "decaf_cfg.h"

class FuncDef {

public:
    FuncDef(std::string name, std::unordered_map<type_code, std::string> params, CFG::Node * root)
    : name(name), params(params), root(root){}

    int getNumParams(){
        return params.size();
    }

    std::string getName(){
        return name;
    }

    Node * getRoot(){
        return root;
    }

private:
    std::string name; 
    std::unordered_map<type_code, std::string> params;
    CFG::Node * root;

};

#endif // FUNCDEF
