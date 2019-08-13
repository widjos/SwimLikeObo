
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
%token<TEXT> INT;
%token<TEXT> DOUBLE;
%token<TEXT> CHAR;
%token<TEXT> STRING;
%token<TEXT> ID;

%token<TEXT>   exit_command;
%token<TEXT>   MKDISK;  	 
%token<TEXT>   RMDISK; 	 
%token<TEXT>   FDISK;	 
%token<TEXT>   MOUNT;	 
%token<TEXT>   UNMOUNT;  	 
%token<TEXT>   REPORT;	 
%token<TEXT>   EXECUTE; 	 
%token<TEXT>   SIZE;    	 
%token<TEXT>   FIT; 	 
             
%token<TEXT>   BF;   	 
%token<TEXT>   FF;  	 
%token<TEXT>   WF;   	 
%token<TEXT>   UNIT;   	 
%token<TEXT>   KBYTES;	 
%token<TEXT>   MBYTES;	 
             
%token<TEXT>   PATH;      	 
%token<TEXT>   TYPE;     	 
%token<TEXT>   PRIMARY;
%token<TEXT>   EXTENDED;     	      	 
             
%token<TEXT>   LOGIC;   
%token<TEXT>   DELETE;   
%token<TEXT>   FAST;    
%token<TEXT>   FULL;    
%token<TEXT>   NAME;    
%token<TEXT>   ADD;    
%token<TEXT>   MBR; 
  
%token<TEXT>   EBR;
%token<TEXT>   DISC;
%token<TEXT>   IDENTIFY;     
%token<TEXT>   ER;  		 




/*------------- NONTerminals ------------------*/


%type<TEXT> S Line MK  ;



%start S

%%

S  :   S Line   {printf("recursivo lineas ");}
   |   Line     {printf("finalizado ");}

  ;


  Line :  MKDISK MK      { printf("make disk command ");}
       |  exit_command   { exit(EXIT_SUCCESS); }
  ;

  MK : SIZE '=' INT      {printf("size fint "); }
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

