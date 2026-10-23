---
topic: C
date: 2026-03-07
course: Programação Imperativa
tags:
  - universidade
  - computer-science/programming/C
  - computer-science
  - computer-science/pi
  - computer-science/programming
---
# pi tp 8

## 1. Filas (Queues) Circulares Dinâmicas
Uma fila circular resolve o problema de desperdício de memória em arrays ao fazer com que o final do array se ligue novamente ao início.

### Estrutura Base
```c
typedef struct queue {
	int tam; // Tamanho total alocado no array
	int comp; // Comprimento atual (número de elementos na fila)
	int *v;
	int frente;
} Queue;
```

---

### Inicialização e Verificação
```c
// Inicializa uma fila vazia com tamanho base 4
void empty(Queue *q){
	q->tam = 4;
	q->v = malloc(4 * sizeof(int));
	q->comp = 0;
	q->frente = 0;
}
```

```c
// Verifica se a fila está vazia
int isEmpty(Queue *q){
	return (q->comp == 0);
}
```

---

### Dequeue (Remover da fila)
Para avançar a frente da fila sem sair dos limites do array, usamos o operador módulo `%`. A expressão `q->frente = (q->frente + 1) % q->tam;` substitui a necessidade de usar um `if (q->frente == tam) q->frente = 0;`.

```c
int dequeue(Queue *q, int *f) {
	if (q->comp == 0) return 1; // Erro: Fila vazia
	*f = q->v[q->frente];
	q->comp--;
	
	// Avança a frente de forma circular
	q->frente = (q->frente + 1) % q->tam; 
	
	return 0; // Sucesso
}
```

// alternativamente temos:
```c
int dequeue(Queue *q, int *f){
	if (q->comp == 0) return 1;
	*f = q->v[q->frente];
	q->comp--;
	q->frente++; (if(q->frente == tam) q->frente = 0;)
	return 0;
}
```

La expresión:
```c
if(q->frente == tam) q->frente = 0;
```

puede ser escrita de la siguiente forma
```c
q->frente = (q->frente) % q -> tam;
```

---

### Enqueue (Inserir na fila com redimensionamento)
Quando a fila enche, usamos `realloc`. Como a fila é circular, os elementos podem estar "partidos" (o fim lógico está antes do início lógico no array). Ao duplicar o tamanho, movemos a parte que deu a volta para o final do array original.

```c
void enqueue(Queue *q, int x){
	int i = 0, j = q->tam;
	
	// Se a fila estiver cheia, precisamos duplicar o tamanho
	if(q->tam == q->comp){
		q->v = realloc(q->v, 2*q->tam*sizeof(int));
		q->tam *=2; // Atualizamos o tamanho total
		
		// Movemos os elementos que "deram a volta" para a nova área alocada
		while(i < q->frente)
			q->v[j++] = q->v[i++];	 
	} 
	
	// Calculamos a posição do novo elemento de forma circular
	q->v[(q->frente + q->comp) % q->tam] = x;
	q->comp++;
}
```

---

## 2. Listas Ligadas (Ocorrência de Palavras)

### Estrutura Base
```c
typedef struct celula{
	char *palavra;
	int ocorr;
	struct celula *prox;
} *PALAVRAS
```

---

### Contar elementos da lista
Percorre a lista toda até encontrar o `NULL` no final.

```c
int quantas (PALAVRAS l){
	int conta = 0;
	while(l != NULL){
		l = l->prox;
		conta ++;
	}
	return conta;
}
```

---

### Encontrar a última palavra
Usa um ponteiro auxiliar (`ant`) que fica sempre um passo atrás para guardar o último nó válido antes de a lista se tornar `NULL`.

```c
char* ultima(PALAVRAS l){
	PALAVRAS ant;
	if (l == NULL) return NULL;
	while(l != NULL){
		ant = l;
		l = l->prox;
	}
	return (ant->palavra);
}
```

---

## Main
funcion main generada por gemini hehehe.
```c
#include <stdio.h>
#include <stdlib.h>

// ==========================================
// [...]
// ==========================================

int main() {
    // ------------------------------------------
    // TEST 1: Fila Circular Dinámica (Queue)
    // ------------------------------------------
    printf("=== TESTANDO A FILA (QUEUE) ===\n");
    Queue q;
    
    empty(&q); // Inicializamos la fila
    printf("Fila inicializada. Vazia? %s\n", isEmpty(&q) ? "Sim" : "Nao");
    
    // Vamos a forzar el realloc. El tamaño inicial es 4, meteremos 6 elementos.
    printf("\nEncolando valores: 10, 20, 30, 40, 50, 60...\n");
    enqueue(&q, 10);
    enqueue(&q, 20);
    enqueue(&q, 30);
    enqueue(&q, 40);
    enqueue(&q, 50);
    enqueue(&q, 60);
    
    printf("Tamanho atual do array alocado: %d\n", q.tam); // Debería ser 8 por el realloc
    printf("Elementos atualmente na fila: %d\n", q.comp);  // Debería ser 6
    
    int valor;
    printf("\nRetirando (dequeue) todos os valores da fila:\n");
    while (!isEmpty(&q)) {
        dequeue(&q, &valor);
        printf("%d ", valor);
    }
    printf("\n");
    
    // Liberar la memoria dinámica de la fila
    free(q.v); 
    
    
    // ------------------------------------------
    // TEST 2: Listas Ligadas (PALAVRAS)
    // ------------------------------------------
    printf("\n=== TESTANDO A LISTA LIGADA (PALAVRAS) ===\n");
    
    // Para probar, crearemos 3 "celulas" (nodos) de forma estática 
    // y los enlazaremos manualmente desde el último hasta el primero.
    struct celula nodo3 = {"C", 1, NULL};
    struct celula nodo2 = {"em", 2, &nodo3};
    struct celula nodo1 = {"Programando", 5, &nodo2};
    
    // Nuestro puntero principal apuntará al primer nodo
    PALAVRAS lista = &nodo1; 
    
    // Probamos la función 'quantas'
    int cantidad = quantas(lista);
    printf("A lista tem %d palavras.\n", cantidad);
    
    // Probamos la función 'ultima'
    char *ult = ultima(lista);
    if (ult != NULL) {
        printf("A ultima palavra da lista e: \"%s\"\n", ult);
    } else {
        printf("A lista esta vazia.\n");
    }

    return 0;
}
```

## Links
- [[1ano/2semestre/PI/fichas/Ficha3.pdf|Ficha3]]
- [[1ano/2semestre/PI/fichas/Ficha3.pdf|Ficha4]]
-  [[pi tp 1]]
- [[pi tp 2]]
- [[pi tp 3]]
- [[pi tp 4]]
- [[pi tp 5]]
- [[pi tp 6]]
- [[pi tp 7]]