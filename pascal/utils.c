#include "utils.h"
#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include <string.h>

char* copyString(char* s) {
	int n;
	char* t;
	if (s == NULL) return NULL;
	n = strlen(s)+1;
	t = malloc(n);
	if (t == NULL)
		// fprintf(listing, "Out of memory error at line %d\n",lineno);
		printf("Out of memory error!\n");
	else strcpy(t,s);
	return t;
}