#include <stdio.h>
#include <stdlib.h>

typedef struct nodo {
    int valor;
    struct nodo *esq, *dir;
} * ABin;

void rodaEsquerda (ABin *a){
    ABin b = (*a)->dir;
    (*a)->dir = b->esq;
    b->esq = (*a);
    *a = b;
}
void rodaDireita (ABin *a){
    ABin b = (*a)->esq;
    (*a)->esq = b->dir;
    b->dir = *a;
    *a = b;
}

void promoveMenor (ABin *a){
    while ((*a)->esq != NULL) rodaDireita(a);
}

void promoveMaior (ABin *a){
    while ((*a)->dir != NULL) rodaEsquerda(a);
}

ABin removeMenorAlt (ABin *a){
    while ((*a)->esq != NULL) rodaDireita(a);
    ABin temp = malloc(sizeof(struct nodo));
    temp->esq = temp->dir = NULL;
    temp->valor = (*a)->valor;
    removeRaiz(a);
    return temp;
}
