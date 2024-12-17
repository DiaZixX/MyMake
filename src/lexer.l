%{
/***** C Stuff (header, declarations, varaibles) *****/
#include <string.h>
enum {NEW_LINE=1,VARIABLE,TARGET,COLON,EQUALS,COMMAND_TEXT,INCLUDE};
char globalValue[0x100];
%}

void showError();
%option noyywrap

/***** Definition of regular expressions *****/
ws              [ \t]+
newline         \\n
comment         \#.*
variable        [A-Z_][A-Z0-9_]*
target          [a-zA-Z0-9_./%-]+
command_line    [^\n]+

/***** Token specification *****/
%%
{ws}            ;
{comment}       ;
"include"       { strcpy(globalValue,yytext); return(INCLUDE); }
{newline}       { strcpy(globalValue,yytext); return(NEW_LINE); }
{variable}      { strcpy(globalValue,yytext); return(VARIABLE); }
{target}        { strcpy(globalValue,yytext); return(TARGET); }
":"             { strcpy(globalValue,yytext); return(COLON); }
"="             { strcpy(globalValue,yytext); return(EQUALS); }
"\t"{command_line} { strcpy(globalValue,yytext); return(COMMAND_TEXT); }
.               { }

%%

/***** C function (main or others) *****/

int main(void) {
    int token;
    do{
        token=yylex();
        switch(token) {
            case (0): fprintf(stderr,"END_OF_FILE\n"); break;
            case NEW_LINE: fprintf(stderr,"NEW_LINE [%s]\n",globalValue); break;
            case VARIABLE: fprintf(stderr,"VARIABLE [%s]\n",globalValue); break;
            case TARGET: fprintf(stderr,"TARGET [%s]\n",globalValue); break;
            case COLON: fprintf(stderr,"COLON [%s]\n",globalValue); break;
            case EQUALS: fprintf(stderr,"EQUALS [%s]\n",globalValue); break;
            case COMMAND_TEXT: fprintf(stderr,"COMMAND_TEXT [%s]\n",globalValue); break;
            case INCLUDE: fprintf(stderr,"INCLUDE [%s]\n",globalValue); break;
        }
    } while(token);
    return 0;
}

