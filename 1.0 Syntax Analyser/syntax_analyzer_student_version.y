%{

#include"symbol_info.h"

#define YYSTYPE symbol_info*

int yyparse(void);
int yylex(void);

extern FILE *yyin;


ofstream outlog;

int lines = 1;

// declare any other variables or functions needed here

void yyerror(const char *s){}

%}


/* ---- TOKENS ---- */
%token IF ELSE FOR WHILE DO BREAK SWITCH CASE DEFAULT CONTINUE GOTO
%token ID LPAREN RPAREN LCURL RCURL LTHIRD RTHIRD COLON
%token INT CHAR FLOAT DOUBLE VOID
%token COMMA SEMICOLON
%token CONST_INT CONST_FLOAT
%token ADDOP MULOP RELOP LOGICOP ASSIGNOP NOT
%token INCOP DECOP
%token PRINTLN RETURN

%%

start : program
	{
		outlog<<"At line no: "<<lines<<" start : program "<<endl<<endl;
		$$ = $1;   /* REQUIRED so $$ not garbage */
	}
	;



program : program unit
	{
		outlog<<"At line no: "<<lines<<" program : program unit "<<endl<<endl;
		outlog<<$1->getname()+"\n"+$2->getname()<<endl<<endl;
		
		$$ = new symbol_info($1->getname()+"\n"+$2->getname(),"program");
	}
	| unit
	{
		$$ = $1;   /* REQUIRED */
	}
	;



unit : func_definition
	{
		$$ = $1;
	}
	;



type_specifier
	: INT   { $$=$1; }
	| FLOAT { $$=$1; }
	| VOID  { $$=$1; }
	;

parameter_list
	: type_specifier ID
	{
		$$ = new symbol_info($1->getname()+" "+$2->getname(),"param");
	}
	| parameter_list COMMA type_specifier ID
	{
		$$ = new symbol_info($1->getname()+","+$3->getname()+" "+$4->getname(),"param");
	}
	;

compound_statement
	: LCURL RCURL
	{
		$$ = new symbol_info("{}","compound");
	}
	| LCURL statement RCURL
	{
		$$ = new symbol_info("{\n"+$2->getname()+"\n}","compound");
	}
	;



func_definition : type_specifier ID LPAREN parameter_list RPAREN compound_statement
		{
			outlog<<"At line no: "<<lines<<" func_definition : type_specifier ID LPAREN parameter_list RPAREN compound_statement"<<endl<<endl;

			$$ = new symbol_info(
				$1->getname()+" "+$2->getname()+"("+$4->getname()+")\n"+$6->getname(),
				"func_def"
			);
		}
		| type_specifier ID LPAREN RPAREN compound_statement
		{
			outlog<<"At line no: "<<lines<<" func_definition : type_specifier ID LPAREN RPAREN compound_statement "<<endl<<endl;
			outlog<<$1->getname()<<" "<<$2->getname()<<"()\n"<<$5->getname()<<endl<<endl;
			
			$$ = new symbol_info($1->getname()+" "+$2->getname()+"()\n"+$5->getname(),"func_def");	
		}
 		;



expression_statement
	: SEMICOLON
	{
		$$ = new symbol_info(";","empty");
	}
	| ID SEMICOLON
	{
		$$ = new symbol_info($1->getname()+";","expr");
	}
	;

expression
	: ID
	{
		$$ = $1;
	}
	;



statement : FOR LPAREN expression_statement expression_statement expression RPAREN statement
	  {
	    	outlog<<"At line no: "<<lines<<" statement : FOR LPAREN expression_statement expression_statement expression RPAREN statement "<<endl<<endl;
			outlog<<"for("<<$3->getname()<<$4->getname()<<$5->getname()<<")\n"<<$7->getname()<<endl<<endl;
			
			$$ = new symbol_info("for("+$3->getname()+$4->getname()+$5->getname()+")\n"+$7->getname(),"stmnt");
	  }
	  | compound_statement
	  {
		$$ = $1;
	  }
	  ;

%%