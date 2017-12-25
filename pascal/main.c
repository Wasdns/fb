#include "utils.h"
#include "definitions.h"
#include <stdio.h>
#include <stdlib.h>

extern FILE* yyin;

int lineno = 1;

int main() {
	yyin = freopen("tests/test1.pas", "rU", stdin);

	do {
		yyparse();
	} while(!feof(yyin));

	printf("parsing successfully!\n");

	return 0;
}