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
ws       [ \t\v\r\f]+	 
newline  \n+

letter_	 [A-Za-z_]
digit	 [0-9]

/* Identifiers, Floats, and Integers */
id      {letter_}({letter_}|{digit})*
int     {digit}+
float   ({digit}+\.{digit}*)|(\.{digit}+)

%%

{ws}		{ /* ignore whitespace */ }

{newline}   { 
                lines += yyleng; /* increase line count for each \n */
            }

if          {   
                symbol_info *s = new symbol_info((string)yytext,"IF");
                yylval = (YYSTYPE)s;
                loglist="Line no "+to_string(lines)+": Token <IF> Lexeme "+yytext+" found\n\n";
			    outlog<<loglist;
                return IF;
            }

else        {   
                symbol_info *s = new symbol_info((string)yytext,"ELSE");
                yylval = (YYSTYPE)s;
                loglist="Line no "+to_string(lines)+": Token <ELSE> Lexeme "+yytext+" found\n\n";
			    outlog<<loglist;
                return ELSE;
            }

for         {   
                symbol_info *s = new symbol_info((string)yytext,"FOR");
                yylval = (YYSTYPE)s;
                loglist="Line no "+to_string(lines)+": Token <FOR> Lexeme "+yytext+" found\n\n";
			    outlog<<loglist;
                return FOR;
            }

while       { 
                symbol_info *s = new symbol_info((string)yytext,"WHILE");
                yylval = (YYSTYPE)s;
                loglist="Line no "+to_string(lines)+": Token <WHILE> Lexeme "+yytext+" found\n\n";
			    outlog<<loglist; 
                return WHILE;
            }

do          {   
                symbol_info *s = new symbol_info((string)yytext,"DO");
                yylval = (YYSTYPE)s;
                loglist="Line no "+to_string(lines)+": Token <DO> Lexeme "+yytext+" found\n\n";
			    outlog<<loglist;
                return DO;
            }

break       {   
                symbol_info *s = new symbol_info((string)yytext,"BREAK");
                yylval = (YYSTYPE)s;
                loglist="Line no "+to_string(lines)+": Token <BREAK> Lexeme "+yytext+" found\n\n";
			    outlog<<loglist;
                return BREAK;
            }

int         {   
                symbol_info *s = new symbol_info((string)yytext,"INT");
                yylval = (YYSTYPE)s;
                loglist="Line no "+to_string(lines)+": Token <INT> Lexeme "+yytext+" found\n\n";
			    outlog<<loglist;
                return INT;
            }

char        {   
                symbol_info *s = new symbol_info((string)yytext,"CHAR");
                yylval = (YYSTYPE)s;
                loglist="Line no "+to_string(lines)+": Token <CHAR> Lexeme "+yytext+" found\n\n";
			    outlog<<loglist;
                return CHAR;
            }

float       {   
                symbol_info *s = new symbol_info((string)yytext,"FLOAT");
                yylval = (YYSTYPE)s;
                loglist="Line no "+to_string(lines)+": Token <FLOAT> Lexeme "+yytext+" found\n\n";
			    outlog<<loglist;
                return FLOAT;
            }

double      {   
                symbol_info *s = new symbol_info((string)yytext,"DOUBLE");
                yylval = (YYSTYPE)s;
                loglist="Line no "+to_string(lines)+": Token <DOUBLE> Lexeme "+yytext+" found\n\n";
			    outlog<<loglist;
                return DOUBLE;
            }

void        {   
                symbol_info *s = new symbol_info((string)yytext,"VOID");
                yylval = (YYSTYPE)s;
                loglist="Line no "+to_string(lines)+": Token <VOID> Lexeme "+yytext+" found\n\n";
			    outlog<<loglist;
                return VOID;
            }

return      {   
                symbol_info *s = new symbol_info((string)yytext,"RETURN");
                yylval = (YYSTYPE)s;
                loglist="Line no "+to_string(lines)+": Token <RETURN> Lexeme "+yytext+" found\n\n";
			    outlog<<loglist;
                return RETURN;
            }

switch      {   
                symbol_info *s = new symbol_info((string)yytext,"SWITCH");
                yylval = (YYSTYPE)s;
                loglist="Line no "+to_string(lines)+": Token <SWITCH> Lexeme "+yytext+" found\n\n";
			    outlog<<loglist;
                return SWITCH;
            }

case        {   
                symbol_info *s = new symbol_info((string)yytext,"CASE");
                yylval = (YYSTYPE)s;
                loglist="Line no "+to_string(lines)+": Token <CASE> Lexeme "+yytext+" found\n\n";
			    outlog<<loglist;
                return CASE;
            }

default     {   
                symbol_info *s = new symbol_info((string)yytext,"DEFAULT");
                yylval = (YYSTYPE)s;
                loglist="Line no "+to_string(lines)+": Token <DEFAULT> Lexeme "+yytext+" found\n\n";
			    outlog<<loglist;
                return DEFAULT;
            }

continue    {   
                symbol_info *s = new symbol_info((string)yytext,"CONTINUE");
                yylval = (YYSTYPE)s;
                loglist="Line no "+to_string(lines)+": Token <CONTINUE> Lexeme "+yytext+" found\n\n";
			    outlog<<loglist;
                return CONTINUE;
            }

goto        {   
                symbol_info *s = new symbol_info((string)yytext,"GOTO");
                yylval = (YYSTYPE)s;
                loglist="Line no "+to_string(lines)+": Token <GOTO> Lexeme "+yytext+" found\n\n";
			    outlog<<loglist;
                return GOTO;
            }

printf      {   
                symbol_info *s = new symbol_info((string)yytext,"PRINTLN");
                yylval = (YYSTYPE)s;
                loglist="Line no "+to_string(lines)+": Token <PRINTLN> Lexeme "+yytext+" found\n\n";
			    outlog<<loglist;
                return PRINTLN;
            }

{float} {
    symbol_info *s=new symbol_info((string)yytext,"CONST_FLOAT");
    yylval=s;
    loglist="Line no "+to_string(lines)+": Token <CONST_FLOAT> Lexeme "+yytext+" found\n\n";
	outlog<<loglist;
    return CONST_FLOAT;
}

{int} {
    symbol_info *s=new symbol_info((string)yytext,"CONST_INT");
    yylval=s;
    loglist="Line no "+to_string(lines)+": Token <CONST_INT> Lexeme "+yytext+" found\n\n";
	outlog<<loglist;
    return CONST_INT;
}

{id}       {
                symbol_info *s = new symbol_info((string)yytext,"ID");
                yylval = (YYSTYPE)s;
                loglist="Line no "+to_string(lines)+": Token <ID> Lexeme "+yytext+" found\n\n";
			    outlog<<loglist;
                return ID;
            }

"++"|"--"   {
                symbol_info *s = new symbol_info((string)yytext,"INCOP");
                yylval = (YYSTYPE)s;
                loglist="Line no "+to_string(lines)+": Token <INCOP> Lexeme "+yytext+" found\n\n";
                outlog<<loglist;
                return INCOP;
            }

"+"|"-"	    {
                symbol_info *s = new symbol_info((string)yytext,"ADDOP");
                yylval = (YYSTYPE)s;
                loglist="Line no "+to_string(lines)+": Token <ADDOP> Lexeme "+yytext+" found\n\n";
			    outlog<<loglist;
                return ADDOP;
            }

"*"|"/"|"%"   {
                symbol_info *s = new symbol_info((string)yytext,"MULOP");
                yylval = (YYSTYPE)s;
                loglist="Line no "+to_string(lines)+": Token <MULOP> Lexeme "+yytext+" found\n\n";
                outlog<<loglist;
                return MULOP;
            }

"<="|">="|"=="|"!="|"<"|">"   {
                symbol_info *s = new symbol_info((string)yytext,"RELOP");
                yylval = (YYSTYPE)s;
                loglist="Line no "+to_string(lines)+": Token <RELOP> Lexeme "+yytext+" found\n\n";
                outlog<<loglist;
                return RELOP;
            }

"="         {
                symbol_info *s = new symbol_info((string)yytext,"ASSIGNOP");
                yylval = (YYSTYPE)s;
                loglist="Line no "+to_string(lines)+": Token <ASSIGNOP> Lexeme "+yytext+" found\n\n";
                outlog<<loglist;
                return ASSIGNOP;
            }

"&&"|"||"   {
                symbol_info *s = new symbol_info((string)yytext, "LOGICOP");
                yylval = (YYSTYPE)s;
                loglist="Line no "+to_string(lines)+": Token <LOGICOP> Lexeme "+yytext+" found\n\n";
                outlog<<loglist;
                return LOGICOP;
            }

"!"         {
                loglist="Line no "+to_string(lines)+": Token <NOT> Lexeme ! found\n\n";
                outlog<<loglist;
                return NOT;
            }

"("         {
                loglist="Line no "+to_string(lines)+": Token <LPAREN> Lexeme ( found\n\n";
                outlog<<loglist;
                return LPAREN;
            }

")"         {
                loglist="Line no "+to_string(lines)+": Token <RPAREN> Lexeme ) found\n\n";
                outlog<<loglist;
                return RPAREN;
            }

"{"         {
                loglist="Line no "+to_string(lines)+": Token <LCURL> Lexeme { found\n\n";
                outlog<<loglist;
                return LCURL;
            }

"}"         {
                loglist="Line no "+to_string(lines)+": Token <RCURL> Lexeme } found\n\n";
                outlog<<loglist;
                return RCURL;
            }

"["         {
                loglist="Line no "+to_string(lines)+": Token <LTHIRD> Lexeme [ found\n\n";
                outlog<<loglist;
                return LTHIRD;
            }

"]"         {
                loglist="Line no "+to_string(lines)+": Token <RTHIRD> Lexeme ] found\n\n";
                outlog<<loglist;
                return RTHIRD;
            }

","         {
                loglist="Line no "+to_string(lines)+": Token <COMMA> Lexeme , found\n\n";
                outlog<<loglist;
                return COMMA;
            }

":"         {
                loglist="Line no "+to_string(lines)+": Token <COLON> Lexeme : found\n\n";
                outlog<<loglist;
                return COLON;
            }

";"         {
                loglist="Line no "+to_string(lines)+": Token <SEMICOLON> Lexeme ; found\n\n";
                outlog<<loglist;
                return SEMICOLON;
            }

.           {
                cout<<"Unknown character "<<yytext<<endl;
            }

%%