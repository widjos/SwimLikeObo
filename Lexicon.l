/*
 * @Autor WIdvin Qui;onez
*/

%option case-insensitive
%option yylineno


%{
#include <stdio.h>
#include <stdlib.h>
#include "Syntact.tab.h"


//VARIBLE




%}




letra  	 ([a-zñA-ZÑ])+
numero 	 ([0-9])+
booleano ("verdadero"|"falso")
decimal  ([0-9])+"."([0-9])+
caracter "\'"("\\")?({letra}|{numero})"\'"
id 		 ({letra})({letra}|{numero}|"_")*
cadena 	 "\""[^"\""]*"\""
file_type ("mbr"|"disk"|"sh")
url       (("/")({id}))+"."({file_type})



%x COM
%%


INITIAL
{

"#"                                  { 	BEGIN COM;          }

{numero}                             {  strcpy(yylval.TEXT, yytext);    return Value_Int;        }
{decimal}                            {  strcpy(yylval.TEXT, yytext);    return Value_Double;     }
{caracter}                           {  strcpy(yylval.TEXT, yytext);    return Value_Char;       }
{cadena}                             {  strcpy(yylval.TEXT, yytext);    return Value_String;     }
{url}                                {  strcpy(yylval.TEXT, yytext);    return Url;              }


"mkdisk"                             {   strcpy(yylval.TEXT, yytext);   return Mkdisk;     }
"Rmdisk"                             {   strcpy(yylval.TEXT, yytext);   return Rmdisk;     }
"Fdisk"                              {   strcpy(yylval.TEXT, yytext);   return Fdisk;      }
"Mount"                              {   strcpy(yylval.TEXT, yytext);   return Mount;      }
"Unmount"                            {   strcpy(yylval.TEXT, yytext);   return Unmount;    }
"Rep"                                {   strcpy(yylval.TEXT, yytext);   return Report;     }
"Exec"                               {   strcpy(yylval.TEXT, yytext);   return Execute;    }
"-Size"                              {   strcpy(yylval.TEXT, yytext);   return Size;       }
"-Fit"                               {   strcpy(yylval.TEXT, yytext);   return Fit;        }
"Bf"                                 {   strcpy(yylval.TEXT, yytext);   return Bf;         }
"Ff"                                 {   strcpy(yylval.TEXT, yytext);   return Ff;         }
"Wf"                                 {   strcpy(yylval.TEXT, yytext);   return Wf;         }
"-Unit"                              {   strcpy(yylval.TEXT, yytext);   return Unit;       }
"B"                                  {   strcpy(yylval.TEXT, yytext);   return Bytes;      }
"K"                                  {   strcpy(yylval.TEXT, yytext);   return Kbytes;     }
"M"                                  {   strcpy(yylval.TEXT, yytext);   return Mbytes;     }
"-Path"                              {   strcpy(yylval.TEXT, yytext);   return Path;       }
"-Type"                              {   strcpy(yylval.TEXT, yytext);   return Type;       }
"P"                                  {   strcpy(yylval.TEXT, yytext);   return Primary;    }
"E"                                  {   strcpy(yylval.TEXT, yytext);   return Extended;   }
"L"                                  {   strcpy(yylval.TEXT, yytext);   return Logic;      }
"-Delete"                            {   strcpy(yylval.TEXT, yytext);   return Delete;     }
"Fast"                               {   strcpy(yylval.TEXT, yytext);   return Fast;       }
"Full"                               {   strcpy(yylval.TEXT, yytext);   return Full;       }
"-Name"                              {   strcpy(yylval.TEXT, yytext);   return Name;       }
"-Add"                               {   strcpy(yylval.TEXT, yytext);   return Add;        }
"Mbr"                                {   strcpy(yylval.TEXT, yytext);   return Mbr;        }
"Ebr"                                {   strcpy(yylval.TEXT, yytext);   return Ebr;        }
"Disc"                               {   strcpy(yylval.TEXT, yytext);   return Disc;       }
"-Id"                                {   strcpy(yylval.TEXT, yytext);   return Identify;   }
"exit"                               {   strcpy(yylval.TEXT, yytext);   return exit_command; }

=                                    { return yytext[0]; }

{id}                                 {  strcpy(yylval.TEXT, yytext);  return Id;         }
[ \t\n]                               ;


.                                     { ECHO; yyerror("\n Errror lexico \n");   }



}


<COM>"\n"                              { BEGIN INITIAL; };
<COM>.   {};


%%

int yywrap(void) {
    return 1;
}
