#if !defined(CFG)
#define CFG

#include <iostream>
#include <vector>

namespace CFG
{
    
constexpr char addop[] = "+";
constexpr char subop[] = "-";
constexpr char multop[] = "*";
constexpr char divop[] = "/";
constexpr char greaterop[] = ">";
constexpr char lessop[] = "<";
constexpr char gteop[] = ">=";
constexpr char lteop[] = "<=";
constexpr char equalop[] = "==";
constexpr char nequalop[] = "!=";

enum class NodeKind {
    Expr,
    UnaryExpr,
    AddExpr,
    SubExpr,
    MultExpr,
    DivExpr,
    GreaterExpr,
    LessExpr,
    GTEExpr,
    LTEExpr,
    EqualExpr,
    NequalExpr,
    Statement,
    IntOperand,
    IDOperand,
    ExprStatement,
    AssignStatement,
    CallStatement,
    RetStatement,
    NopStatement,
    LValueOperand,
    StringOperand,
    NopNode,
    IfStatement,
    ParamStatement,
    Node,
    BoolOperand,
};

class Base {

public:
    virtual std::string toString() = 0;
    virtual NodeKind getKind() = 0;
};

class Expr : public Base {};

class Operand : public Base {};

class IDOperand : public Operand {

public:
    IDOperand(std::string val) : val(val) {}

    std::string val;

    std::string toString() {
        return val;
    }

    NodeKind getKind(){
        return NodeKind::IDOperand;
    }
};

class StringOperand : public Operand {

public:
    StringOperand(std::string val) : val(val) {}

    std::string val;

    std::string toString() {
        return val;
    }

    NodeKind getKind(){
        return NodeKind::StringOperand;
    }
};

class LValueOperand : public Operand {

public:
    LValueOperand(std::string val) : val(val) {}

    std::string val;

    std::string toString() {
        return val;
    }

    NodeKind getKind(){
        return NodeKind::LValueOperand;
    }
};

class IntOperand : public Operand {

public:
    IntOperand(int val) : val(val) {}

    int val;

    std::string toString() {
        return std::to_string(val);
    }

    NodeKind getKind(){
        return NodeKind::IntOperand;
    }
};

class BoolOperand : public Operand {

public:
    BoolOperand(int val) : val(val) {}

    int val;

    std::string toString() {
        return std::to_string(val);
    }

    NodeKind getKind(){
        return NodeKind::BoolOperand;
    }
};

class UnaryExpr : public Expr {

public:
    UnaryExpr(Operand * op) : op(op) {}

    Operand * op;

    std::string toString() {
        return op->toString();
    }

    NodeKind getKind(){
        return NodeKind::UnaryExpr;
    }
};

template<const char * op, NodeKind kind>
class BinaryExpr : public Expr {

public:
    BinaryExpr(Operand * op1, Operand * op2) : op1(op1), op2(op2) {}

    Operand * op1;
    Operand * op2;
    
};

class AddExpr : public BinaryExpr<addop, NodeKind::AddExpr> {

public:
    AddExpr(Operand * op1, Operand * op2) : BinaryExpr(op1, op2) {}

    std::string toString() {
        return op1->toString() + addop + op2->toString();
    }

    NodeKind getKind(){
        return NodeKind::AddExpr;
    }
};

class SubExpr : public BinaryExpr<subop, NodeKind::SubExpr> {

public:
    SubExpr(Operand * op1, Operand * op2) : BinaryExpr(op1, op2) {}

    std::string toString() {
        return op1->toString() + subop + op2->toString();
    }

    NodeKind getKind() { return NodeKind::SubExpr; }
};

class MultExpr : public BinaryExpr<multop, NodeKind::MultExpr> {

public:
    MultExpr(Operand * op1, Operand * op2) : BinaryExpr(op1, op2) {}

    std::string toString() {
        return op1->toString() + multop + op2->toString();
    }

    NodeKind getKind(){
        return NodeKind::MultExpr;
    }
};

class DivExpr : public BinaryExpr<divop, NodeKind::DivExpr> {

public:
    DivExpr(Operand * op1, Operand * op2) : BinaryExpr(op1, op2) {}

    std::string toString() {
        return op1->toString() + divop + op2->toString();
    }

    NodeKind getKind(){
        return NodeKind::DivExpr;
    }
};

class GreaterExpr : public BinaryExpr<greaterop, NodeKind::GreaterExpr> {

public:
    GreaterExpr(Operand * op1, Operand * op2) : BinaryExpr(op1, op2) {}

    std::string toString() {
        return op1->toString() + greaterop + op2->toString();
    }

    NodeKind getKind(){
        return NodeKind::GreaterExpr;
    }
};

class LessExpr : public BinaryExpr<lessop, NodeKind::LessExpr> {

public:
    LessExpr(Operand * op1, Operand * op2) : BinaryExpr(op1, op2) {}

    std::string toString() {
        return op1->toString() + lessop + op2->toString();
    }

    NodeKind getKind(){
        return NodeKind::LessExpr;
    }
};

class GTEExpr : public BinaryExpr<gteop, NodeKind::GTEExpr> {

public:
    GTEExpr(Operand * op1, Operand * op2) : BinaryExpr(op1, op2) {}

    std::string toString() {
        return op1->toString() + gteop + op2->toString();
    }

    NodeKind getKind(){
        return NodeKind::GTEExpr;
    }
};

class LTEExpr : public BinaryExpr<lteop, NodeKind::LTEExpr> {

public:
    LTEExpr(Operand * op1, Operand * op2) : BinaryExpr(op1, op2) {}

    std::string toString() {
        return op1->toString() + lteop + op2->toString();
    }

    NodeKind getKind(){
        return NodeKind::LTEExpr;
    }
};

class EqualExpr : public BinaryExpr<equalop, NodeKind::EqualExpr> {

public:
    EqualExpr(Operand * op1, Operand * op2) : BinaryExpr(op1, op2) {}

    std::string toString() {
        return op1->toString() + equalop + op2->toString();
    }

    NodeKind getKind(){
        return NodeKind::EqualExpr;
    }
};

class NequalExpr : public BinaryExpr<nequalop, NodeKind::NequalExpr> {

public:
    NequalExpr(Operand * op1, Operand * op2) : BinaryExpr(op1, op2) {}

    std::string toString() {
        return op1->toString() + nequalop + op2->toString();
    }

    NodeKind getKind(){
        return NodeKind::NequalExpr;
    }
};

class Statement : public Base {

public:
    Statement(){}
    std::string toString(){}
};

class ExprStatement : public Statement{

public:
    ExprStatement(Expr * expr) : expr(expr) {}

    std::string toString() {
        return expr->toString();
    }

    NodeKind getKind(){
        return NodeKind::ExprStatement;
    }

    Expr * expr;

};

class AssignStatement : public Statement {

public:
    AssignStatement(IDOperand * ident, Expr * expr) : ident(ident), expr(expr) {}

    std::string toString() {
        return ident->toString() + " = " + expr->toString();
    }

    NodeKind getKind(){
        return NodeKind::AssignStatement;
    }

    IDOperand * ident;
    Expr * expr;
};

class ParamStatement : public Statement {

public:
    ParamStatement(Operand * operand) : op(operand) {}

    std::string toString(){
        return "param " + op->toString();
    }

    NodeKind getKind(){
        return NodeKind::ParamStatement;
    }

    Operand * op;

};

class CallStatement : public Statement {

public:
    CallStatement(std::string func_name, int num_params) : func_name(func_name), num_params(num_params) {}

    std::string toString() {
        return "call " + func_name + " " + std::to_string(num_params);
    }

    NodeKind getKind(){
        return NodeKind::CallStatement;
    }

    std::string func_name;
    int num_params;
};

class RetStatement : public Statement {

public:
    RetStatement(){}

    NodeKind getKind(){
        return NodeKind::RetStatement;
    }
};

class NopStatement : public Statement {

public:
    NopStatement(){}

    NodeKind getKind(){
        return NodeKind::NopStatement;
    }
};

class Edge {

public:
    Edge(){}
    virtual void printNodes() = 0;
    virtual bool isSingle() = 0;
};

class Node {

public:
    Node(){}

    void addStatement(Statement * stmt){
        this->stmt = stmt;
        // std::cout << stmt->toString() << std::endl;
        this->statements.push_back(stmt);
    }

    void setEdge(Edge * edge){
        this->edge = edge;
    }

    void setLabel(std::string label){
        this->label = label;
    }

    std::string getLabel(){
        return this->label;
    }

    Edge * getEdge(){
        return this->edge;
    }

    void printStatements() {
        for(int i = 0; i < statements.size(); i++){
            std::cout << statements.at(i)->toString() << std::endl;
        }
    }

    void printCFG(){
        printStatements();
        if(edge != nullptr)
            edge->printNodes();
    }

    NodeKind getKind(){
        return NodeKind::Node;
    }

    void setNop(){
        nop = true;
    }

    bool isNop(){
        return nop;
    }

    bool nop;
    std::string label;
    Edge * edge;
    Statement * stmt;
    std::vector<Statement*> statements;
};

class SingleEdge : public Edge {

public:
    SingleEdge(Node * next) : next(next) {}

    void printNodes(){
        next->printCFG();
    }

    bool isSingle(){
        return true;
    }

    Node * next;
};
class DoubleEdge : public Edge {

public:
    DoubleEdge(Node * tnode, Node * fnode) : tnode(tnode), fnode(fnode) {}

    void printNodes(){
        tnode->printCFG();
        fnode->printCFG();
    }

    bool isSingle(){
        return false;
    }

    Expr * condition;
    Node * tnode;
    Node * fnode;
};

} // namespace CFG

#endif // CFG

