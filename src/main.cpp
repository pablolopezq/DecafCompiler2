#include <iostream>
#include <fstream>

#include "decaf_tokens.h"
#include "decaf_ast.h"
#include "decaf_lexer.h"
#include "decaf_cfg.h"

int main(int argc, char * argv[]){

    CFG::Node * node1 = new CFG::Node("n1");
    CFG::Node * node2 = new CFG::Node("n2");
    CFG::Node * node3 = new CFG::Node("n3");
    CFG::Node * node4 = new CFG::Node("n4");   

    CFG::IntOperand * op1 = new CFG::IntOperand(3);
    CFG::IntOperand * op2 = new CFG::IntOperand(6);
    CFG::IntOperand * op3 = new CFG::IntOperand(8);
    CFG::IntOperand * op4 = new CFG::IntOperand(53);
    CFG::IntOperand * op5 = new CFG::IntOperand(1);

    CFG::IDOperand * op6 = new CFG::IDOperand("x");
    CFG::IDOperand * op7 = new CFG::IDOperand("y");
    CFG::IDOperand * op8 = new CFG::IDOperand("z");

    CFG::AddExpr * expr1 = new CFG::AddExpr(op1, op6);
    CFG::SubExpr * expr2 = new CFG::SubExpr(op2, op7);
    CFG::MultExpr * expr3 = new CFG::MultExpr(op3, op4);
    CFG::DivExpr * expr4 = new CFG::DivExpr(op5, op8);
    CFG::AddExpr * expr5 = new CFG::AddExpr(op1, op8);
    CFG::DivExpr * expr6 = new CFG::DivExpr(op7, op4);

    CFG::AssignStatement * stmt1 = new CFG::AssignStatement("x", expr4);
    CFG::AssignStatement * stmt2 = new CFG::AssignStatement("y", expr1);
    CFG::AssignStatement * stmt3 = new CFG::AssignStatement("z", expr3);
    CFG::AssignStatement * stmt4 = new CFG::AssignStatement("x", expr6);
    CFG::AssignStatement * stmt5 = new CFG::AssignStatement("z", expr2);
    CFG::AssignStatement * stmt6 = new CFG::AssignStatement("x", expr5);

    CFG::CallStatement * stmt7 = new CFG::CallStatement("foo", 2);
    CFG::CallStatement * stmt8 = new CFG::CallStatement("red", 1);

    // std::cout << stmt1->toString() << std::endl;
    // std::cout << stmt2->toString() << std::endl;
    // std::cout << stmt3->toString() << std::endl;
    // std::cout << stmt4->toString() << std::endl;
    // std::cout << stmt5->toString() << std::endl;
    // std::cout << stmt6->toString() << std::endl;
    // std::cout << stmt7->toString() << std::endl;
    // std::cout << stmt8->toString() << std::endl;

    node1->addStatement(stmt1);
    node1->addStatement(stmt7);

    node2->addStatement(stmt6);
    node2->addStatement(stmt2);
    
    node3->addStatement(stmt3);
    node3->addStatement(stmt4);

    node4->addStatement(stmt8);
    node4->addStatement(stmt3);

    CFG::SingleEdge * edge1 = new CFG::SingleEdge(node2);
    CFG::DoubleEdge * edge2 = new CFG::DoubleEdge(node3, node4);

    node1->setEdge(edge1);
    node2->setEdge(edge2);
    
    node1->printCFG();

    std::filebuf fb;
    if(fb.open(argv[1], std::ios::in)){
        std::istream in(&fb);
        DecafLexer lexer(in);

        YYNODESTATE nodes;
        // ASTNode * statements;

        // std::unordered_map<std::string, int> vars;

        // Expr::Parser parser(lexer, nodes, statements);
        Decaf::DecafParser parser(lexer, nodes);

        parser.parse();

        // std::cout << "Parsed and created AST\n";

        // if(statements->isA(print_kind)){
        //     std::cout << "print node\n";
        // }
        
        // std::cout << "Executing...\n";

        // statements->exec(vars);

        // std::cout << "Execution done\n";

        fb.close();
    }

    return 0;
}