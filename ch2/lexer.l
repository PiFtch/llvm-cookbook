
%{
#include <stdio.h>

{number}  [0-9]
{letter}  [a-zA-Z_]
{delim}   [ \t\n]
{ws}      {delim}+
%}


%%
"int" {printf("INT");}
"void"  {printf("VOID\n");}

{letter}({number}|{letter})*    {print("ID\n");}
%%


int yywrap() {
    return 1;
}


int main() {
    yylex();
    return 0;
}