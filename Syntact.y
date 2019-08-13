
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
%type<TEXT> MK     RM       F       M  UM  REP  EXE ;
%type<TEXT> UN_FT;
%type<TEXT> UBYTE  FOPTION  STR_VAL REP_TYPE;


%start S

%%

S  :   S Line                                                                     {printf("recursivo lineas ");}
   |   Line                                                                       {printf("finalizado ");}

  ;


Line :  Mkdisk  MK                                                                 { printf("make disk command ");        }
     |  Rmdisk  RM                                                                 { printf("remove disk command ");      }
     |  Fdisk   RM                                                                 { printf("administer disk command ");  }
     |  Mount   M                                                                  { printf("mount   disk command ");     }
     |  Unmount UM                                                                 { printf("unmount disk command ");     }
     |  Report  REP                                                                { printf("report  disk command ");     }
     |  Execute RM                                                                 { printf("execute disk command ");     }                    
     |  exit_command                                                               { exit(EXIT_SUCCESS);                  }
;

MK : Size '=' Value_Int     Path '=' Value_String                                 {printf(" Size and Path ");  }
   | Path '=' Value_String  Size '=' Value_Int                                    {printf(" Path and Size");   }
   | Size '=' Value_Int     UN_FT                    Path '=' Value_String        {printf(" Size Unit Path");  }
   | UN_FT                  Size '=' Value_Int       Path '=' Value_String        {printf(" Unit Size  Path"); }
   | Size '=' Value_Int     Path '=' Value_String    UN_FT                        {printf(" Unit Size  Path"); }
;

RM : Path '=' Value_String                                                        {printf(" Path ");}

F :  Size '=' Value_Int     Path '=' Value_String    Name '=' STR_VAL             {printf(" Size and Path ");  }
   | Path '=' Value_String  Size '=' Value_Int                                    {printf(" Path and Size");   }

;

M :  Path '=' Value_String  Name '=' Id                                           { printf(" Path and Name ");} 
   | Name '=' Id            Path '=' Value_String                                 { printf(" Name and Path ");}
;

UM : Identify '=' Id                                                              { printf(" Identify ");     }
;

REP : Name    '=' Id  Path '=' Value_String   Identify '=' REP_TYPE               { printf(" Name , Path , Id ");     } 
;


EXE : Path    '=' Value_String                                                    { printf(" Path ");  }
;


UN_FT : Unit '=' UBYTE      Fit '=' FOPTION                                         { printf(" U/F ") ;}
      | Fit  '=' FOPTION    Unit '=' UBYTE                                          { printf(" F/U ") ;}  
      | Unit '=' UBYTE                                                              { printf(" U ")   ;}  
      | Fit  '=' FOPTION                                                            { printf(" F ")   ;}
; 



STR_VAL : Value_String 
        | Id
        
;

UBYTE : Kbytes
      | Mbytes
;

FOPTION : Bf 
        | Ff
        | Wf
;


REP_TYPE : Mbr                                                                { printf(" Mbr  "); }
         | Disc                                                               { printf(" Disc "); } 
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

