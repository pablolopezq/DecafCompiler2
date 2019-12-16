%require "3.0"
%language "C++"
%parse-param { DecafLexer& lexer }
%parse-param { YYNODESTATE nodes }
%parse-param { std::vector<FuncDef*> &funcs }
%define parse.error verbose
%define api.value.type variant
%define api.parser.class {DecafParser}
%define api.namespace {Decaf}

%code requires{

    #include <unordered_map>
    #include <vector>
    #include <sstream>

    #include "decaf_ast.h"

    class DecafLexer;
}

%{
    #include <stdio.h>
    #include <iostream>
    #include "decaf_lexer.h"
    #include "decaf_ast.h"
    #include "decaf_tokens.h"
    #include "funcdef.h"

    #define yylex(arg) lexer.getNextToken(arg)

    namespace Decaf {
        void DecafParser::error(const std::string& msg){
            std::cerr << msg << "\n";
        }
    }
%}

%token SHIFTL SHIFTR AND OR ASSIGN LTE GTE EQUAL NEQUAL Eof
%token KW_BOOL KW_BREAK KW_CONTINUE KW_CLASS KW_ELSE KW_EXTENDS
%token KW_FALSE KW_FOR KW_IF KW_INT KW_NEW KW_NULL KW_RETURN
%token KW_TRUE KW_VOID KW_WHILE PRINT PRINTLN READ RANDOMINT
%token<int> NUMBER
%token<std::string> IDENT
%token <std::string> STRING
%token <std::string> CHAR_CONST

%type<expression*> expr constant
%type<statement*> system_call stmt var_decl block_body block
%type<statement*> field_decl method_decl decl
%type<std::vector<statement*>> params program_block
%type<std::vector<std::string>> multiple_decl
%type<type_code> type

%nonassoc '<' '>' LTE GTE EQUAL NEQUAL
%left '+' '-'
%left '*' '/' '%'

%%

program : KW_CLASS IDENT '{' program_block '}' { std::cout << "Parsed successfully\n"; 
                                                
                                                FuncDef * fd;

                                                for(auto s : $4){
                                                    //std::cout << s->toString();
                                                    method_declaration * md = dynamic_cast<method_declaration*>(s);
                                                    if(md != nullptr){
                                                        fd = md->genFunc();
                                                        funcs.push_back(fd);
                                                    }
                                                    
                                                }
                                               }
;

program_block : program_block method_decl { $1.push_back($2); $$ = $1; }
              | program_block field_decl {  }
              | %empty { $$.push_back(nodes.empty_nodeCreate()); }
;

field_decl : type IDENT ASSIGN constant ';' {  $$ = nodes.field_assignCreate($1, $2, $4); }
           | type multiple_decl ';' { $$ = nodes.field_declarationCreate($1, $2); }
;

type : KW_INT  {  $$ = int_type;  }
     | KW_BOOL {  $$ = bool_type;  }
;

multiple_decl : multiple_decl ',' IDENT {  $1.push_back($3); $$ = $1;  }
              | IDENT {  $$.push_back($1);  }
;

constant : NUMBER {  $$ = nodes.intnumCreate($1);  }
         | CHAR_CONST {  $$ = nodes.strCreate($1);  }
         | KW_FALSE {  $$ = nodes.bool_exprCreate(0);  }
         | KW_TRUE {  $$ = nodes.bool_exprCreate(1);  }
;

method_decl : type IDENT '(' params ')' block {  $$ = nodes.method_declarationCreate($1, $2, $4, $6); }
            | KW_VOID IDENT '(' params ')' block {  $$ = nodes.method_declarationCreate(void_type, $2, $4, $6); }
;

params : decl ',' params {  $3.push_back($1); $$ = $3;  }
       | decl {  $$.push_back($1);  }
       | %empty {  $$.push_back(nodes.empty_nodeCreate());  }
;

decl : type IDENT { $$ = nodes.param_declarationCreate($1, $2);  }
;

block : '{' block_body '}' {  $$ = $2;  }
;

block_body : var_decl block_body { $$ = nodes.stmt_blockCreate(nodes.empty_nodeCreate(), $2); std::cout << "vardecl\n";}
           | stmt block_body {  $$ = nodes.stmt_blockCreate($1, $2);  }
           | %empty {  $$ = nodes.empty_nodeCreate();  }
;

var_decl : type multiple_decl ';' { $$ = nodes.field_declarationCreate($1, $2);  }
;

stmt : IDENT ASSIGN expr ';' {  $$ = nodes.assignCreate($1, $3);  }
     | system_call {  $$ = $1;  }
;

system_call : PRINT '(' expr ')' ';' {  $$ = nodes.printCreate($3);  }
            | PRINTLN '(' expr ')' ';' { $$ =  nodes.printlnCreate($3);  }
;

expr : expr '+' expr { $$ = nodes.plusCreate($1, $3);  }
     | expr '-' expr { $$ = nodes.minusCreate($1, $3); }
     | expr '*' expr { $$ = nodes.multiplyCreate($1, $3); }
     | expr '/' expr { $$ = nodes.divideCreate($1, $3); }
     | expr '<' expr { $$ = nodes.lessCreate($1, $3); }
     | expr '>' expr { $$ = nodes.greaterCreate($1, $3); }
     | expr '%' expr { $$ = nodes.modCreate($1, $3); }
     | expr LTE expr { $$ = nodes.lteCreate($1, $3); }
     | expr GTE expr { $$ = nodes.gteCreate($1, $3); }
     | expr EQUAL expr { $$ = nodes.equalCreate($1, $3); }
     | expr NEQUAL expr { $$ = nodes.nequalCreate($1, $3); }
     | '(' expr ')' { $$ = $2; }
     | NUMBER { $$ = nodes.intnumCreate($1);}
     | IDENT { $$ = nodes.idCreate($1) ;std::cout << "id op\n"; }
     | STRING { $$ = nodes.strCreate($1); }
;

%%