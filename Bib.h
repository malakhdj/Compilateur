#include <stdio.h>
#include <string.h>

typedef struct
{
 char NomEntite [20];
 char TypeEntite [5];
 int Constante;
} TypeTS;



TypeTS ts[100]; //tableau n7atou fih klch wch ns79ou 3la les var li 7anafichiwhoum

int CpTabSym=0; //compteur bch ya7sblna ch7al 3ndna m var

void Inserer(char entite[]){
   if(Recherche(entite)==-1){
        strcpy(ts[CpTabSym].NomEntite,entite);
       CpTabSym++;
   }
};

int Recherche(char entite[]) {
    int i=-1;

    while (i<CpTabSym) {
        if (strcmp(entite,ts[i].NomEntite)==0) return i;
        i++;
    }

    return -1;
};

int NonDeclare(char entite[]){
    int postEntite=Recherche(entite);
    if (strcmp(ts[postEntite].NomEntite,entite)==0) return 1;
    else return 0;
};


void InsererType(char entite[], char type[]){
   int postEntite=Recherche(entite);
    if(postEntite!=-1){
        strcpy(ts[postEntite].TypeEntite,type);
       
    }
};

void InsererConst(char entite[]){
    int postEntite=Recherche(entite);
    ts[postEntite].Constante=1;
};




int DoubleDec(char entite[]){
    int postEntite=Recherche(entite);
    if (strcmp(ts[postEntite].NomEntite,entite)==0) return 1;
    else return 0;
};


int EstConstante(char entite[]){
    int postEntite=Recherche(entite);
    if (ts[postEntite].Constante==1) return 1;
    else return 0;
};

void Afficher(){
    printf("\n/****************************Table De Symboles****************************/\n");
    printf("__________________________________________\n");
    printf("\t|    Nom Entite     |    Type       |\n");
    printf("__________________________________________\n");

    int i=0;

    while (i<CpTabSym){
        printf("\t|%10s    |%12s      \n", ts[i].NomEntite, ts[i].TypeEntite);
        i++;
    }
};
