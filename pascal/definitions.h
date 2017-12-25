#include "pascal.tab.h"

#define YY_DECL int yylex()

typedef int bool;
#define true 1
#define false 0

extern int yylex();
extern int yyparse();
extern int lineno;

void yyerror(const char* s);
