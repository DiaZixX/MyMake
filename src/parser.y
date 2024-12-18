%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void yyerror(const char *s);
extern int yylex();
%}

%union {
    char *str;
}

%token VARIABLE TARGET COMMAND_TEXT
%token ':' '=' '\n'

%%

makefile:
    /* Grammaire principale */
    | makefile statement
    ;

statement:
      rule
    | variable_assignment
    ;

rule:
    TARGET ':' dependencies '\n' commands
    ;

dependencies:
      /* Liste des dépendances (optionnelles) */
    | dependencies TARGET
    ;

commands:
      /* Bloc de commandes commençant par une tabulation */
    | commands '\t' COMMAND_TEXT '\n' { printf("Command: %s\n", $3); free($3); }
    ;

variable_assignment:
    VARIABLE '=' TARGET '\n' { printf("Variable: %s = %s\n", $1, $3); }
    ;

%%

void yyerror(const char *s) {
    fprintf(stderr, "Erreur : %s\n", s);
}

int main(void) {
    return yyparse();
}

