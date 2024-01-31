%{
#include <stdio.h>
#include <string.h>
extern int numLigne;
int CodeOpr=0; // 1:+ 2:- 3:* 4: /
char sauvType [20];
char Nomidf [20];
%}

%union {
float entier;
char* str;
}

%token <str> mc_idf mc_var dp pvg <str>mc_int <str>mc_float <str>mc_bool err vg mc_const aff <str>mc_begin <str>mc_end
%token <entier>cst plus moins multi divi parent_ouv parent_ferm mc_if acoll_ouv acoll_ferm mc_For inf sup infe supe diff egal mc_function
%token mc_return comment mc_else
%start S
%%
S :mc_var declarations mc_begin INST mc_end{printf("syntax correct\n"); YYACCEPT;}
     |{printf("syntax correct\n"); YYACCEPT;}
;
declarations:declaration declarations | declaration ;

declaration :Type Listidf pvg
             |Type mc_idf aff declcst{if (DoubleDec($2)==0){Inserer($2);} else {printf("erreur Semantique: double declaration de %s,a la ligne %d\n",$2,numLigne);} strcpy(Nomidf,$2);}
             |FuncDec
             |{printf("syntax correct\n"); YYACCEPT;}
             |comment;

Listidf :mc_idf vg Listidf {if (DoubleDec($1)==0){Inserer($1);} else {printf("erreur Semantique: double declaration de %s,a la ligne %d\n",$1,numLigne);} strcpy(Nomidf,$1);}
        |mc_idf {if (DoubleDec($1)==0){Inserer($1);} else {printf("erreur Semantique: double declaration de %s , a la ligne %d\n",$1,numLigne);} strcpy(Nomidf,$1);}
             ;
declcst:cst pvg ;
Type :mc_int {strcpy(sauvType,$1);InsererType(Nomidf,sauvType);}
      |mc_float {strcpy(sauvType,$1);InsererType(Nomidf,sauvType);}
      |mc_bool {strcpy(sauvType,$1);InsererType(Nomidf,sauvType);}
      |mc_const {strcpy(sauvType,$1);InsererType(Nomidf,sauvType);}
;

FuncDec :Type mc_function mc_idf mc_var declaration mc_begin INST mc_return mc_idf pvg mc_end
;

INST :mc_idf aff Expr pvg {if (EstConstante($1)==1){printf("Erreur semantique: Changement de valeur de la constante %s a la ligne %d\n",$1 ,numLigne);} else {if (NonDeclare($1)==0) {printf("Erreur Semantique : la variable %s est non declaree\n",$1);};};}
     |mc_For parent_ouv init vg Condition vg incre parent_ferm acoll_ouv INST acoll_ferm
     |ConditionIf
     |{printf("syntax correct\n"); YYACCEPT;}
     |comment
    ;

Expr :mc_idf OprtAri mc_idf {if(NonDeclare($1)==0) printf("Erreur Semantique : la variable %s est non declaree\n",$1);}
      |mc_idf OprtAri cst {if(NonDeclare($1)==0) printf("Erreur Semantique : la variable %s est non declaree\n",$1);}
      |mc_idf {if (($1==0)&&(CodeOpr==4)) printf("erreur symantique :division sur 0 a la ligne %d\n",numLigne);if(NonDeclare($1)==0) printf("Erreur Semantique : la variable %s est non declaree\n",$1);}
    ;

OprtAri :plus {CodeOpr=1;}
        |moins {CodeOpr=2;}
        |multi {CodeOpr=3;}
        |divi {CodeOpr=4;}
;
init :mc_idf aff cst;

Condition :mc_idf Oprt mc_idf {if(NonDeclare($1)==0) printf("Erreur Semantique : la variable %s est non declaree\n",$1);}
;


ConditionIf :mc_if parent_ouv Condition parent_ferm acoll_ouv INST acoll_ferm
            |ConditionIf mc_else acoll_ouv INST acoll_ferm

incre :mc_idf OprtAri cst ;

Oprt :inf
     |sup
     |infe
     |supe
     |egal
     |diff
;
%%

main()
{

yyparse();
Afficher();

}

yywrap()
{}

int yyerror ( char* msg)
{
printf("Erreur syntaxique à la ligne %d\n",numLigne);
}
