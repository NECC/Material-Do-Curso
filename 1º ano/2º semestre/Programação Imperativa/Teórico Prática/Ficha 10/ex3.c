#include <stdio.h>
#include <stdlib.h>

typedef struct nodo {
    int valor;
    struct nodo *esq, *dir;
} * ABin;

int constroiEspinhaAux (ABin *a, ABin *ult){
    //esq -> a -> dir
    int r = 1;
    ABin esq = (*a)->esq;
    ABin dir = (*a)->dir;
    ABin nodo = *a;
    ABin newUlt;
    *ult = *a;
    if (*a == NULL) return 0;
    if (nodo->esq != NULL) {
        r += constroiEspinhaAux(&esq, &newUlt);
        newUlt->dir = *a;
        *a = esq;
        nodo->esq = NULL;
    }
    if (nodo->dir != NULL) {
        r += constroiEspinhaAux(&dir, &newUlt);
        (*ult)->dir = dir;
        (*ult) = newUlt;
    }
    return r;
}

int constroiEspinha (ABin *a){
    ABin ult;
    return (constroiEspinhaAux (a,&ult));
}

ABin equilibraEspinha (ABin *a, int n) {
    if (n < 0 || *a == NULL) return *a;
    
    int i,meio = n/2;
    ABin temp = *a;
    for(i = 0; i < meio && temp != NULL; i++) {
      temp = temp->dir;
    }
    
    ABin nodo = (*a)->dir;
    ABin ant = *a;
    while (nodo != temp) {
      ABin next = ant->dir;
      ant->dir = NULL;
      nodo->esq = ant;
      ant = next;
      nodo = nodo->dir;
    }
    ant->dir = NULL;
    nodo->esq = ant;
    
    *a = temp;
    for (; i < n && temp != NULL; i++, temp = temp->dir) {
        ant = temp;
    }
    ant->dir = NULL;
    
    return temp;
}

void equilibra (ABin *a) {
    int n = constroiEspinha(a);
    equilibraEspinha(a,n);
}
