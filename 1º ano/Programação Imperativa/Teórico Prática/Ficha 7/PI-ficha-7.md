Considere que se pretende armazenar quantas vezes uma determinada palavra aparece num texto.
Para isso definiu-se o seguinte tipo (listas ligadas em que cada elemento armazena uma palavra e o
número de vezes que essa palavra ocorre).

```c title:"Celula lista ligada"
typedef struct celula {
    char *palavra;
    int ocorr;
    struct celula * prox;
} * Palavras;
```

Assume-se que a lista não tem palavras repetidas.
Apresente definições para as seguintes funções:

1. `void libertaLista (Palavras)` que liberta todo o espaço (da heap) ocupado pela lista de
palavras.
2. `Lista quantasP (Palavras l)` que calcula quantas palavras (diferentes) existem armazenadas.
3. `void listaPal (Palavras l)` que escreve no ecrã, uma por linha, todas as palavras armazenadas, bem como o número de ocorrências.
4. `char * ultima (Palavras l)` que determina qual a última palavra da lista.
5. `Palavras acrescentaInicio (Palavras l, char *p)` que acrescenta uma palavra no início
da lista (com 1 como número de ocorrências).
6. `Palavras acrescentaFim (Palavras l, char *p)` que acrescenta uma palavra no fim da lista
(com 1 como número de ocorrências).
7. `Palavras acrescenta (Palavras l, char *p)` que regista mais uma ocorrência da palavra p.
Se a palavra já existir, o número de ocorrências deve ser incrementado. No outro caso deve ser
inserida uma nova célula.
A inserção de uma nova célula pode ser feita no início da lista ou ordenadamente, assumindo
que a lista está armazenada por ordem alfabética.
8. `struct celula * maisFreq (Palavras l)` que calcula a célula correspondente á palavra mais
frequente.

```c title:"Resolução com main incluido"
#include <stdio.h>
#include <stdlib.h>
#include "tipos.h"

typedef struct celula {
    char *palavra;
    int ocorr;
    struct celula * prox;
} * Palavras;

void libertaLista (Palavras l){
  Palavras temp = NULL;
  while(l != NULL){
    temp = l;
    l = l->prox;
    free(temp);
  }
}

int quantasP (Palavras l){
  int conta = 0;
  while(l != NULL){
    l = l->prox;
    conta++;
  }
  return conta;
}

void listaPal (Palavras l){
  while(l != NULL){
    printf("%s, %d\n", l->palavra, l->ocorr);
    l = l->prox;
  }
}

char * ultima (Palavras l){
  Palavras ant;
  if(l == NULL) return NULL;
  while(l != NULL){
    ant = l;
    l = l->prox;
  }
  return (ant->palavra);
}
Palavras acrescentaInicio (Palavras l, char *p){
  Palavras new = malloc(sizeof(struct celula));
  new->palavra = p;
  new->ocorr = 1;
  new->prox = l;
  return new;
}

Palavras acrescentaFim (Palavras l, char *p){
  Palavras new = malloc(sizeof(struct celula));
  new->palavra = p;
  new->ocorr = 1;
  new->prox = NULL;
  Palavras actual = l;
  if(l == NULL) return new;
  while(actual->prox != NULL){
    actual = actual->prox;
  }
  actual->prox = new;
  return l;
}

Palavras acrescenta (Palavras l, char *p){
  Palavras new;
  new = malloc(sizeof(struct celula));
  new->palavra = p;
  new->ocorr = 1;
  new->prox = l;
  if(l == NULL || strcmp(l->palavra, p) > 0) return new;
  if(strcmp(l->palavra, p) == 0){
    l->ocorr++;
    free(new);
    return l;
  }
  Palavras ant = l;
  Palavras actual = l->prox;
  while(actual != NULL && strcmp(actual->palavra, p) < 0){
    ant = actual;
    actual = actual->prox;
  }
  if(actual != NULL && strcmp(actual->palavra, p) == 0){
    actual->ocorr++;
    free(new);
    return l;
  }
  new->prox = actual;
  ant->prox = new;
  return l;
}


Palavras maisFreq (Palavras l){
  if(l == NULL) return NULL;
  Palavras king = l;
  Palavras actual = l->prox;
  while(actual != NULL){
    if(actual->ocorr > king->ocorr) king = actual;
    actual = actual->prox;
  }
  return king;
}

int main () {
    Palavras dic = NULL;

    char * canto1 [44] = {"as", "armas", "e", "os", "baroes", "assinalados",
                          "que", "da", "ocidental", "praia", "lusitana", 
                          "por", "mares", "nunca", "de", "antes", "navegados",
                          "passaram", "ainda", "alem", "da", "taprobana",
                          "em", "perigos", "e", "guerras", "esforcados",
                          "mais", "do", "que", "prometia", "a", "forca", "humana",
                          "e", "entre", "gente", "remota", "edificaram", 
                          "novo", "reino", "que", "tanto", "sublimaram"};

    printf ("\n_____________ Testes _____________\n\n");

    int i; struct celula *p;
    for (i=0;i<44;i++)
        dic = acrescentaInicio (dic, canto1[i]);

    printf ("Foram inseridas %d palavras\n", quantasP (dic));
    printf ("palavras existentes:\n");
    listaPal (dic);
    printf ("última palavra inserida: %s\n", ultima (dic));

    libertaLista (dic);

    dic = NULL;

    srand(42);
    
    for (i=0; i<1000; i++)
        dic = acrescenta (dic, canto1 [rand() % 44]);
    
    printf ("Foram inseridas %d palavras\n", quantasP (dic));
    printf ("palavras existentes:\n");
    listaPal (dic);
    printf ("última palavra inserida: %s\n", ultima (dic));
    
    p = maisFreq (dic);
    //printf ("Palavra mais frequente: %s (%d)\n", p->palavra, p->ocorr);
    
    printf ("\n_________ Fim dos testes _________\n\n");

    return 0;
}

```

