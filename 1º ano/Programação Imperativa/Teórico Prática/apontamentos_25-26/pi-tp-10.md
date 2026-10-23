---
topic: C
date: 2026-04-21
course: Programação Imperativa
tags:
  - universidade
  - computer-science/programming/C
  - computer-science/pi
  - computer-science/programming
---
# pi tp 10

**Tópicos:** Conversões entre Arrays e Listas Ligadas, Inversão in-place, e Inserção Ordenada.

---

## 1. Converter Lista Ligada para Array (`list2array`)
Copia os valores de uma lista ligada para um array pré-alocado, até ao limite `N` ou até a lista terminar. Retorna o número de elementos efetivamente copiados.

```c
int list2array(LInt l, int v[], int N){
	int i = 0;
	while(i < N && l != NULL){
		v[i] = l->valor;
		l = l->prox;
		i ++;
	}
	return i;
}
```

## 2. Converter Array para Lista Ligada (**`array2List`**)
Cria uma lista ligada a partir de um array. O truque aqui é percorrer o array de trás para a frente (do índice `N-1` até `0`). Como estamos sempre a inserir os nós à cabeça da lista (comportamento de stack), lê-los ao contrário garante que a lista final fica com a mesma ordem do array original.

```c
LInt array2List(int v[], int N){
	LInt a = NUll, nova;
	for(int i = N - 1; i >= 0; i --){
		nova = malloc(sizeof(struct lligada));
		nova->valor = v[i];
		nova->prox = a; // o novo nó aponta para o resto da lista construida
		a = nova; // O inicio da lista passa a ser o novo nó 
	} return a;
}
```

## 3. Inverter uma Lista Ligada (**`reverseL`**)
Inverte a ordem dos nós sem criar uma nova lista (sem usar `malloc`), apenas redirecionando os apontadores `prox`. É a abordagem mais eficiente ‭‬‭‬‭‬‭‬.

```c
LInt reverseL (LInt l){
	LInt x, r = NULL; // 'r' será a nova cabeça (e também o anterior na iteração)
	while (l != NULL){
		x = l; // guardamos o nó atual
		l = l->prox; // Avançamos na lista original 
		x->prox = r; // Damos a volta à seta do nó atual
		r = x; // O atual passa a ser o anterior para a próxima volta
	}
	return r; // Retornamos a cabeça da lista invertida 
}
```

## 4. Inserção numa Lista Ordenada (**`InsereOrd`**)  
Insere um elemento `x` na posição correta para manter a ordenação da lista, usando a abordagem clássica de dois apontadores (`ant` e `p`). Note-se o uso do duplo apontador `LInt *l` para permitir a modificação da cabeça da lista caso o novo elemento seja o menor de todos.

```c
void InsereOrd(LInt *l, int x){
	// 1. Criar um novo nó
	LInt n = malloc(sizeof(struct lligada)), p = l; 
	n->valor = x;
	
	LInt ant = NULL;
	LInt p = *l; // ponto de partida para procurar
	
	// 2. procurar o buraco correto
	while(p != NULL && p->valor < x){
		ant = p;
		p = p->prox;
	}
	
	//3. Conectar o novo nó ao que ficou à sua direita
	n->prox = p;
	
	//4. Conectar o nó à sua esquerda (ou atualizar a cabeça)
	if(ant != NULL) ant->prox = n;
	else *l = n;
}
```

## Main
```c
#include <stdio.h>
#include <stdlib.h>

// 1. A NOSSA ESTRUTURA
typedef struct lligada {
    int valor;
    struct lligada *prox;
} *LInt;

// 2. AS NOSSAS FUNÇÕES (Exatamente como nas tuas notas)
int list2array(LInt l, int v[], int N) {
    int i = 0;
    while (i < N && l != NULL) {
        v[i] = l->valor;
        l = l->prox;
        i++;
    }
    return i;
}

LInt array2List(int v[], int N) {
    LInt a = NULL, nova;
    for (int i = N - 1; i >= 0; i--) {
        nova = malloc(sizeof(struct lligada));
        nova->valor = v[i];
        nova->prox = a;
        a = nova;
    }
    return a;
}

LInt reverseL(LInt l) {
    LInt x;
    LInt r = NULL;
    while (l != NULL) {
        x = l;
        l = l->prox;
        x->prox = r;
        r = x;
    }
    return r;
}

void InsereOrd(LInt *l, int x) {
    LInt n = malloc(sizeof(struct lligada));
    n->valor = x;
    LInt ant = NULL;
    LInt p = *l;
    
    while (p != NULL && p->valor < x) {
        ant = p;
        p = p->prox;
    }
    
    n->prox = p;
    if (ant != NULL) {
        ant->prox = n;
    } else {
        *l = n;
    }
}

// 3. O MAIN PARA O PYTHON TUTOR
int main() {
    // Passo 1: Começamos com um array simples
    int arrayOrigem[3] = {10, 20, 30};
    
    // Passo 2: Transformamos o array numa Lista Ligada
    // Vais ver as 3 caixas a serem criadas no "Heap"
    LInt minhaLista = array2List(arrayOrigem, 3);
    
    // Passo 3: Inserimos elementos mantendo a ordem
    // O 25 vai entrar no meio (entre o 20 e o 30)
    InsereOrd(&minhaLista, 25);
    
    // O 5 vai entrar no início (muda o apontador principal)
    InsereOrd(&minhaLista, 5);
    
    // Passo 4: Damos a volta à lista!
    // Fica de olho nas setas (prox), vais vê-las a inverter a direção
    minhaLista = reverseL(minhaLista);
    
    // Passo 5: Guardamos a lista final num novo array vazio
    int arrayDestino[10];
    int elementosCopiados = list2array(minhaLista, arrayDestino, 10);
    
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