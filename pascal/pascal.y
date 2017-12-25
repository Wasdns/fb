%{
#include "utils.h"
#include <stdio.h>
#include <stdlib.h>

extern int yylex();
extern int yyparse();
extern FILE* yyin;

void yyerror(const char* s);
%}

%union {
	int ival;
	float fval;
	char* idName;
}

%token<ival> T_INT
%token<fval> T_FLOAT
%token<idname> ID
%token T_PLUS T_MINUS T_MULTIPLY T_DIVIDE T_LEFT T_RIGHT
%token T_NEWLINE T_QUIT

%token T_IF T_ELSE
%token T_FOR T_DOWNTO
%token T_DO T_BEGIN
%token T_WHILE
%token T_PROGRAM
%token T_SEMI
%token T_POINT
%token T_EQUAL_TO
%token T_END
%token T_HIGHER T_NOT_LOWER T_LOWER T_NOT_HIGHER T_FACT

%left T_PLUS T_MINUS
%left T_MULTIPLY T_DIVIDE

%start nop

%%

nop: T_QUIT { printf("bye!\n"); exit(0); }
;



%%

int main() {
	yyin = freopen("input.txt", "r", stdin);

	do { 
		yyparse();
	} while(!feof(yyin));

	return 0;
}

void yyerror(const char* s) {
	fprintf(stderr, "Parse error: %s\n", s);

	// TBD: show line number
	// fprintf(stderr, "Parse error: %s in line %d\n", s, line_number);
	
	// exit the parser program, otherwise the procedure 
	// would give unexcepted behaviours
	exit(1); 
}
