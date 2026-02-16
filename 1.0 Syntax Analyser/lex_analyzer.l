%option noyywrap









%{
#include<bits/stdc++.h>

#include"symbol_info.h"

#define YYSTYPE symbol_info*

#include "y.tab.h"

extern YYSTYPE yylval;

using namespace std;

void yyerror(char *);


string loglist;

extern int lines;

extern ofstream outlog;

%}





/* Regular Definitions */

delim	 [ \t\v\r]

/* write regular expressions for whitespace and newline */


ws       [ \t\v\r\f]+	 
newline  \n+

letter_	 [A-Za-z_]
digit	 [0-9]

/* write regular expressions for id, float and integers */

/*   1. Letters are already defined so we can reuse those rules. */

id      {letter_}({letter_}|{digit})*

/*   2. Integers can have more than one digits that's why plus. */

int     {digit}+

/*   3. Can have one or more digits before or after the decimal point. */

float   ({digit}+\.{digit}*)|(\.{digit}+)



%%

{ws}		{ /* ignore whitespace */ }


{newline}   { 
                lines += yyleng;     /* increase line count for each \n */
            }

{id}       {
                symbol_info *s = new symbol_info((string)yytext,"ID");
                yylval = (YYSTYPE)s;
                loglist="Line no "+to_string(lines)+": Token <ID> Lexeme "+yytext+" found"+"\n"+"\n";
			    outlog<<loglist;
                return ID;
            }

if          { 
                loglist="Line no "+to_string(lines)+": Token <IF> Lexeme "+yytext+" found"+"\n"+"\n";
			    outlog<<loglist;
                return IF; }

while       { 
                loglist="Line no "+to_string(lines)+": Token <WHILE> Lexeme "+yytext+" found"+"\n"+"\n";
			    outlog<<loglist; 
                return WHILE; }

"+"|"-"	    {
                symbol_info *s = new symbol_info((string)yytext,"ADDOP");
                yylval = (YYSTYPE)s;
                loglist="Line no "+to_string(lines)+": Token <ADDOP> Lexeme "+yytext+" found"+"\n"+"\n";
			    outlog<<loglist;
                return ADDOP;
		    }

","        { 
                symbol_info *s = new symbol_info((string)yytext,"COMMA");
                yylval = (YYSTYPE)s;
                loglist="Line no "+to_string(lines)+": Token <COMMA> Lexeme "+yytext+" found"+"\n"+"\n";
			    outlog<<loglist;               
                return COMMA; }

"*"|"/"|"%"   {
                symbol_info *s = new symbol_info((string)yytext,"MULOP");
                yylval = (YYSTYPE)s;

                loglist="Line no "+to_string(lines)+": Token <MULOP> Lexeme "+yytext+" found"+"\n"+"\n";
                outlog<<loglist;

                return MULOP;
             }

"++"|"--"   {
                symbol_info *s = new symbol_info((string)yytext,"INCOP");
                yylval = (YYSTYPE)s;

                loglist="Line no "+to_string(lines)+": Token <INCOP> Lexeme "+yytext+" found"+"\n"+"\n";
                outlog<<loglist;

                return INCOP;
            }

"<="|">="|"=="|"!="|"<"|">"   {
                symbol_info *s = new symbol_info((string)yytext,"RELOP");
                yylval = (YYSTYPE)s;

                loglist="Line no "+to_string(lines)+": Token <RELOP> Lexeme "+yytext+" found"+"\n"+"\n";
                outlog<<loglist;

                return RELOP;
            }

"="         {
                symbol_info *s = new symbol_info((string)yytext,"ASSIGNOP");
                yylval = (YYSTYPE)s;

                loglist="Line no "+to_string(lines)+": Token <ASSIGNOP> Lexeme "+yytext+" found"+"\n"+"\n";
                outlog<<loglist;

                return ASSIGNOP;
            }

"&&"|"||"   {
                symbol_info *s = new symbol_info((string)yytext, "LOGICOP");
                yylval = (YYSTYPE)s;

                loglist="Line no "+to_string(lines)+": Token <LOGICOP> Lexeme "+yytext+" found"+"\n"+"\n";
                outlog<<loglist;

                return LOGICOP;
            }

"!"         {
                symbol_info *s = new symbol_info((string)yytext, "NOT");
                yylval = (YYSTYPE)s;

                loglist="Line no "+to_string(lines)+": Token <NOT> Lexeme "+yytext+" found"+"\n"+"\n";
                outlog<<loglist;

                return NOT;                
}
