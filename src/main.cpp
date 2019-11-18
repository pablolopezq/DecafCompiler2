#include <iostream>
#include <fstream>

#include "tokens.h"
#include "ast.h"
#include "lexer.h"

int main(int argc, char * argv[]){

    std::filebuf fb;
    if(fb.open(argv[1], std::ios::in)){
        std::istream in(&fb);
        Lexer lexer(in);

        YYNODESTATE nodes;
        ASTNode * statements;

        std::unordered_map<std::string, int> vars;

        Expr::Parser parser(lexer, nodes, statements);

        parser.parse();

        // std::cout << "Parsed and created AST\n";

        // if(statements->isA(print_kind)){
        //     std::cout << "print node\n";
        // }
        
        // std::cout << "Executing...\n";

        statements->exec(vars);

        // std::cout << "Execution done\n";

        fb.close();
    }

    return 0;
}