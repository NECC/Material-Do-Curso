```c title:"arvore estrutura"
typedef struct nodo{
  int valor;
  struct nodo *esq, *dir;
} * ABin;

ABin newABin (int r, ABin e, ABin d){
  ABin a = malloc(sizeof(struct nodo));
  if(a != NULL){
    a->valor = r; a->esq = e; a->dir = d;
  }
  return a;
}
```

1. Apresente definições das seguintes funções sobre árvores.
(a)`int altura (ABin a)` que calcula a altura de uma árvore.
(b)`int nFolhas (ABin a)` que calcula o n´umero de folhas (i.e., nodos cujas sub-árvores são ambas vazias).
(c)`ABin maisEsquerda (ABin a)` que calcula o nodo mais a esquerda de uma árvore.
(d)`void imprimeNivel (ABin a, int l)` que escreve no ecran os elementos da árvore que estão ao nível l (Considere que a raiz de uma árvore se encontra no nível 0).
(e)`int procuraE (ABin a, int x)` que testa se x ocorre na árvore. Não assuma qualquer propriedade sobre a árvore a.

2. Apresente definições sobre as seguintes funções sobre árvores binárias de procura.
(f)`struct nodo *procura (ABin a, int x)` que procura um elemento numa árvore. A
função deverá retornar o endereço da c´elula onde o elemento ocorre ou NULL caso o elemento não exista na árvore.
(g)`int nivel (ABin a, int x)` que calcula o nível a que o elemento ocorre na árvore (-1 caso não exista).
(h)`void imprimeAte (ABin a, int x)` que imprime no ecran, por ordem crescente, todos os elementos da árvore que são (estritamente) menores do que um dado valor.

```c title:Solução
#include "abin.h"

ABin newABin (int r, ABin e, ABin d) {
   ABin a = malloc (sizeof(struct nodo));
   if (a!=NULL) {
      a->valor = r; a->esq = e; a->dir = d;
   }
   return a;
}

ABin RandArvFromArray (int v[], int N) {
   ABin a = NULL;
    int m;
    if (N > 0){
    	m = rand() % N;
    	a = newABin (v[m], RandArvFromArray (v,m), RandArvFromArray (v+m+1,N-m-1));
    }
    return a;	
}

int altura (ABin a){
  int esq, dir;
  if(a == NULL) return 0;
  esq = altura(a->esq);
  dir = altura(a->dir);
  return 1 + ((esq > dir) ? esq : dir);
}

int nFolhas (ABin a){
  if(a == NULL) return 0;
  if(a->esq == NULL && a->dir == NULL) return 1;
  return (nFolhas(a->esq) + nFolhas(a->dir));
}

ABin maisEsquerda (ABin a){
  if(a == NULL) return NULL;
  while(a->esq != NULL){
    a = a->esq;
  }
  return a;
}

void imprimeNivel (ABin a, int l){
   if(a != NULL){
    if(l == 0) printf("%d", a->valor);
    else {
      imprimeNivel(a->esq, l-1);
      imprimeNivel(a->dir, l-1);
    }
  } 
}

int procuraE (ABin a, int x){
  if(a == NULL) return 0;
  if(a->valor == x) return 1;
  return(procura(a->esq, x) || procura(a->dir, x));
}

struct nodo *procura (ABin a, int x){
  while(a != NULL && a->valor != x){
    if(x < a->valor) a = a->esq;
    else a = a->dir;
  }
  return a;
}



int nivel (ABin a, int x){
  int nivel = 0;
  while(a != NULL && a->valor != x){
    if(x < a->valor) a = a->esq;
    else a = a->dir;
    nivel++;
  }
  return (a == NULL) ? (-1) : nivel;
}

void inorder(ABin a){
  if(a != NULL){
    inorder(a->esq);
    printf("%d", a->valor);
    inorder(a->dir);
  }
}

void imprimeAte (ABin a, int x){
  if(a != NULL){
    if(x > a->valor){
      inorder(a->esq);
      printf("%d", a->valor);
      imprimeAte(a->dir, x);
    }
    else imprimeAte(a->esq, x);
  } 
}
```

```c title:Main
#include "abin.h"
#include <stdio.h>
#include <stdlib.h>
#include <time.h>

int main() {
  int v1[15] = {1, 3, 5, 7, 9, 11, 13, 15, 17, 19, 21, 23, 25, 27, 29},
      v2[15] = {21, 3, 15, 27, 9, 11, 23, 5, 17, 29, 1, 13, 25, 7, 19}, N = 15;
  ABin a1, a2, r;

  srand(time(NULL));

  printf("_______________ Testes _______________\n\n");
  // N = rand() % 16;
  a1 = RandArvFromArray(v2, N);
  printf("Primeira árvore de teste (%d elementos)\n", N);
  // dumpABin(a1, N);

  printf("altura = %d\n", altura(a1));
  printf("numero de folhas: %d\n", nFolhas(a1));
  printf("Nodo mais à esquerda: ");
  r = maisEsquerda(a1);
  if (r == NULL)
    printf("(NULL)\n");
  else
    printf("%d\n", r->valor);
  printf("Elementos no nivel 3_______\n");
  imprimeNivel(a1, 3);
  printf("\n___________________________\n");

  printf("procura de 2: %d\n", procuraE(a1, 2));
  printf("procura de 9: %d\n", procuraE(a1, 9));

  // freeABin(a1);

  // N = rand() % 16;
  a2 = RandArvFromArray(v1, N);
  printf("\nSegunda árvore de teste (%d elementos)\n", N);
  // dumpABin(a2, N);

  printf("procura de 9: ");
  r = procura(a2, 9);
  if (r == NULL)
    printf("(NULL)\n");
  else
    printf("%d\n", r->valor);
  printf("procura de 2: ");
  r = procura(a2, 2);
  if (r == NULL)
    printf("(NULL)\n");
  else
    printf("%d\n", r->valor);
  printf("nível do elemento 2: %d\n", nivel(a2, 2));
  printf("nível do elemento 9: %d\n", nivel(a2, 9));
  imprimeAte(a2, 20);

  // freeABin(a1);

  printf("\n\n___________ Fim dos testes ___________\n\n");
  return 0;
}
```
