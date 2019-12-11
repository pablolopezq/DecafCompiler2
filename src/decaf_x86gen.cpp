#include "decaf_x86gen.h"

std::string GenX86::Visitor::visit(IntOperand * node){
    return node->toString();
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

std::string GenX86::Visitor::visit(AddExpr * node){
    std::string ret;

    ret = "move eax, " + visit(node->op1) + "\nadd eax, " + visit(node->op2) + "\n"; 

    return ret;
}

std::string GenX86::Visitor::visit(SubExpr * node){
    std::string ret;

    ret = "move eax, " + node->op1->toString() + "\nsub eax, " + node->op2->toString() + "\n"; 

    return ret;
}

std::string GenX86::Visitor::visit(MultExpr * node){
    std::string ret;

    ret = "move eax, " + node->op1->toString() + "\nmult eax, " + node->op2->toString() + "\n"; 

    return ret;
}

std::string GenX86::Visitor::visit(DivExpr * node){
    std::string ret;

    ret = "move eax, " + node->op1->toString() + "cdq\nmov ecx, " + node->op2->toString() + "\nidiv";

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

std::string GenX86::Visitor::visit(AssignStatement * node){
    std::string ret;

    ret = visit(node->expr) + "\nmov [ebp-" + std::to_string(get_offset(node->ident)) + "], eax\n";

    return ret;
}

std::string GenX86::Visitor::visit(RetStatement * node){
    return "jmp " + func.getName() + "_end\n";
}

std::string GenX86::Visitor::visit(IfStatement * node){
    return visit(node->expr) + getJmp(node->expr) + " " + ;
}