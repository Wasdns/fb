%option noyywrap

%{
#include "utils.h"
#include "definitions.h"
#include <stdio.h>
%}

digit       [0-9]
letter      [a-zA-Z]

int_num     {digit}+
real_num    {digit}+"."{digit}*
identifier  {letter}+({letter}|{digit}|_)*({letter}+|{digit}+)*|{letter}+
whitespace  [ \t]*

%%

"exit"                {return T_QUIT;}
"quit"                {return T_QUIT;}
"while"               {return T_WHILE;}    
"if"                  {return T_IF;}
"else"                {return T_ELSE;}
"for"                 {return T_FOR;}
"then"                {return T_THEN;}
"do"                  {return T_DO;}
"to"                  {return T_TO;}
"program"             {return T_PROGRAM;}
"begin"               {return T_BEGIN;}
"end"                 {return T_END;}

\n|\r\n|\n\r|\r       {lineno++;}
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

{whitespace}          ; // ignore all whitespace
{real_num}            {yylval.fval = atof(yytext); return T_FLOAT;}
{int_num}             {yylval.ival = atoi(yytext); return T_INT;}
{identifier}          {yylval.idName = copyString(yytext); /*printf("yep %s\n", yylval.idName);*/ return ID;}


%%
