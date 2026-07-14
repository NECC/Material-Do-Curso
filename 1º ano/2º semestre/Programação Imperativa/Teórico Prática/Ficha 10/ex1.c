#include <stdio.h>
#include <stdlib.h>

typedef struct nodo {
    int valor;
    struct nodo *esq, *dir;
} * ABin;

ABin removeMenor (ABin *a) {
    ABin ant, temp = *a;
    if (*a == NULL) return NULL;

    while (temp->esq != NULL) {
        ant = temp;
        temp = temp->esq;
    }

    ant->esq = temp->dir;
    return temp;
}

void removeRaiz (ABin *a) {
    if ((*a)->esq == NULL) *a = (*a)->dir;
    else if ((*a)->dir == NULL) *a = (*a)->esq;
    else {
        ABin temp = (*a)->dir;
        ABin ant = *a;
        while (temp->esq != NULL) {
            ant = temp;
            temp = temp->esq;
        }
        if (ant == *a) {
            ant->dir = temp->dir;
        } else {
            ant->esq = temp->dir;
        }
        (*a)->valor = temp->valor;
        free(temp);
    }
}

int removeElem (ABin *a, int x){
    if (*a == NULL) return -1;
    if ((*a)->valor == x) {
        removeRaiz(a);
        return 0;
    }
    if ((*a)->valor < x) {
        ABin nova = (*a)->dir;
        if (!removeElem(&nova, x)) {
            (*a)->dir = nova;
            return 0;
        }
        return -1;
    }
    ABin nova = (*a)->esq;
    if (!removeElem(&nova, x)) {
        (*a)->esq = nova;
        return 0;
    }
    return -1;
}
