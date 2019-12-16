#if !defined(x86GEN)
#define x86GEN

#include <iostream>
#include <queue>
#include <algorithm>

#include "funcdef.h"

#define HANDLE_NODE(kind)\
case NodeKind::kind:\
return visit(reinterpret_cast<kind*>(stmt));\
break;

class GenX86 {

public:
    GenX86(std::ostream & out) : out(out) {}

    void write(std::vector<FuncDef*> funcs){

        LiteralTable table;

        out << "global main\n extern printf\n";

        out << "section .text\n";

        for(auto f : funcs){

            int num_params = f->getNumParams();

            out << f->getName() << ":\n";

            out << "push ebp\nmov ebp, esp\n" <<
                    "add esp, " << std::to_string(num_params*4) << "\n";

            /* generar codigo de f */
            gen_asm(*f, table); 

            out << f->getName() << "_end:\n";
            out << "leave\n ret\n";

        }
        std::unordered_map<std::string, std::string> lits = table.getTable();
            
        out <<"section .data\n";
        for (auto& str: lits) {
            out << str.second << ": db \'" << str.first << "\', 10, 0\n";
        }
    }

private:
    std::ostream & out;

    class LiteralTable {

    public:

        LiteralTable() : str_counter(0) {}

        std::string addString(std::string str){
            std::unordered_map<std::string, std::string>::const_iterator it = literals.find(str);

            if(it == literals.end()){
                std::string lbl = "SL" + std::to_string(str_counter++);
                literals.emplace(str, lbl);
                return lbl;
            }
            else{
                return it->second;
            }
        }

        std::string getLabel(std::string str){
            std::unordered_map<std::string, std::string>::const_iterator it = literals.find(str);
            if(it != literals.end()){
                return it->second;
            }
            else{
                return this->addString(str);
            }
        }

        std::unordered_map<std::string, std::string> getTable(){
            return literals;
        }

    private:
        std::unordered_map<std::string, std::string> literals; // llave es string, segundo valor es label
        int str_counter;
    };

    class Visitor {
    
    public:
        Visitor(LiteralTable & table, FuncDef f)
        : table(table), func(f) {}

        std::string visit(Base * stmt){
            NodeKind kind = stmt->getKind();
            switch(kind){
                HANDLE_NODE(IDOperand);
                HANDLE_NODE(StringOperand);
                HANDLE_NODE(IntOperand);
                HANDLE_NODE(AddExpr);
                HANDLE_NODE(SubExpr);
                HANDLE_NODE(MultExpr);
                HANDLE_NODE(DivExpr);
                HANDLE_NODE(GreaterExpr);
                HANDLE_NODE(LessExpr);
                HANDLE_NODE(GTEExpr);
                HANDLE_NODE(LTEExpr);
                HANDLE_NODE(EqualExpr);
                HANDLE_NODE(NequalExpr);
                HANDLE_NODE(AssignStatement);
                HANDLE_NODE(CallStatement);
                HANDLE_NODE(ParamStatement);
                HANDLE_NODE(RetStatement);
                HANDLE_NODE(NopStatement);
                
                default:
                    std::cout << "no visit for node\n";
                    break;
            }
        }
        
        std::string visit(SingleEdge * edge);
        std::string visit(DoubleEdge * edge);

        void setCurrentNode(Node * node){
            current_node = node;
        }

    private:

        LiteralTable & table;
        FuncDef func;
        Node * current_node;
        std::vector<std::string> vars;

        int get_offset(std::string val){
            std::vector<std::string>::iterator it;
            it = find(vars.begin(), vars.end(), val);
            if(it != vars.end()){
                int index = std::distance(vars.begin(), it);
                int stack_pos = index*4;
                return stack_pos;
            }
            else{
                vars.push_back(val);
                return get_offset(val);
            }
        }

        std::string visit(CFG::IntOperand * node);
        std::string visit(IDOperand * node);
        std::string visit(StringOperand * node);
        std::string visit(AddExpr * node);
        std::string visit(SubExpr * node);
        std::string visit(MultExpr * node);
        std::string visit(DivExpr * node);
        std::string visit(GreaterExpr * stmt);
        std::string visit(LessExpr * stmt);
        std::string visit(GTEExpr * stmt);
        std::string visit(LTEExpr * stmt);
        std::string visit(EqualExpr * stmt);
        std::string visit(NequalExpr * stmt);
        std::string visit(AssignStatement * stmt);
        std::string visit(CallStatement * stmt);
        std::string visit(ParamStatement * stmt);
        std::string visit(RetStatement * stmt);
        std::string visit(NopStatement * stmt);

        std::string getJmp(Expr * expr){
            switch(expr->getKind()){
                case NodeKind::AddExpr: return "je";
                case NodeKind::SubExpr: return "je";
                case NodeKind::MultExpr: return "je";
                case NodeKind::DivExpr: return "je";
                case NodeKind::GreaterExpr: return "jg";
                case NodeKind::GTEExpr: return "jge";
                case NodeKind::LessExpr: return "jl";
                case NodeKind::LTEExpr: return "jle";
                case NodeKind::EqualExpr: return "je";
                case NodeKind::NequalExpr: return "jne";
                default: return "";
            }
        }

    };

    void gen_asm(FuncDef & func, LiteralTable & table){

        std::vector<Node*> visited;
        std::queue<Node*> queue;

        func.getCFG().second->setEdge(nullptr);
        // func.getCFG().second->setLabel("last");

        queue.push(func.getCFG().first);

        Visitor visitor(table, func);

        std::cout << func.getName() << ":\n";
    
        while(true){

            if(queue.empty()){
                break;
            }

            Node * current_node = queue.front();

            // std::cout << current_node->getLabel() << std::endl;
            // current_node->printStatements();

            queue.pop();

            if(current_node->label != "nop"){
                std::cout << current_node->getLabel() + ":\n";
                out << current_node->getLabel() + ":\n";
            }
            
            std::vector<Node*>::iterator it = find(visited.begin(), visited.end(), current_node);
            if(it == visited.end()){
                visitor.setCurrentNode(current_node);
                for(auto stmt : current_node->statements){
                    std::cout << visitor.visit(stmt) << std::endl;
                    out << visitor.visit(stmt);
                }
                visited.push_back(current_node);
                if(current_node->getEdge() == nullptr){
                    continue;
                }
                Edge * edge = current_node->getEdge();
                    
                if(edge->isSingle()){
                    /* add single node */
                    SingleEdge * se = reinterpret_cast<SingleEdge*>(edge);
                    // if(se->next == nullptr){
                    //     std::cout << "b\n";
                    // }
                    // std::cout << se->next->label << std::endl;
                    if(se->next->label != "nop"){
                        std::cout << visitor.visit(se) << std::endl;
                        out << visitor.visit(se);
                    }
                    queue.push(se->next);
                }
                else{
                    /* add both nodes */
                    // std::cout << "adding double edge\n";
                    DoubleEdge * de = reinterpret_cast<DoubleEdge*>(edge);
                    
                    std::cout << visitor.visit(de) << std::endl;
                    out << visitor.visit(de);
                    if(de->tnode->getKind() != NodeKind::NopNode)
                        queue.push(de->tnode);
                    if(de->fnode->getKind() != NodeKind::NopNode)
                        queue.push(de->fnode);
                }
            }
        }
        // std::cout << "done with func\n";
    }
};

#include "decaf_x86gen.cpp"

#endif // x86GEN
