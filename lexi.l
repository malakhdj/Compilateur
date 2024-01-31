%{
 #include "synty.tab.h"
 int numLigne = 1;
 extern YYSTYPE yylval;
 #include "Bib.h"

%}


lettre [a-zA-z]
chiffre [0-9]
idf [A-Z]+[A-Za-z0-9]*(_[A-Za-z0-9]+)*
cst [0-9]

comment "{"[^}]*"}"
%%
{cst} { yylval.entier=atoi(yytext);return cst;}
{idf} { yylval.str=strdup(yytext); return mc_idf;}

"var" return mc_var;
"int" {   yylval.str=strdup(yytext);
        return mc_int;}
"float" { yylval.str=strdup(yytext);
        return mc_float;}
"bool" {  yylval.str=strdup(yytext);
        return mc_bool;}
"const"  {yylval.str=strdup(yytext); return mc_const;}

"begin" {return mc_begin;}
"end" {return mc_end;}
"if" return mc_if;
"else" return mc_else;
"for" return mc_For;
"function" return mc_function;
"return" return mc_return;


{comment} return comment;
":" return dp;
";" return pvg;
"," return vg;
":=" return aff;
"+" return plus;
"-" return moins;
"\*" return multi;
"\/" return divi;
"\(" return parent_ouv;
"\)" return parent_ferm;
"\<" return inf;
"\>" return sup;
"\<=" return infe;
"\>=" return supe;
"\<>" return diff;
"\==" return egal;
"\{"  return acoll_ouv;
"\}" return acoll_ferm;
[ \t]
[\n] numLigne++;
. {printf("erreur lexicale a la ligne %d sur l'entite %s\n",numLigne,yytext);
    return err;
}
