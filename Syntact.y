
%{
#include <stdio.h>
#include <stdlib.h>



//int yylex (void);

extern int yylineno;    //linea actual donde se encuentra el parser (analisis lexico) lo maneja BISON
extern int columna;     //columna actual donde se encuentra el parser (analisis lexico) lo maneja BISON
extern char *yytext;    //lexema actual donde esta el parser (analisis lexico) lo maneja BISON
int yylex (void);
  void yyerror (char  *);


%}


%union{
//se especifican los tipo de valores para los no terminales y lo terminales
char TEXT [256];
char TEXT2 [256];
//class NodoAST *nodito;
}


//error-verbose si se especifica la opcion los errores sintacticos son especificados por BISON

//%error-verbose
%locations

//TERMINALES DE TIPO TEXT, SON STRINGS
%token<TEXT> Value_Int;
%token<TEXT> Value_Double;
%token<TEXT> Value_Char;
%token<TEXT> Value_String;
%token<TEXT> Id;

%token<TEXT>   exit_command;
%token<TEXT>   Mkdisk;
%token<TEXT>   Rmdisk;
%token<TEXT>   Fdisk;
%token<TEXT>   Mount;
%token<TEXT>   Unmount;
%token<TEXT>   Report;
%token<TEXT>   Execute;
%token<TEXT>   Size;
%token<TEXT>   Fit;
             
%token<TEXT>   Bf;
%token<TEXT>   Ff;
%token<TEXT>   Wf;
%token<TEXT>   Unit;
%token<TEXT>   Kbytes;
%token<TEXT>   Mbytes;
             
%token<TEXT>   Path;
%token<TEXT>   Type;
%token<TEXT>   Primary;
%token<TEXT>   Extended;
             
%token<TEXT>   Logic;
%token<TEXT>   Delete;
%token<TEXT>   Fast;
%token<TEXT>   Full;
%token<TEXT>   Name;
%token<TEXT>   Add;
%token<TEXT>   Mbr;
  
%token<TEXT>   Ebr;
%token<TEXT>   Disc;
%token<TEXT>   Identify;





/*------------- NONTerminals ------------------*/


%type<TEXT> S      Line ;
%type<TEXT> MK     RM ;
%type<TEXT> UN_FT;
%type<TEXT> UBYTE  FOPTION ;


%start S

%%

S  :   S Line                                                                     {printf("recursivo lineas ");}
   |   Line                                                                       {printf("finalizado ");}

  ;


Line :  Mkdisk MK                                                                 { printf("make disk command ");   }
     |  Rmdisk RM                                                                 { printf("remove disk command "); }
     |  exit_command                                                              { exit(EXIT_SUCCESS);             }
;

MK : Size '=' Value_Int     Path '=' Value_String                                 {printf(" Size and Path ");  }
   | Path '=' Value_String  Size '=' Value_Int                                    {printf(" Path and Size");   }
   | Size '=' Value_Int     UN_FT                    Path '=' Value_String        {printf(" Size Unit Path");  }
   | UN_FT                  Size '=' Value_Int       Path '=' Value_String        {printf(" Unit Size  Path"); }
   | Size '=' Value_Int     Path '=' Value_String    UN_FT                        {printf(" Unit Size  Path"); }
;

RM : Path '=' Value_String                                                          {printf(" Path ");}




UN_FT : Unit '=' UBYTE      Fit '=' FOPTION                                         { printf(" U/F ") ;}
      | Fit  '=' FOPTION    Unit '=' UBYTE                                          { printf(" F/U ") ;}  
      | Unit '=' UBYTE                                                              { printf(" U ")   ;}  
      | Fit  '=' FOPTION                                                            { printf(" F ")   ;}
; 



UBYTE : Kbytes
      | Mbytes
;

FOPTION : Bf 
        | Ff
        | Wf
;


%%



main(void){

   if(yyparse()== 0)
       printf("hola");
   return 0;


}

void yyerror( char* mens)
{
    fprintf(stderr , mens,  "%s\n"  );
}

