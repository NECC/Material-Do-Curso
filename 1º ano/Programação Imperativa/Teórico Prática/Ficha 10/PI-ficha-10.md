``` c title:"Árvore binária de inteiros"
typedef struct nodo{
  int valor;
  struct nodo *esq, * dir;
} * ABin;
```
1. Uma forma de remover um elemento de uma árvore binária de procura sem aumentar a altura da árvore consiste em substituir o nodo onde esse elemento se encontra pelo menor elemento que se encontra do seu lado direito.
Apresente definições das seguintes funções sobre árvores binárias de procura.
(a) `ABin removeMenor (ABin *a)`que remove o nodo mais à esquerda de uma árvore (retornando esse nodo).
(b) `void removeRaiz (ABin *a)` que remove a raiz de uma árvore não vazia (libertando o correspondente espaço).
(c) `int removeElem (ABin *a, int x)` que remove um elemento de uma árvore binária, libertando o espaço correspondente. A função deverá retornar 0 se o elemento existia na árvore.

2. Considere as seguintes definições que rodam uma árvore. Note que ambas as operações preservam a ordem dos elementos (i.e., se forem efectuadas sobre uma árvore de procura, o resultado continua a ser uma árvore de procura).

```c title:"Roda esquerda/direita"
void rodaEsquerda(ABin *a){
  ABin b = (*b)->dir;
  (*a)->dir = b->esq;
  b->esq = (*a);
  *a = b;
}

void rodaDireita(ABin *a){
  ABin b = (*a)->esq;
  (*a)->esq = b->dir;
  b->dir = *a;
  *a = b;
}
```


Note ainda que ao efectuar uma destas rotações, o elemento que está na raiz passa para o nivel 1 enquanto que um dos elementos que está no nível 1 passa para o nnível 0. Neste caso dizemos que este último elemento foi promovido.

Usando estas funções defina as seguintes operações sobre árvores binárias de procura.
(d) `void promoveMenor (ABin *a)` que promove o menor elemento de uma árvore para o nível 0. A árvore resultante não deve aumentar a altura da árvore em mais do que uma unidade.
(e) `void promoveMaior (ABin *a)` que promove o maior elemento de uma árvore para o nível 0. A árvore resultante não deve aumentar a altura da árvore em mais do que uma unidade.
(f) Apresente uma definição alternativa da função `removeMenor` descrita na questão 1.

3. Uma árvore diz-se equilibrada sse, em cada nodo, o número de nodos à esquerda e à direita não difere em mais do que uma unidade. Uma forma de equilibrar uma árvore consiste em começar por a transformar numa espinha (i.e., uma árvore em que todos os nodos tˆem a sub-árvore da esquerda vazios) e depois equilibrar essa
árvore.
Nas funções que se descrevem abaixo não deve ser feita qualquer alocação de mem´oria; deve-se reorganizar os nodos da árvore de forma a obter o resultado pretendido
(g) Defina uma função `int constroiEspinha (ABin *a)` que transforma a árvore \*a numa espinha. A função deve retornar o número de nodos da árvore. Sugestão: de forma a tornar esta função mais eficiente, comece por definir uma função `int constroiEspinhaAux (ABin *a, ABin *ult)` que também coloca e \*ult o endereço
do nodo mais à direita da árvore produzida.
(h) Defina uma função `ABin equilibraEspinha (ABin *a, int n)` que recebe uma espinha \*a e um número n e produz uma árvore equilibrada com esses nodos. Em \*a fica a árvore construnída e é retornado o endereço dos elementos da espinha que não foram utilizados.
(i) Usando as funções anteriores, defina uma função `void equilibra (ABin *a)` que equilibra uma árvore.

```c title:Solução

#include "abin.h"

ABin newABin(int r, ABin e, ABin d) {
  ABin a = malloc(sizeof(struct nodo));
  if (a != NULL) {
    a->valor = r;
    a->esq = e;
    a->dir = d;
  }
  return a;
}

ABin RandArvFromArray(int v[], int N) {
  ABin a = NULL;
  int m;
  if (N > 0) {
    m = rand() % N;
    a = newABin(v[m], RandArvFromArray(v, m),
                RandArvFromArray(v + m + 1, N - m - 1));
  }
  return a;
}

// Questão 1
ABin removeMenor(ABin *a) {
  ABin ant = NULL, atual = *a;
  while (atual->esq != NULL) {
    ant = atual;
    atual = atual->esq;
  }
  if (ant == NULL)
    (*a) = atual->dir;
  else
    ant->esq = atual->dir;
  atual->dir = NULL;
  return atual;
}

void removeRaiz(ABin *a) {
  ABin atual = (*a), sub = NULL;
  if (atual->dir == NULL) {
    (*a) = atual->esq;
    free(atual);
  } else {
    sub = removeMenor(&(atual->dir));
    sub->esq = (*a)->esq;
    sub->dir = ((*a)->dir);
    (*a) = sub;
    free(atual);
  }
}

int removeElem(ABin *a, int x) {
  ABin atual = *a, ant = NULL;
  while (atual != NULL && atual->valor != x) {
    ant = atual;
    if (x < atual->valor) {
      atual = atual->esq;
    } else {
      atual = atual->dir;
    }
  }
  if (atual == NULL)
    return 1;
  else if (ant == NULL) {
    removeRaiz(a);
    return 0;
  } else {
    ((ant->esq) == atual) ? (removeRaiz(&(ant->esq)))
                          : (removeRaiz(&(ant->dir)));
    return 0;
  }
}

// Questão 2
void rodaEsquerda(ABin *a) {
  ABin b = (*a)->dir;
  (*a)->dir = b->esq;
  b->esq = (*a);
  *a = b;
}
void rodaDireita(ABin *a) {
  ABin b = (*a)->esq;
  (*a)->esq = b->dir;
  b->dir = *a;
  *a = b;
}

void promoveMenor(ABin *a) {
  ABin atual = *a;
  if (atual != NULL && atual->esq != NULL) {
    promoveMenor(&(atual->esq));
    rodaDireita(a);
  }
}

void promoveMaior(ABin *a) {
  ABin atual = *a;
  if (atual != NULL && atual->dir != NULL) {
    promoveMaior(&(atual->dir));
    rodaEsquerda(a);
  }
}

ABin removeMenorAlt(ABin *a) {
  if (*a == NULL)
    return NULL;
  promoveMenor(a);
  ABin menor = *a;
  *a = (*a)->dir;
  menor->dir = NULL;
  return menor;
}

// Questão 3
int constroiEspinhaAux(ABin *a, ABin *ult) {
  if (*a == NULL) {
    *ult = NULL;
    return 0;
  }
  ABin raizOriginal = *a, ultEsq = NULL, ultDir = NULL;
  int nEsq = constroiEspinhaAux(&(raizOriginal->esq), &ultEsq);
  if (nEsq > 0) {
    ultEsq->dir = raizOriginal;
    *a = raizOriginal->esq;
  }
  int nDir = constroiEspinhaAux(&(raizOriginal->dir), &ultDir);
  if (nDir > 0) {
    *ult = ultDir;
  } else {
    *ult = raizOriginal;
  }
  return nEsq + 1 + nDir;
}

int constroiEspinha(ABin *a) {
  ABin ult;
  return (constroiEspinhaAux(a, &ult));
}

ABin equilibraEspinha(ABin *a, int n) {
  if (n == 0) {
    ABin sobra = *a;
    *a = NULL;
    return sobra;
  }
  int nEsq = n / 2;
  ABin resto = equilibraEspinha(a, nEsq);
  ABin raiz = resto;
  ABin direita = raiz->dir;
  int nDir = n - nEsq - 1;
  ABin restoFinal = equilibraEspinha(&direita, nDir);
  raiz->esq = *a;
  raiz->dir = direita;
  *a = raiz;
  return restoFinal;
}

void equilibra(ABin *a) {
  int n = constroiEspinha(a);
  equilibraEspinha(a, n);
}
```

```c title:Main

#include "abin.h"
#include <time.h>

int main() {
  int v1[15] = {1, 3, 5, 7, 9, 11, 13, 15, 17, 19, 21, 23, 25, 27, 29}, N = 15,
      i;
  ABin a1, r;

  srand(time(NULL));

  printf("_______________ Testes _______________\n\n");
  // N = rand() % 16;
  a1 = RandArvFromArray(v1, N);
  printf("________________________________________\n");
  printf("Primeira árvore de teste (%d elementos)\n", N);
  // dumpABin(a1, N);

  /*
  printf ("Espinha\n");
  constroiEspinha_sol (&a1);

  // dumpABin (a1, N);

  printf ("Equilibrar espinha\n");
  equilibraEspinha_sol (&a1,N);
  // dumpABin (a1, N);
  */

  i = rand() % N;
  printf("Remoção do elemento %d\n", v1[i]);
  removeElem(&a1, v1[i]);
  // dumpABin(a1, --N);

  r = removeMenor(&a1);
  printf("Remoção do menor %d\n", r->valor);
  // dumpABin(a1, --N);

  printf("Remoção da raiz %d\n", a1->valor);
  removeRaiz(&a1);
  // dumpABin(a1, --N);

  // freeABin(a1);

  a1 = newABin(v1[7], RandArvFromArray(v1, 7), RandArvFromArray(v1 + 8, 7));
  N = 15;
  printf("_______________________________________\n");
  printf("Segunda árvore de teste (%d elementos)\n", N);
  // dumpABin(a1, N);

  printf("Rotação à direita\n");
  rodaDireita(&a1);
  // dumpABin(a1, N);

  printf("Rotação à esquerda\n");
  rodaEsquerda(&a1);
  // dumpABin(a1, N);

  printf("Promoção do maior\n");
  promoveMaior(&a1);
  // dumpABin(a1, N);

  printf("Promoção do menor\n");
  promoveMenor(&a1);
  // dumpABin(a1, N);

  printf("\n\n___________ Fim dos testes ___________\n\n");
  return 0;
}
```
