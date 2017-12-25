%option noyywrap

%{
#include "utils.h"
#include <stdio.h>

#define YY_DECL int yylex()

#include "pascal.tab.h"

%}

digit       [0-9]
letter      [a-zA-Z]

int_num     {digit}+
real_num    {digit}+"."{digit}*
identifier  {letter}+({letter}|{digit}|_)*({letter}+|{digit}+)|{letter}+
whitespace  [ \t]*

%%

"exit"                {return T_QUIT;}
"quit"                {return T_QUIT;}
"while"               {return T_WHILE;}    
"if"                  {return T_IF;}
"else"                {return T_ELSE;}
"for"                 {return T_FOR;}
"do"                  {return T_DO;}
"program"             {return T_PROGRAM;}
"end"                 {return T_END;}

{whitespace}          ; // ignore all whitespace
{real_num}            {yylval.fval = atof(yytext); return T_FLOAT;}
{int_num}             {yylval.ival = atoi(yytext); return T_INT;}
{identifier}          {yylval.idName = copyString(yytext); return ID;}

\n|\r\n|\n\r|\r       {return T_NEWLINE;}
"+"	                  {return T_PLUS;}
"-"	                  {return T_MINUS;}
"*"	                  {return T_MULTIPLY;}
"/"	                  {return T_DIVIDE;}
"("	                  {return T_LEFT;}
")"	                  {return T_RIGHT;}
";"                   {return T_SEMI;}
"."                   {return T_POINT;}
":="                  {return T_EQUAL_TO;}
">"                   {return T_HIGHER;}
">="                  {return T_NOT_LOWER;}
"<"                   {return T_LOWER;}
"<="                  {return T_NOT_HIGHER;}
"^"                   {return T_FACT;}

%%
