---
topic: C
date: 2026-04-28
course: Programação Imperativa
tags:
  - universidade
  - computer-science/programming/C
  - computer-science
  - computer-science/programming
---
# pi tp 11

**Tópicos:** Árvores Binárias (ABin) e Árvores Binárias de Procura (BST/ABB).

## Estruturas Base (Para Contexto)

```c
typedef struct lligada {
    int valor;
    struct lligada *prox;
} *LInt;

typedef struct nodo {
    int valor;
    struct nodo *esq, *dir;
} *ABin;
```


## 1. Operações Básicas em Árvores Binárias

### Contar Folhas (**`nFolhas`**)
Uma folha é um nó que não tem filhos (nem esquerda, nem direita).
```c
int nFolhas(ABin a) {
    if (a == NULL) return 0;
    
    // Se não tem filhos, é uma folha
    if (a->esq == NULL && a->dir == NULL) return 1;
    
    // Senão, soma as folhas da esquerda com as da direita
    return nFolhas(a->esq) + nFolhas(a->dir);
}
```

### Imprimir Travessia Inorder (**`inorder`**)
Visita a árvore na ordem: Esquerda -> Raiz -> Direita. (Numa árvore de procura, isto imprime os valores por ordem crescente).

```c
void inorder(ABin a){
	if(a != NULL){
		inorder(a->esq);
		printf("%d", a->valor);
		inorder(a->dir);
	}
}
```

```c
void imprimeNivel(ABin a, int n){
	if (a != NULL){
		if(n == 0) printf("%d", a->valor);
		else{
			imrprimeNivel(a->esq, n-1);
			imprimeNivel(a->dir, n-1);
		}
	}
}
```

## 2. Operações por Nível (Profundidade)
### Imprimir os Valores de um Nível Específico (**`imprimeNivel`**)
```c
void imprimeNivel(ABin a, int n){
	if (a != NULL){
		if(n == 0) printf("%d", a->valor);
		else {
			// desce na árvore e diminui a distância (n) para o alvo
			imrprimeNivel(a->esq, n-1);
			imprimeNivel(a->dir, n-1);
		}
	}
}
```

### Criar Lista Ligada com Valores de um Nível (**`nivelL`**)
Requer uma função auxiliar `append` para juntar as listas geradas pela subárvore esquerda e direita.

```c
// Função aux: junta a lista 'b' ao final da lista 'a'
LInt append( LInt a, LInt b){
	LInt r = a;
	if(a == NULL) r = b;
	while(a->prox != NULL) a = a->prox;
	a->prox = b;
	return r	
}

// função principal
LInt nivelL(ABin a, int n){
	LInt r = NULL, e, d;
	if(a != NULL){
		if(n == 0){
			r = malloc(sizeof(struct lligada));
			r->valor = a->valor;
			r->prox = NULL;
		}
	} else {
	e = nivelL(a->esq, n-1);
	d = nivelL(a->dir, n-1);
	r = append(e, d)
	}
	return r;
}
```

## 3. Árvores Binárias de Procura (BST)  
Numa Ár-do à esquerda é menor, e tudo à direita é maior.  

### Procurar um Elemento (**`procura` e `procura2`**)
```c
// versão recursiva
ABin procura( LInt a, int x){
	ABin r = NULL;
	if(a != NULL){
		if(x == a->valor) r = a;
		else if(x < a->valor) r = procura(a->esq, x);
		else r = procura(a->dir, x);
	}
	return r;
}
```

```c
// versão iterativa
ABin procura2(ABin a, int x){
	while(a != NULL && a->valor != x){
		if(x < a->valor) a = a->esq;
		else a = a->dir;
	}
	return a;
}
```

### Encontrar o Nível de um Elemento (**`nivel`**)
Retorna `-1` se o elemento não existir. A raiz está no nível 0.

```c
int nivel(ABin a, int x){
	// -1 se x não existir
	int nivel = 0;
	while(a != NULL && a->valor != x){
		if(x < a->valor) a = a->esq;
		else a = a->dir;
		nivel++
	}
	return (a == NULL)? -1 : nivel;
}
```

### Imprimir Elementos Menores ou Iguais a X (**`imprimeAte`**)  
Usa a propriedade da árvore de procura para não visitar ramos desnecessários.
```c
void imprimeAte(Abin a, int x){
	if(a != NULL){
		if(x > a->valor){
			// tudo à esquerda é garantidamente menor, imprimimos logo
			inorder(a->esq);
			printf("%d", a->valor); // imprimimos o valor atual
			imprimeAte(a->dir, x); // procuramos à direita por mais valores que ainda sejam <= x
		}
		else imprimeAte(a->esq, x) // se o valor é maior que x, ignoramos a direita e vamos só pela esquerda
	}
}
```

## Main

```txt
arvore:

        10
       /  \
      5    15
     / \     \
    2   7    20
```

```c
#include <stdio.h>
#include <stdlib.h>

// ==========================================
// 1. ESTRUTURAS
// ==========================================
typedef struct lligada {
    int valor;
    struct lligada *prox;
} *LInt;

typedef struct nodo {
    int valor;
    struct nodo *esq, *dir;
} *ABin;

// ==========================================
// 2. FUNÇÃO EXTRA PARA AJUDAR NO MAIN
// ==========================================
ABin novoNodo(int x, ABin e, ABin d) {
    ABin n = malloc(sizeof(struct nodo));
    n->valor = x;
    n->esq = e;
    n->dir = d;
    return n;
}

// ==========================================
// 3. AS TUAS FUNÇÕES DO TP 11
// ==========================================
int nFolhas(ABin a) {
    if (a == NULL) return 0;
    if (a->esq == NULL && a->dir == NULL) return 1;
    return nFolhas(a->esq) + nFolhas(a->dir);
}

void imprimeNivel(ABin a, int n) {
    if (a != NULL) {
        if (n == 0) printf("%d ", a->valor);
        else {
            imprimeNivel(a->esq, n - 1);
            imprimeNivel(a->dir, n - 1);
        }
    }
}

LInt append(LInt a, LInt b) {
    if (a == NULL) return b;
    LInt r = a;
    while (a->prox != NULL) a = a->prox;
    a->prox = b;
    return r;
}

LInt nivelL(ABin a, int n) {
    LInt r = NULL, e, d;
    if (a != NULL) {
        if (n == 0) {
            r = malloc(sizeof(struct lligada));
            r->valor = a->valor;
            r->prox = NULL;
        } else {
            e = nivelL(a->esq, n - 1);
            d = nivelL(a->dir, n - 1);
            r = append(e, d);
        }
    }
    return r;
}

int nivel(ABin a, int x) {
    int nivel = 0;
    while (a != NULL && a->valor != x) {
        if (x < a->valor) a = a->esq;
        else a = a->dir;
        nivel++;
    }
    return (a == NULL) ? -1 : nivel;
}

void inorder(ABin a) {
    if (a != NULL) {
        inorder(a->esq);
        printf("%d ", a->valor);
        inorder(a->dir);
    }
}

void imprimeAte(ABin a, int x) {
    if (a != NULL) {
        if (a->valor <= x) {
            inorder(a->esq);
            printf("%d ", a->valor);
            imprimeAte(a->dir, x);
        } else {
            imprimeAte(a->esq, x);
        }
    }
}

// ==========================================
// 4. MAIN PARA O PYTHON TUTOR
// ==========================================
int main() {
    printf("=== CONSTRUINDO A ARVORE ===\n");
    // Montamos a árvore de baixo para cima usando a função auxiliar
    // Árvore: Raiz 10, Esquerda 5 (com filhos 2 e 7), Direita 15 (com filho 20)
    ABin raiz = novoNodo(10, 
                    novoNodo(5, 
                        novoNodo(2, NULL, NULL), 
                        novoNodo(7, NULL, NULL)),
                    novoNodo(15, 
                        NULL, 
                        novoNodo(20, NULL, NULL)));

    printf("\n=== TESTANDO FUNCOES ===\n");
    
    // Teste 1: Contar folhas (Devem ser o 2, 7 e 20 -> Total 3)
    int folhas = nFolhas(raiz);
    printf("Numero de folhas: %d\n", folhas);
    
    // Teste 2: Procurar o nivel do numero 7 (A raiz 10 e nivel 0, o 5 e nivel 1, o 7 e nivel 2)
    int n = nivel(raiz, 7);
    printf("O numero 7 esta no nivel: %d\n", n);
    
    // Teste 3: Imprimir todos os elementos da arvore em ordem crescente
    printf("Inorder (crescente): ");
    inorder(raiz);
    printf("\n");
    
    // Teste 4: Imprimir valores ate um limite (Ex: todos os <= 8)
    printf("Imprime ate o 8: ");
    imprimeAte(raiz, 8); // Deve imprimir 2, 5 e 7
    printf("\n");
    
    // Teste 5: Criar uma lista ligada com os elementos do nivel 2 (o 2, o 7 e o 20)
    LInt listaNivel2 = nivelL(raiz, 2);
    
    // FIM! Acompanha os ponteiros da lista no Python Tutor
    return 0;
}
```


## Links
- [[1ano/2semestre/PI/fichas/Ficha3.pdf|Ficha3]]
- [[1ano/2semestre/PI/fichas/Ficha3.pdf|Ficha4]]
- [[pi tp 1]]
- [[pi tp 2]]
- [[pi tp 3]]
- [[pi tp 4]]
- [[pi tp 5]]
- [[pi tp 6]]
- [[pi tp 7]]
- [[pi tp 8]]
- [[pi tp 9]]
- [[pi tp 10]]