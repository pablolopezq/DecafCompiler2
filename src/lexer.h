#include <iostream>
#include <string>

#include "tokens.h"

using yyscan_t = void *;

class DecafLexer {

public:

    DecafLexer(std::istream &in);

    using semantic_type = Decaf::DecafParser::semantic_type;
    using token = Decaf::DecafParser::token;

    int getNextToken(semantic_type *yylval){
        return _getNextToken(*yylval, scanner);
    }

private:
    std::istream &in;
    std::string text;
    yyscan_t scanner;

    int makeToken(const char * txt, int len, int tk){
        std::string tt(txt,len);
        text = std::move(tt);
        return tk;
    }

    std::string printToken(){
        return text;
    }

    int _getNextToken(semantic_type &yylval, yyscan_t yyscanner);

};