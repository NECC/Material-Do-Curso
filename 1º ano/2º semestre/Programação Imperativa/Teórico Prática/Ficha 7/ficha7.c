#include <stdio.h>
#include <stdlib.h>

typedef struct celula {
    char *palavra;
    int ocorr;
    struct celula * prox;
} * Palavras;

void libertaLista (Palavras l){
    free(l);
}

int quantasP (Palavras l){
    Palavras temp = l;
    int i;
    
    for (i=0; temp != NULL; temp=temp->prox, i++);
    
    return i;
}

void listaPal (Palavras l){
    Palavras temp = l;
    int i = 0;
    
    while (temp != NULL) {
        i++;
        printf("%d, \'%s\' %d vezes\n", i, temp->palavra, temp->ocorr);
        temp = temp->prox;
    }
}
char * ultima (Palavras l){
    Palavras temp = l;
    char *pal = NULL;
    
    while (temp != NULL) {
        pal = temp->palavra;
        temp = temp->prox;
    }
    return pal;
}
Palavras acrescentaInicio (Palavras l, char *p){
    Palavras temp = malloc(sizeof(struct celula));
    temp->palavra = p;
    temp->ocorr = 1;
    temp->prox = l;
    return temp;
}
Palavras acrescentaFim (Palavras l, char *p){
    Palavras temp = malloc(sizeof(struct celula));
    temp->palavra = p;
    temp->ocorr = 1;
    temp->prox = NULL;
    Palavras t = l;
    
    if (l == NULL) return temp;
    
    while (t->prox != NULL) t = t->prox;
    t->prox = temp;
    
    return l;
}
Palavras acrescenta (Palavras l, char *p){
    Palavras t = l;
    
    if (t == NULL) return acrescentaInicio(l, p);
    
    while (t->prox != NULL) {
        if (!strcmp(t->palavra, p))
            break;
        t = t->prox;
    }
    
    if (!strcmp(t->palavra, p)) {
        (t->ocorr)++;
    } else {
        l = acrescentaInicio(l, p);
    }
    
    return l;
}
struct celula * maisFreq (Palavras l){
    int r = 0;
    Palavras t = l;
    struct celula *res = NULL;
    
    while (t != NULL) {
        if (t->ocorr > r) {
            r = t->ocorr;
            res = t;
        }
        t = t->prox;
    }
    
    return res;
}
