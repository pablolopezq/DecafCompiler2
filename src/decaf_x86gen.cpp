#include "decaf_x86gen.h"

std::string GenX86::Visitor::visit(CFG::IntOperand * node){
    return node->toString();
}

std::string GenX86::Visitor::visit(CFG::StringOperand * node){
    std::string val = node->toString();
    val.erase(0,1);
    val.erase(val.size() - 1);
    std::string label = this->table.getLabel(val);
    return label;
}

std::string GenX86::Visitor::visit(IDOperand * node){
    std::string val = node->toString();
    std::vector<std::string>::iterator it;

    it = find(vars.begin(), vars.end(), val);
    if(it != vars.end()){
        int index = std::distance(vars.begin(), it);
        int stack_pos = index*4;
        return "[ebp-" + std::to_string(stack_pos) + "]";
    }
    else{
        vars.push_back(val);
        return visit(node);
    }
}

std::string GenX86::Visitor::visit(CFG::LValueOperand * node){
    return node->toString();
}

std::string GenX86::Visitor::visit(AddExpr * node){
    std::string ret;

    ret = "mov eax, " + visit(node->op1) + "\nadd eax, " + visit(node->op2) + "\n"; 

    return ret;
}

std::string GenX86::Visitor::visit(SubExpr * node){
    std::string ret;

    ret = "mov eax, " + node->op1->toString() + "\nsub eax, " + node->op2->toString() + "\n"; 

    return ret;
}

std::string GenX86::Visitor::visit(MultExpr * node){
    std::string ret;

    ret = "mov eax, " + node->op1->toString() + "\ncdq\nmov ecx, " + node->op2->toString() + "\nimul ecx\n"; 

    return ret;
}

std::string GenX86::Visitor::visit(DivExpr * node){
    std::string ret;

    ret = "mov eax, " + node->op1->toString() + "\ncdq\nmov ecx, " + node->op2->toString() + "\nidiv ecx\n";

    return ret;
}

std::string GenX86::Visitor::visit(GreaterExpr * node){
    std::string ret;

    ret = "mov eax, " + visit(node->op1) + "\ncmp eax, " + visit(node->op2) + "\nsetg bl\n";

    return ret;
}

std::string GenX86::Visitor::visit(LessExpr * node){
    std::string ret;

    ret = "mov eax, " + visit(node->op1) + "\ncmp eax, " + visit(node->op2) + "\nsetl bl\n";

    return ret;
}

std::string GenX86::Visitor::visit(GTEExpr * node){
    std::string ret;

    ret = "mov eax, " + visit(node->op1) + "\ncmp eax, " + visit(node->op2) + "\nsetge bl\n";

    return ret;
}

std::string GenX86::Visitor::visit(LTEExpr * node){
    std::string ret;

    ret = "mov eax, " + visit(node->op1) + "\ncmp eax, " + visit(node->op2) + "\nsetle bl\n";

    return ret;
}

std::string GenX86::Visitor::visit(EqualExpr * node){
    std::string ret;

    ret = "mov eax, " + visit(node->op1) + "\ncmp eax, " + visit(node->op2) + "\nsete bl\n";

    return ret;
}

std::string GenX86::Visitor::visit(NequalExpr * node){
    std::string ret;

    ret = "mov eax, " + visit(node->op1) + "\ncmp eax, " + visit(node->op2) + "\nsetne bl\n";

    return ret;
}

std::string GenX86::Visitor::visit(ExprStatement * node){
    std::string ret;

    ret = visit(node->expr);

    return ret;
}

std::string GenX86::Visitor::visit(AssignStatement * node){
    std::string ret;

    ret = visit(node->expr) + "\nmov [ebp-" + std::to_string(get_offset(node->ident->toString())) + "], eax\n";

    return ret;
}

std::string GenX86::Visitor::visit(CallStatement * node){
    std::string ret;

    ret = "call " + node->func_name + "\n";

    return ret;
}

std::string GenX86::Visitor::visit(ParamStatement * node){
    std::string ret;

    ret = "push " + visit(node->op) + "\n";

    return ret;
}

std::string GenX86::Visitor::visit(NopStatement * node){
    return "nop";
}

std::string GenX86::Visitor::visit(RetStatement * node){
    return "jmp " + func.getName() + "_end\n";
}

std::string GenX86::Visitor::visit(SingleEdge * edge){
    return "jmp " + edge->next->label + "\n";
}

std::string GenX86::Visitor::visit(DoubleEdge * edge){

    std::string ret = "";

    ret = visit(edge->condition) + getJmp(edge->condition) + edge->tnode->label + "\njmp " + edge->fnode->label + "\n";
    
    return ret;
}