/* A Bison parser, made by GNU Bison 3.3.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015, 2018-2019 Free Software Foundation,
   Inc.

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

/* Undocumented macros, especially those whose name start with YY_,
   are private implementation details.  Do not rely on them.  */

#ifndef YY_YY_SYNTACT_TAB_H_INCLUDED
# define YY_YY_SYNTACT_TAB_H_INCLUDED
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
    Value_Int = 258,
    Value_Double = 259,
    Value_Char = 260,
    Value_String = 261,
    Id = 262,
    exit_command = 263,
    Mkdisk = 264,
    Rmdisk = 265,
    Fdisk = 266,
    Mount = 267,
    Unmount = 268,
    Report = 269,
    Execute = 270,
    Size = 271,
    Fit = 272,
    Bf = 273,
    Ff = 274,
    Wf = 275,
    Unit = 276,
    Kbytes = 277,
    Mbytes = 278,
    Bytes = 279,
    Path = 280,
    Type = 281,
    Primary = 282,
    Extended = 283,
    Logic = 284,
    Delete = 285,
    Fast = 286,
    Full = 287,
    Name = 288,
    Add = 289,
    Mbr = 290,
    Ebr = 291,
    Disc = 292,
    Identify = 293,
    Url = 294
  };
#endif

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED

union YYSTYPE
{
#line 20 "Syntact.y" /* yacc.c:1921  */

//se especifican los tipo de valores para los no terminales y lo terminales
char TEXT [256];
char TEXT2 [256];
//class NodoAST *nodito;

#line 105 "Syntact.tab.h" /* yacc.c:1921  */
};

typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif

/* Location type.  */
#if ! defined YYLTYPE && ! defined YYLTYPE_IS_DECLARED
typedef struct YYLTYPE YYLTYPE;
struct YYLTYPE
{
  int first_line;
  int first_column;
  int last_line;
  int last_column;
};
# define YYLTYPE_IS_DECLARED 1
# define YYLTYPE_IS_TRIVIAL 1
#endif


extern YYSTYPE yylval;
extern YYLTYPE yylloc;
int yyparse (void);

#endif /* !YY_YY_SYNTACT_TAB_H_INCLUDED  */
