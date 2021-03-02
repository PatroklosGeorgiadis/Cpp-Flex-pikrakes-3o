%option noyywrap
%{
	#include<stdio.h>
%}

DIGIT    [1-9]+   
 
VAR	 [A-Za-z]

OP	 [+*/%-]

%%
{VAR}"="(({DIGIT}|{VAR}){OP}({DIGIT}|{VAR}))({OP}({DIGIT}|{VAR}))*";"	printf( "A regular expression: %s \n", yytext );


.	printf( "Not a recognizable regular expression:%s \n", yytext );

%%
int main( argc, argv )
int argc;
char **argv;
    {
    ++argv, --argc;  /* skip over program name */
    if ( argc > 0 )
            yyin = fopen( argv[0], "r" );
    else
            yyin = stdin;
    yylex();
    }
