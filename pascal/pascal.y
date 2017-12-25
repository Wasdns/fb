%{
#include "utils.h"
#include "definitions.h"
#include <stdio.h>
#include <stdlib.h>
%}

%union {
	int ival;
	float fval;
	char* idName;
	int bval;
}

%token<ival> T_INT
%token<fval> T_FLOAT
%token<idName> ID
%token T_PLUS T_MINUS T_MULTIPLY T_DIVIDE T_LEFT T_RIGHT
%token T_QUIT

%token T_IF T_ELSE T_THEN
%token T_FOR T_DOWNTO
%token T_DO T_BEGIN 
%token T_TO
%token T_WHILE
%token T_PROGRAM
%token T_SEMI
%token T_POINT
%token T_END
%token T_FACT
%token T_HIGHER T_NOT_LOWER T_LOWER T_NOT_HIGHER T_EQUAL_TO

%left T_PLUS T_MINUS
%left T_MULTIPLY T_DIVIDE

%type<ival> s compound_stmt stmt stmts if_stmt for_stmt expr factor
%type<bval> bool

%start s

%%

nop: T_QUIT { printf("bye!\n"); exit(0); }
;

start: s
;

s : T_PROGRAM ID T_SEMI compound_stmt T_POINT { $$ = $4; }
;

compound_stmt : T_BEGIN stmts T_END { $$ = $2; }
;

stmts : stmt { $$ = $1; }
      | stmts T_SEMI { $$ = $1; }
;

stmt : ID T_EQUAL_TO expr { $$ = $3; }
     | compound_stmt { $$ = $1; }
     | if_stmt { $$ = $1; }
     | for_stmt { $$ = $1; }
     | T_WHILE bool T_DO stmt { if ($2 == true) $$ = $4;
                                else $$ = -1; }
     | nop { $$ = -1; }
;

if_stmt : T_IF bool T_THEN stmt { if ($2 == true) $$ = $4;
                                  else $$ = -1; }
        | T_IF bool T_THEN stmt T_ELSE stmt { if ($2 == true) $$ = $4;
                                              else $$ = $6; }
;

for_stmt : T_FOR ID T_EQUAL_TO expr T_TO expr T_DO stmt { $$ = $8; }
         | T_FOR ID T_EQUAL_TO expr T_DOWNTO expr T_DO stmt { $$ = $8; }
;

bool : expr T_HIGHER expr { if ($1 > $3) $$ = true;
                            else $$ = false; }
     | expr T_LOWER expr { if ($1 < $3) $$ = true; 
                           else $$ = false; }
;

expr : expr T_PLUS expr { $$ = $1+$3; }
     | expr T_MINUS expr { $$ = $1-$3; }
     | expr T_MULTIPLY expr { $$ = $1*$3; }
     | expr T_DIVIDE expr { $$ = $1/$3; }
     | expr T_FACT expr { $$ = $1^$3; }
     | factor { $$ = $1; }
;

factor : ID { $$ = -1; }
       | T_INT { $$ = $1; }
       | T_FLOAT { $$ = $1; }
       | T_LEFT expr T_RIGHT { $$ = $2; }
;

%%

void yyerror(const char* s) {
	fprintf(stderr, "Parse error: %s at line %d\n", s, lineno);

	// TBD: show line number
	// fprintf(stderr, "Parse error: %s in line %d\n", s, line_number);
	
	// exit the parser program, otherwise the procedure 
	// would give unexcepted behaviours
	exit(1); 
}
