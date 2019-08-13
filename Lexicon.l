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




%x COM
%%


INITIAL
{

"#"                                  { 	BEGIN COM;          }

{numero}                             {strcpy(yylval.TEXT, yytext);  return INT;}
{decimal}                            {  strcpy(yylval.TEXT, yytext);    return DOUBLE;     }
{caracter}                           {  strcpy(yylval.TEXT, yytext);   return CHAR;       }
{cadena}                             {   strcpy(yylval.TEXT, yytext);  return STRING;     }



"mkdisk"                             {strcpy(yylval.TEXT, yytext);  printf("encontro");   return MKDISK;}
"Rmdisk"                             {   strcpy(yylval.TEXT, yytext);   return RMDISK;     }
"Fdisk"                              {   strcpy(yylval.TEXT, yytext);   return FDISK;      }
"Mount"                              {   strcpy(yylval.TEXT, yytext);   return MOUNT;      }
"Unmount"                            {   strcpy(yylval.TEXT, yytext);   return UNMOUNT;    }
"Rep"                                {   strcpy(yylval.TEXT, yytext);   return REPORT;     }
"Exec"                               {   strcpy(yylval.TEXT, yytext);   return EXECUTE;    }
"-Size"                              {   strcpy(yylval.TEXT, yytext);   return SIZE;       }
"-Fit"                               {   strcpy(yylval.TEXT, yytext);   return FIT;        }
"Bf"                                 {    strcpy(yylval.TEXT, yytext);  return BF;         }
"Ff"                                 {   strcpy(yylval.TEXT, yytext);   return FF;         }
"Wf"                                 {   strcpy(yylval.TEXT, yytext);   return WF;         }
"-Unit"                              {   strcpy(yylval.TEXT, yytext);  return UNIT;       }
"K"                                  {  strcpy(yylval.TEXT, yytext);   return KBYTES;     }
"M"                                  {   strcpy(yylval.TEXT, yytext);  return MBYTES;     }
"-Path"                              {  strcpy(yylval.TEXT, yytext);   return PATH;       }
"-Type"                              {   strcpy(yylval.TEXT, yytext);  return TYPE;       }
"P"                                  {   strcpy(yylval.TEXT, yytext);  return PRIMARY;    }
"E"                                  {   strcpy(yylval.TEXT, yytext);  return EXTENDED;   }
"L"                                  {  strcpy(yylval.TEXT, yytext);   return LOGIC;      }
"-Delete"                            {  strcpy(yylval.TEXT, yytext);   return DELETE;     }
"Fast"                               {  strcpy(yylval.TEXT, yytext);   return FAST;       }
"Full"                               {   strcpy(yylval.TEXT, yytext);  return FULL;       }
"-Name"                              {   strcpy(yylval.TEXT, yytext);  return NAME;       }
"-Add"                               {   strcpy(yylval.TEXT, yytext);  return ADD;        }
"Mbr"                                {   strcpy(yylval.TEXT, yytext);  return MBR;        }
"Ebr"                                {   strcpy(yylval.TEXT, yytext);  return EBR;        }
"Disc"                               {   strcpy(yylval.TEXT, yytext);  return DISC;       }
"-Id"                                {   strcpy(yylval.TEXT, yytext);  return IDENTIFY;   }
"exit"                               {   strcpy(yylval.TEXT, yytext);printf("saliendo del sistemas"); return exit_command; }

=                                   return yytext[0];

{id}                                  {  strcpy(yylval.TEXT, yytext);  return ID;         }
[ \t\n]                               ;


.                                       { ECHO; yyerror("\n Errror lexico \n");   }



}


<COM>"\n"                               {  BEGIN INITIAL; };
<COM>.;


%%

int yywrap(void) {
    return 1;
}
