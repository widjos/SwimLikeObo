
%{
#include <stdio.h>
#include <stdlib.h>



//int yylex (void);

extern int yylineno;    //linea actual donde se encuentra el parser (analisis lexico) lo maneja BISON
extern int columna;     //columna actual donde se encuentra el parser (analisis lexico) lo maneja BISON
extern char *yytext;    //lexema actual donde esta el parser (analisis lexico) lo maneja BISON
int yylex (void);
void yyerror (char  *);

struct  disk {
    int size;
    char *path;
    char unit;
    char *fit;
};


struct disk tempDisk; 


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
%token<TEXT>   Bytes;
             
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
%token<TEXT>   Url;




/*------------- NONTerminals ------------------*/


%type<TEXT> S      Line ;
%type<TEXT> MK     RM       F       M  UM  REP  EXE ;
%type<TEXT> UN_FT;
%type<TEXT> UBYTE  FOPTION  STR_VAL REP_TYPE  ;
%type<TEXT>  DTYPE  TPARTITION ;
%type<TEXT> P_OPTION  COMMAND;


%start S

%%

 S : COMMAND                                                                        {printf("fin");}
     ;

COMMAND  :   COMMAND Line                                                               {printf("Recursivo");}
         |    Line                                                                  {printf("Prueba");}
  ;


Line :  Mkdisk  MK                                                                 { checkMakeDisk(tempDisk);  tempDisk.size=0; tempDisk.path = NULL; tempDisk.unit = NULL; tempDisk.fit = NULL;  }
     |  Rmdisk  RM                                                                 { printf("remove disk command ");      }
     |  Fdisk   F                                                                  { printf("administer disk command ");  }
     |  Mount   M                                                                  { printf("mount   disk command ");     }
     |  Unmount UM                                                                 { printf("unmount disk command ");     }
     |  Report  REP                                                                { printf("report  disk command ");     }
     |  Execute EXE                                                                { printf("execute disk command ");     }
     |  exit_command                                                               { printf("Saliendo del gestor de discos \n");   exit(EXIT_SUCCESS);                  }
     |  error                                                                      { }
;

MK :  Size   '=' Value_Int                                                        { tempDisk.size = atoi($3); printf("size1");}
   |  Path   '=' P_OPTION                                                         { tempDisk.path = $3;       printf("path1");}
   |  Unit   '=' UBYTE                                                            { tempDisk.unit = $3;       printf("UNit1");}
   |  Fit    '=' FOPTION                                                          { tempDisk.fit =  $3;       printf("Fit1");}
   |  MK   Size       '=' Value_Int                                               { tempDisk.size = atoi($4); printf("size2");}
   |  MK   Path       '=' P_OPTION                                                { tempDisk.path = $4;       printf("path2");}
   |  MK   Unit       '=' UBYTE                                                   { tempDisk.unit = $4;       printf("unit2");}
   |  MK   Fit        '=' FOPTION                                                 { tempDisk.fit =  $4;       printf("Fit2");}

;

RM : Path '=' P_OPTION                                                            {printf(" Path ");}
;

F :  F  Size    '=' Value_Int                                                     {;}
   | F  Unit    '=' UBYTE                                                         {;}
   | F  Path    '=' P_OPTION                                                      {;}
   | F  Type    '=' TPARTITION                                                    {;}
   | F  Fit     '=' FOPTION                                                       {;}
   | F  Delete  '=' DTYPE                                                         {;}
   | F  Name    '=' Id                                                            {;}
   | F  Add     '=' Value_Int                                                     {;}  
   |    Size    '=' Value_Int                                                     {;}  
   |    Unit    '=' UBYTE                                                         {;}
   |    Path    '=' P_OPTION                                                      {;}
   |    Type    '=' TPARTITION                                                    {;}
   |    Fit     '=' FOPTION                                                       {;}
   |    Delete  '=' DTYPE                                                         {;}  
   |    Name    '=' Id                                                            {;}
   |    Add     '=' Value_Int                                                     {;}      
;





M :  Path '=' P_OPTION      Name '=' Id                                             { printf(" Path and Name ");} 
   | Name '=' Id            Path '=' P_OPTION                                       { printf(" Name and Path ");}
   | error
;

UM : Identify '=' Id                                                                { printf(" Identify ");     }
    | error                                                                         {;}
;

REP : Identify   '=' Id  Path '=' P_OPTION  Name '=' REP_TYPE                       { printf(" Name , Path , Id ");     } 
    | error                                                                         {;}
;


EXE : Path    '=' P_OPTION                                                          { printf(" Path ");  }
    | error                                                                         {;}
;


UN_FT : Unit '=' UBYTE      Fit '=' FOPTION                                         { printf(" U/F ") ;}
      | Fit  '=' FOPTION    Unit '=' UBYTE                                          { printf(" F/U ") ;}  
      | Unit '=' UBYTE                                                              { printf(" U ")   ;}  
      | Fit  '=' FOPTION                                                            { printf(" F ")   ;}
; 



STR_VAL : Value_String                                                               {;}
        | Id                                                                         {;}
        | error                                                                      {;}   
        
;

UBYTE : Kbytes                                                                       {strcpy($$,$1);}
      | Mbytes                                                                       {strcpy($$,$1);}
      | Bytes                                                                        {strcpy($$,$1);}
;

FOPTION : Bf                                                                         {strcpy($$,$1);}
        | Ff                                                                         {strcpy($$,$1);}
        | Wf                                                                         {strcpy($$,$1);}
        | error                                                                      {;} 
;


REP_TYPE : Mbr                                                                { printf(" Mbr  "); }
         | Disc                                                               { printf(" Disc "); } 
         | error                                                              {}    
;         


P_OPTION : Value_String                                                       { strcpy($$,$1);}
         | Url                                                                { strcpy($$,$1); }    
 ; 

DTYPE    : Fast                                                               { printf(" Fast");}
         | Full                                                               { printf( "Full"); }

 ;

TPARTITION : Primary                                                          { printf(" Primary");}
           | Extended                                                         { printf(" Extebded");}  
           | Logic                                                            { printf(" Logic"); }
;

%%


 
FILE *fp;
char direccion[300];
int c;



main(void){

  printf("Welcome to the diskParter \n");
  
   return yyparse();


}

void yyerror( char* mens)
{
    fprintf(stderr , mens,  "%s\n"  );
}


void  createDisk(struct disk diskInput ){
        fp = fopen( diskInput.path,"w");


}

void cleanStr( char input[]){

int index ;

    for(index = 0 ; index < sizeof(input) ; index++){
        c = input[index];
        if(c != '\"'){
            direccion[index] = c;
        }
    }

 printf(direccion);

}


void checkMakeDisk(struct disk input){

    if(input.path == NULL){
        printf("Path obligatorio ");
    }
    else if( (input.size == NULL ) || (input.size < 1)){
        printf("Definir size del disco obligatorio");
    }
    else {
        printf("the path is: ","%s" , input.path); 
    }

}
