%{
/***** C Stuff (header, declarations, varaibles) *****/
#include <string.h>
#include "parser.tab.h"

extern int lineNumber;            // Defined in parser.y -> useful for \n case
void yyerror(const char * msg);   // Defined in parser.y -> useful for . case

/*
enum {NEW_LINE=1,VARIABLE,TARGET,COLON,EQUALS,COMMAND_TEXT,INCLUDE, ERROR_TOKEN};
char globalValue[0x100];
*/
%}

%option noyywrap

/***** Definition of regular expressions *****/
comment         [#].*
variable        ^[A-Z0-9_]+
target          [a-zA-Z0-9_./%-]+
command_line    [^\n]+

/***** Token specification *****/
%%
[ \t]+             { /* Nothing to do in this case */ }
{comment}          { /* Nothing to do in this case */ }
"\n"               { ++lineNumber; return(NEW_LINE); }
"include"          { return(INCLUDE); }
{variable}         { sprintf(yylval.str, "%s", yytext); return(VARIABLE); }
{target}           { sprintf(yylval.str, "%s", yytext); return(TARGET); }
":"                { return(COLON); }
"="                { return(EQUALS); }
"\t"{command_line} { sprintf(yylval.str, "%s", yytext+1);  return(COMMAND_TEXT); } /* The +1 is for the \t */
.                  { char msg[0x100]; sprintf(msg,"Lexical error <%s> @ line <%d>\n",yytext, lineNumber); yyerror(msg); }

%%

/***** C function (main or others) *****/

/*
int main(void) {
    int token;
    int line = 1;
    do{
        token=yylex();
        switch(token) {
            case (0): fprintf(stderr,"END_OF_FILE\n\nNumber of lines : %d\n", lineNumber); break;
            case NEW_LINE: fprintf(stderr,"\n"); line++; break;
            case VARIABLE: fprintf(stderr,"VARIABLE [%s]\n",globalValue); break;
            case TARGET: fprintf(stderr,"TARGET [%s]\n",globalValue); break;
            case COLON: fprintf(stderr,"COLON [%s]\n",globalValue); break;
            case EQUALS: fprintf(stderr,"EQUALS [%s]\n",globalValue); break;
            case COMMAND_TEXT: fprintf(stderr,"COMMAND_TEXT [%s]\n",globalValue); break;
            case INCLUDE: fprintf(stderr,"INCLUDE [%s]\n",globalValue); break;
            case ERROR_TOKEN: fprintf(stderr, "Token error @ line %d\n", line); return 1;
        }
    } while(token);
    return 0;
}
*/
