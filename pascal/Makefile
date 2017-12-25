all: pascal

pascal.tab.c pascal.tab.h:	pascal.y
	bison -d pascal.y

lex.yy.c: pascal.l pascal.tab.h
	flex pascal.l

pascal: lex.yy.c pascal.tab.c pascal.tab.h
	gcc -o pascal utils.c pascal.tab.c lex.yy.c

clean:
	rm pascal pascal.tab.c lex.yy.c pascal.tab.h
