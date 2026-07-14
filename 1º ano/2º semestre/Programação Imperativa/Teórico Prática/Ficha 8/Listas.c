#include <stdio.h>
#include <stdlib.h>
#include "Listas.h"

LInt newLInt (int x, LInt xs){
    LInt r = malloc (sizeof(struct slist));
    if (r!=NULL) {
        r->valor = x; r->prox = xs;
    }
    return r;
}

DList newDList (int x, DList xs){
    DList r = malloc (sizeof(struct dlist));
    if (r!=NULL) {
        r->valor = x; r->prox = xs; r->ant = NULL;
    }
    return r;
}
