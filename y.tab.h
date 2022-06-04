/* A Bison parser, made by GNU Bison 3.0.4.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015 Free Software Foundation, Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

#ifndef YY_YY_Y_TAB_H_INCLUDED
# define YY_YY_Y_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token type.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    DIGIT = 258,
    IDENT = 259,
    NUMBER = 260,
    RETURN = 261,
    FUNCTION = 262,
    SEMICOLON = 263,
    BEGIN_PARAMS = 264,
    END_PARAMS = 265,
    BEGIN_LOCALS = 266,
    END_LOCALS = 267,
    BEGIN_BODY = 268,
    END_BODY = 269,
    INTEGER = 270,
    ARRAY = 271,
    ENUM = 272,
    OF = 273,
    IF = 274,
    THEN = 275,
    ENDIF = 276,
    ELSE = 277,
    FOR = 278,
    WHILE = 279,
    DO = 280,
    BEGIN_LOOP = 281,
    END_LOOP = 282,
    CONTINUE = 283,
    READ = 284,
    WRITE = 285,
    AND = 286,
    OR = 287,
    NOT = 288,
    TRUE = 289,
    FALSE = 290,
    COLON = 291,
    COMMA = 292,
    L_PAREN = 293,
    R_PAREN = 294,
    L_SQUARE_BRACKET = 295,
    R_SQUARE_BRACKET = 296,
    SUB = 297,
    ADD = 298,
    MULT = 299,
    DIV = 300,
    MOD = 301,
    EQ = 302,
    NEQ = 303,
    LT = 304,
    GT = 305,
    LTE = 306,
    GTE = 307,
    ASSIGN = 308
  };
#endif

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED

union YYSTYPE
{
#line 35 "miniL.y" /* yacc.c:1909  */

  int int_val;
  char* ident;
  float number;
  
  struct Statement{
    char* code;
  } statement;

  struct Expression{
    char* code;  
  } expression;


#line 123 "y.tab.h" /* yacc.c:1909  */
};

typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_Y_TAB_H_INCLUDED  */
