%require "3.0"
%language "C++"
%parse-param { DecafLexer& lexer }
%parse-param { YYNODESTATE nodes }
%parse-param { ASTNode* &statements }
%define parse.error verbose 
%define api.value.type variant
%define api.parser.class {DecafParser}
%define api.namespace {Decaf}

%code requires{

    #include <unordered_map>
    #include <vector>
    #include <sstream>

    #include "ast.h"

    namespace Decaf{
        class DecafLexer;
    }
}

%{
    #include <stdio.h>
    #include <iostream>
    #include "tokens.h"
    #include "lexer.h"

    #define yylex(arg) lexer.getNextToken(arg)

    namespace Decaf {
        void Parser::error(const std::string& msg){
            std::cerr << msg << "\n";
        }
    }
%}

%token SHIFTL SHIFTR AND OR ASSIGN LTE GTE EQUAL NEQUAL
%token KW_BOOL KW_BREAK KW_CONTINUE KW_CLASS KW_ELSE KW_EXTENDS
%token KW_FALSE KW_FOR KW_IF KW_INT KW_NEW KW_NULL KW_RETURN
%token KW_TRUE KW_VOID KW_WHILE
%token<int> NUMBER
%token<std::string> IDENT
%token <std::string> STRING

%type<ASTNode*> stmt expr stmt_list

%nonassoc '<' '>' LTE GTE EQUAL NEQUAL
%left '+' '-'
%left '*' '/' '%'

%%

program : KW_CLASS IDENT '{' program_block '}'

program_block : field_decl program_block
              | method_decl program_block
              | %empty

field_decl : type IDENT ASSIGN constant ';'
           | type multiple_decl ';'

multiple_decl : multiple_decl ',' IDENT
              | IDENT

method_decl : type IDENT '(' params ')' block
            | KW_VOID IDENT '(' params ')' block

type : KW_INT 
     | KW_BOOL

var_decl : type multiple_decl ';'

statement : IDENT ASSIGN expr
          | IDENT '(' call_params ')'
          | method_call

method_call : PRINT 

block : '{' block_body '}'

block_body : var_decl block_body
           | statement block_body
           | %empty

input : stmt_list optional_eol { statements = $1; }
;

optional_eol : Eol
             | %empty
;

stmt_list : stmt_list Eol stmt { $$ = nodes.stmt_blockCreate($1, $3); }
          | stmt { $$ = $1; }
          | %empty { $$ = nodes.empty_nodeCreate(); }
;

stmt : PRINT expr { $$ = nodes.printCreate($2); }
     | IDENT ASSIGN expr { $$ = nodes.assignCreate($1, $3); }
     | IF expr THEN Eol stmt_list Eol ELSE stmt_list Eol ENDIF { $$ = nodes.ifStmtCreate($2, $5, $8); }
     | WHILE expr DO Eol stmt_list Eol ENDWHILE { $$ = nodes.while_stmtCreate($2, $5); }
;

expr : expr '+' expr { $$ = nodes.plusCreate($1, $3); }
     | expr '-' expr { $$ = nodes.minusCreate($1, $3); }
     | expr '*' expr { $$ = nodes.multiplyCreate($1, $3); }
     | expr '/' expr { $$ = nodes.divideCreate($1, $3); }
     | expr '<' expr { $$ = nodes.lessCreate($1, $3); }
     | expr '>' expr { $$ = nodes.greaterCreate($1, $3); }
     | expr LTE expr { $$ = nodes.lteCreate($1, $3); }
     | expr GTE expr { $$ = nodes.gteCreate($1, $3); }
     | expr EQUAL expr { $$ = nodes.equalCreate($1, $3); }
     | expr NEQUAL expr { $$ = nodes.nequalCreate($1, $3); }
     | '(' expr ')' { $$ = $2; }
     | NUMBER { $$ = nodes.intnumCreate($1);}
     | IDENT { $$ = nodes.idCreate($1); }
     | STRING { $$ = nodes.strCreate($1); }

;

%%