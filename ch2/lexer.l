
%{
#include <stdio.h>
#include <stdbool.h>

enum Token_Type {
    // EOF_TOKEN = 0, // don't need this, flex detect EOF and call yywrap()
    NUMERIC_TOKEN = 0,
    IDENTIFIER_TOKEN,
    L_PARAN_TOKEN,
    R_PARAN_TOKEN,
    COMMA_TOKEN,
    DEF_TOKEN,

    NUM_OF_TOKEN_TYPE
};

static int yylval;
extern int yyleng;
extern char* yytext;
extern FILE* yyin;

static bool EOF_FLAG = false;
int installID();
%}

delim   [ \t\n]
ws      {delim}+
letter  [a-zA-Z_]
digit   [0-9]
id      {letter}({letter}|{digit})*
number  {digit}+(\.{digit}+)?(E[+-]?{digit}+)?

%%

{ws} {}

"def" {
    return DEF_TOKEN;
}

{id} {
    yylval = (int)installID();
    return(IDENTIFIER_TOKEN);
}

{number} {
    return(NUMERIC_TOKEN);
}

"(" {
    return L_PARAN_TOKEN;
}

")" {
    return R_PARAN_TOKEN;
}

"," {
    return COMMA_TOKEN;
}

%%

int yywrap() {
    printf("yywrap!\n");
    EOF_FLAG = true;
    return 1;
}

int installID() {
    for (int i = 0; i < yyleng; i++) {
        printf("%c", yytext[i]);
    }
    printf("\n");

    return 1;
}

int main(int argc, char* argv[]) {
    if (argc > 2) {
        return -1;
    }

    yyin = fopen(argv[1], "rb+");

    enum Token_Type ret = yylex();
    while (!EOF_FLAG) {     
        printf("yylex return %d\n", ret);
        ret = yylex();
    }

    return 0;
}