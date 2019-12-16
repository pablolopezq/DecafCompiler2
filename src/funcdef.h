#if !defined(FUNCDEF)
#define FUNCDEF

#include <string>
#include <unordered_map>

#include "decaf_cfg.h"

class FuncDef {

using CFGTuple = std::pair<CFG::Node*, CFG::Node*>;

public:
    FuncDef(std::string name, CFGTuple cfg)
    : name(name), cfg(cfg){}

    int getNumParams(){
        return params.size();
    }

    std::string getName(){
        return name;
    }

    CFGTuple getCFG(){
        return cfg;
    }

private:
    std::string name; 
    std::vector<CFG::Operand*> params;
    CFGTuple cfg;

};

#endif // FUNCDEF
