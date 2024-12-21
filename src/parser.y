%{
/***** C Stuff (header, declarations, variables) *****/
#include <stdio.h>
#include <string.h>

// Prototypes of the lexer
int yylex(void);
void yyerror(const char *s);

int lineNumber;
extern FILE * yyin;
%}

%debug
%token NEW_LINE COLON EQUALS
%token VARIABLE TARGET INCLUDE
%token COMMAND_TEXT

%union { char str[0x400]; }
%type<str> TARGET VARIABLE COMMAND_TEXT target_list command_list

%start makefile
%%

makefile:
    line_list
;

line_list:
	line
    | line_list line
;

line:
    NEW_LINE
    | VARIABLE EQUALS target_list NEW_LINE { fprintf(stdout, "[VARIABLE] %s\n[EQUALS] =\n%s[NEW_LINE]\n", $1, $3); }
    | INCLUDE TARGET NEW_LINE { fprintf(stdout, "[INCLUDE] include\n[TARGET] %s\n[NEW_LINE]\n", $2); }
	| TARGET COLON target_list NEW_LINE command_list { fprintf(stdout, "[TARGET] %s\n[COLON] :\n%s%s[NEW_LINE]\n", $1, $3, $5); }
;

command_list :
	/* epsilon */ { sprintf($$, ""); }
	| command_list COMMAND_TEXT NEW_LINE { sprintf($$, "%s[COMMAND_TEXT] %s\n", $1, $2); }

target_list:
	/* epsilon */ { sprintf($$, ""); }
    | target_list TARGET { sprintf($$, "%s[TARGET] %s\n", $1, $2); }
;

%%

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}

extern int yydebug;
int main(int argc, char* argv[]){
	yydebug = 0;
	if (argc > 1){
		yyin=fopen(argv[1],"r");
	} else {
		fprintf(stderr, "No input file\n");
		return 1;
	}
	lineNumber = 0;
	/*
	if(!yyparse()){
		fprintf(stdout, "Parsing success !\n");
	}
	*/
	return yyparse();
}

