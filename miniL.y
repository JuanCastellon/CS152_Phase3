    /* cs152-miniL phase2 */
%{
#include <stdio.h>
#include <vector>
#include <string.h>
#include <string>
#include <map>
#include <set>
#include <stdlib.h>

using namespace std;

int tempCount = 0;
int labelCount = 0;
extern char* yytext;
extern int currPos;
map<string, string> varTemp;
map<string,int> arrSize;
bool mainFunc = false;

extern int yylex(void);
void yyerror(const char *msg);
char* ident;
int number;

extern int currLine;
extern int currPos;
extern FILE * yyin;

//string new_temp();
//string new_label();

%}

%union{
  int int_val;
  char* ident;
  float number;
  
  struct Statement{
    char* code;
  } statement;

  struct Expression{
    char* code;  
  } expression;

}

%error-verbose
%token<int_val> DIGIT
%start prog_start
%token <ident> IDENT
%token <num> NUMBER
%type <expression> function functions identifier identifiers declaration declarations expression expressions multiple_expr
%type <expression> bool_expr relation_and_expr relation_expr term comp
%type <statement> statement statements
%token RETURN FUNCTION SEMICOLON BEGIN_PARAMS END_PARAMS BEGIN_LOCALS END_LOCALS BEGIN_BODY END_BODY 
%token INTEGER ARRAY ENUM OF IF THEN ENDIF ELSE FOR WHILE DO BEGIN_LOOP END_LOOP CONTINUE READ WRITE
%token AND OR NOT TRUE FALSE COLON COMMA L_PAREN R_PAREN L_SQUARE_BRACKET R_SQUARE_BRACKET
%left SUB ADD MULT DIV MOD EQ NEQ LT GT LTE GTE ASSIGN
%right NOT

%%

prog_start:
	functions
		{printf("prog_start -> functions\n");};
function:
	FUNCTION IDENT SEMICOLON BEGIN_PARAMS declarations END_PARAMS BEGIN_LOCALS declarations END_LOCALS BEGIN_BODY statements END_BODY
		{printf("function -> FUNCTION IDENT SEMICOLON BEGIN_PARAMS declarations END_PARAMS BEGIN_LOCALS declarations END_LOCALS BEGIN_BODY statements END_BODY\n", ident);};
functions:
	/* Epsilon */
		{printf("functions -> epsilon\n");}
	| function functions
		{printf("functions -> function functions\n");};

identifier:
	IDENT
		{printf("identifier -> IDENT %s\n", ident);};

identifiers:
	identifier
		{printf("identifiers -> ident\n");}
	| identifier COMMA identifiers
		{printf("identifier -> ident COMMA identifiers\n", ident);};

declaration:
	identifiers COLON INTEGER
		{printf("declaration -> identifier COLON INTEGER\n");}
	| identifiers COLON ARRAY L_SQUARE_BRACKET NUMBER R_SQUARE_BRACKET OF INTEGER
		{printf("declaration -> identifiers COLON ARRAY L_SQUARE_BRACKET NUMBER R_SQUARE_BRACKET OF INTEGER\n");}
	| identifiers COLON ENUM L_PAREN identifiers R_PAREN
		{printf("declaration -> ENUM L_PAREN identifiers R_PAREN\n");};

declarations:
	/* Epsilon */
		{printf("declarations -> Epsilon\n");}
	| declaration SEMICOLON declarations
		{printf("declarations -> declaration SEMICOLON declarations\n");};

multiplicative_expr:
	term
		{printf("multiplicative_expr -> term\n");}
	| term MULT multiplicative_expr
		{printf("multiplicative_expr -> term MULT multiplicative_expr\n");}
	| term DIV multiplicative_expr
		{printf("multiplicative_expr -> term DIV multiplicative_expr\n");}
	| term MOD multiplicative_expr
		{printf("multiplicative_expr -> term MOD multiplicative_expr\n");};

expression:
	multiplicative_expr
		{printf("expression -> multiplicative_expr\n");}
	| multiplicative_expr ADD expression
		{printf("expression -> multiplicative_expr ADD expression\n");}
	| multiplicative_expr SUB expression
		{printf("expression -> multiplicative_expr SUB expression\n");};

expressions:
	/* Epsilon */
		{printf("expressions -> Epsilon\n");}
	| multiple_expr
		{printf("expressions -> multiple_expr\n");};

multiple_expr:
	expression
		{printf("multiple_expr -> expression\n");}
	| expression COMMA multiple_expr
		{printf("multiple_expr -> expression COMMA multiple_expr\n");};

comp:
	EQ
		{printf("comp -> EQ\n");}
	| NEQ
		{printf("comp -> NEQ\n");}
	| LT
		{printf("comp -> LT\n");}
	| GT
		{printf("comp -> GTn");}
	| LTE
		{printf("comp -> LTE\n");}
	| GTE
		{printf("comp -> GTE\n");};

bool_expr:
	relation_and_expr
		{printf("bool_expr -> relation_and_expr\n");}
	| relation_and_expr OR bool_expr
		{printf("bool_expr -> relation_and_expr OR bool_expr\n");};

relation_and_expr:
	relation_expr
		{printf("relation_and_expr -> relation_expr\n");}
	| relation_expr AND relation_and_expr
		{printf("relation_and_expr -> relation_expr AND relation_and_expr\n");};

relation_expr:
	expression comp expression
		{printf("relation_expr -> expression comp expression\n");}
	| NOT expression comp expression
		{printf("relation_expr -> NOT expression comp expression\n");}
	| TRUE
		{printf("relation_expr -> TRUE\n");}
	| NOT TRUE
		{printf("relation_expr -> NOT TRUE\n");}
	| FALSE
		{printf("relation_expr -> FALSE\n");}
	| NOT FALSE
		{printf("relation_expr -> NOT FALSE\n");}
	| L_PAREN bool_expr R_PAREN
		{printf("relation expr -> L_PAREN bool_expr R_PAREN\n");}
	| NOT L_PAREN bool_expr R_PAREN
		{printf("relation_expr -> NOT L_PAREN bool_expr R_PAREN\n");};
term:
	var
		{printf("term -> var\n");}
	| SUB var
		{printf("term -> SUB var\n");}
	| NUMBER
		{printf("term -> NUMBER\n");}
	| SUB NUMBER
		{printf("term -> SUB NUMBER\n");}
	| L_PAREN expression R_PAREN
		{printf("term -> L_PAREN expression R_PAREN\n");}
	| SUB L_PAREN expression R_PAREN
		{printf("term -> SUB L_PAREN expression R_PAREN\n");}
	| identifier L_PAREN expressions R_PAREN
		{printf("term -> identifier L_PAREN expressions R_PAREN\n");};

statement:
	var ASSIGN expression
		{printf("statement -> var ASSIGN expression\n");}
	| IF bool_expr THEN statements ENDIF
		{printf("statement -> IF bool_expr THEN statements ENDIF\n");}
	| IF bool_expr THEN statements ELSE statements ENDIF
		{printf("statement -> IF bool_expr THEN statements ELSE statements ENDIF\n");}
	| WHILE bool_expr BEGIN_LOOP statements END_LOOP
		{printf("statement -> WHILE bool_expr BEING_LOOP statements END_LOOP\n");}
	| DO BEGIN_LOOP statements END_LOOP WHILE bool_expr
		{printf("statement -> DO BEGIN_LOOP statements END_LOOP WHILE bool_expr\n");}
	| READ vars
		{printf("statement -> READ vars\n");}
	| WRITE vars
		{printf("statement -> WRITE vars\n");}
	| CONTINUE
		{printf("statement -> CONTINUE\n");}
	| RETURN expression
		{printf("statement -> RETURN expression\n");};

statements:
	statement SEMICOLON /* Epsilon */
		{printf("statements -> statement SEMICOLON epsilon\n");}
	| statement SEMICOLON statements
		{printf("statements -> statement SEMICOLON statements\n");};

var:
	identifier
		{printf("var -> identifier\n");}
	| identifier L_SQUARE_BRACKET expression R_SQUARE_BRACKET
		{printf("var -> identifier L_SQUARE_BRACKET expression R_SQUARE_BRACKET\n");};

vars:
	var
		{printf("vars -> var\n");}
	| var COMMA vars
		{printf("vars -> var COMMA vars\n");};

%%

int main(int argc, char **argv){
    if (argc > 1) {
        yyin = fopen(argv[1], "r");
        if (yyin == NULL) {
            printf("error: %s file error", argv[0]);
        }
    }
   yyparse();
   return 0;
}

void yyerror(const char *msg) {
    /* implement your error handling */
    printf("Error at line %d: %s \n", currLine, currPos, msg);
}
