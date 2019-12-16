%option noyywrap
%option yylineno
%option reentrant

%x BlockComment

%{
    #include <cstdio>
    #include <sstream>
    #include "decaf_lexer.h"
    #include "decaf_tokens.h"

    #define YY_EXTRA_TYPE std::istream*
    #define YY_DECL int DecafLexer::_getNextToken(DecafLexer::semantic_type& yyval, yyscan_t yyscanner)
    #define YY_INPUT(buf, result, max_size)\
    do{\
        std::istream* in = yyget_extra(yyscanner);\
        in->read(buf,max_size);\
        result = in->gcount();\
    }while(0)

%}

DIGIT [0-9]
IDENT [_a-zA-Z][_a-zA-Z0-9]*

%%

"//".*\n /*Nothing*/
"/*" { BEGIN(BlockComment); }

"+"              { return '+'; }
"-"              { return '-'; }
"*"              { return '*'; }
"/"              { return '/'; }
"%"              { return '%'; }
"("              { return '('; }
")"              { return ')'; }
";"              { return ';'; }
","              { return ','; }
"<"              { return '<'; }
">"              { return '>'; }
"{"              { return '{'; }
"}"              { return '}'; }
"["              { return '['; }
"]"              { return ']'; }
"!"              { return '!'; }

"<<"             { return makeToken(yytext, yyleng, token::SHIFTL); }
">>"             { return makeToken(yytext, yyleng, token::SHIFTR); }
"&&"             { return makeToken(yytext, yyleng, token::AND); }
"||"             { return makeToken(yytext, yyleng, token::OR); }
"<="             { return makeToken(yytext, yyleng, token::LTE); }
">="             { return makeToken(yytext, yyleng, token::GTE); }
"=="             { return makeToken(yytext, yyleng, token::EQUAL); }
"!="             { return makeToken(yytext, yyleng, token::NEQUAL); }
"="              { return makeToken(yytext, yyleng, token::ASSIGN); }
"bool"           { return makeToken(yytext, yyleng, token::KW_BOOL); }
"break"          { return makeToken(yytext, yyleng, token::KW_BREAK); }
"continue"       { return makeToken(yytext, yyleng, token::KW_CONTINUE); }
"class"          { return makeToken(yytext, yyleng, token::KW_CLASS); }
"else"           { return makeToken(yytext, yyleng, token::KW_ELSE); }
"extends"        { return makeToken(yytext, yyleng, token::KW_EXTENDS); }
"false"          { return makeToken(yytext, yyleng, token::KW_FALSE); }
"for"            { return makeToken(yytext, yyleng, token::KW_FOR); }
"if"             { return makeToken(yytext, yyleng, token::KW_IF); }
"int"            { return makeToken(yytext, yyleng, token::KW_INT); }
"new"            { return makeToken(yytext, yyleng, token::KW_NEW); }
"null"           { return makeToken(yytext, yyleng, token::KW_NULL); }
"return"         { return makeToken(yytext, yyleng, token::KW_RETURN); }
"true"           { return makeToken(yytext, yyleng, token::KW_TRUE); }
"void"           { return makeToken(yytext, yyleng, token::KW_VOID); }
"while"          { return makeToken(yytext, yyleng, token::KW_WHILE); }
"System.out.print" { return makeToken(yytext, yyleng, token::PRINT); }
"System.out.println" { return makeToken(yytext, yyleng, token::PRINTLN); }
"System.in.read" { return makeToken(yytext, yyleng, token::READ); }
"Random.nextInt" { return makeToken(yytext, yyleng, token::RANDOMINT); }


{DIGIT}+               { yyval.emplace<int>(std::strtol(yytext, nullptr,10));
                         return makeToken(yytext, yyleng, token::NUMBER); }

{IDENT}                { yyval.emplace<std::string>(yytext, yyleng); 
                         return makeToken(yytext, yyleng, token::IDENT); }

\"(\\.|[^"\\])*\"      { yyval.emplace<std::string>(yytext, yyleng); 
                         return makeToken(yytext, yyleng, token::STRING); }

\'.\'                  { yyval.emplace<std::string>(yytext, yyleng); 
                         return makeToken(yytext, yyleng, token::CHAR_CONST);}


[ \t\n\r]+  {  }

<BlockComment>"*/" { BEGIN(INITIAL); }
<BlockComment>.|\n { }
<BlockComment><<EOF>> { throw "End of file found in comment"; }

%%

DecafLexer::DecafLexer(std::istream &in) : in(in){
    yylex_init_extra(&in, &scanner); 
}

// ExprLexer::~ExprLexer() {
//     yylex_destroy(scanner);
// }