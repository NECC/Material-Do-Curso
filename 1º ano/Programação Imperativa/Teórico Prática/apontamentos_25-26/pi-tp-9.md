---
topic: C
date: 2026-04-14
course: Programação Imperativa
tags:
  - universidade
  - computer-science/pi
  - computer-science/programming/C
  - computer-science
  - computer-science/programming
---
# pi tp 9

## 1. Listas Inteiras (LInt)

A base para construir estruturas dinâmicas mais complexas é a definição de um nó de lista simples.

```c
typedef struct lista{
 int valor;
 struct lista *prox;
} *LInt;
```

```c
// Função auxiliar para criar um novo nó
LInt newLInt(int x, LInt xs){
 LInt r = malloc(sizeof(struct lista));
 if(r != NULL){
  r->valor = x;
  r->prox = xs;
 }
 return r;
}
```

---

## 2. Pilhas (Stacks) com Listas Ligadas

Uma Pilha segue o princípio **LIFO** (Last-In, First-Out). Ao usar listas ligadas, o "topo" da pilha é sempre o primeiro elemento da lista. Isso permite que as operações de inserção e remoção sejam de tempo constante O(1).

```c
typedef LInt Stack;
```

---

### Definição e Inicialização

```c
// Inicializa a pilha como NULL (vazia)
void initStack(Stack *s){
 *s = NULL;
}
```

```c
// Verifica se a pilha está vazia
int isEmptyStack(Stack *s, int x){
 return (s == NULL);
}
```

---

### Push (Empilhar)

Inserir um elemento no topo. O novo nó aponta para o antigo topo, e o ponteiro da pilha passa a apontar para o novo nó.

```c
int push(Stack *s, int x){
 Stack r;
 r = malloc(sizeof(struct lista));
 if(r == NULL) return 1; // Falha na alocação
 r->valor = x; 
 r->prox = *s; // O novo nó aponta para o resto da pilha
 *s = r; // O topo da pilha agora é o novo nó
 return 0;
}
```

---

### Pop (Desempilhar)

Remover o elemento do topo. Guardamos o valor, avançamos o ponteiro da pilha para el siguiente nodo y liberamos la memoria del nodo removido.

```c
int pop(Stack *s, int *x){
 LInt t;
 if(*s == NULL) return 1; // Erro: Pilha vazia
 t = *s; // Guardamos o nó do topo
 *s = (*s)->prox; // O topo passa a ser o próximo elemento
 *x = t -> valor; // Devolvemos o valor por referência
 free(t); // Libertamos a memória do nó removido
 return 0;
}
```

---

```c
int top(Stack s, int *x){
 if(s == NULL) return 1;
 *x = s->valor;
 return 0;
}
```

---

## 3. Filas (Queues) com Listas Ligadas

### Definição e Inicialização

```c
typedef Struct{
 LInt inicio, fim;
} Queue;
```

```c
int initQueue(Queue *q){
 q->inicio = NULL;
 q->fim = NULL;
}
```

```C
int isEmptyQueue(Queue q){
 return(q.inicio == NULL);
}
```

### Operações Principais (Enqueue, Dequeue)

```c
int enqueue(Queue *q, int x){
 LInt n;
 n = newLInt(x, NULL);
 if(n == NULL) return 1;
 
 // Se a fila não está vazia, ligamos o nó ao fim atual
 if ((*q).fim != NULL){
  (*q).fim->prox = n;
  (*q).fim = n;
  
  // Se estava vazia, o novo nó é o início e o fim
 } else (*q).fim = (*q).inicio = n;
 return 0;
}
```

```c
int dequeue(Queue *q, int *x){
 LInt t;
 if((*q).inicio == NULL) return 1; // Fila vazia
 t = (*q).inicio;
 
 (*q).inicio = (*q).inicio->prox; // Avança o início
 
 // Se a fila ficou vazia após remover, o fim também tem de ser NULL
 if((*q).inicio == NULL) (*q).fim = NULL;
 *x = t->valor;
 free(t);
 return 0;
}
```

## Diferenças Principais: Queue vs Stack

- **Queue (TP 8):** FIFO (Primeiro a entrar, primeiro a sair). Requer manipulação de `frente` e `comp` ou ponteiros para o início e fim.

- **Stack (TP 9):** LIFO (Último a entrar, primeiro a sair). Apenas precisamos de controlar o ponteiro para o topo (início da lista).

---

### Notas técnicas

1. **Módulo vs Punteros:** A diferencia de la Queue circular de la clase anterior, aquí no necesitas el operador `%` porque la lista ligada crece dinámicamente nodo a nodo; no hay un array fijo que "dé la vuelta".
2. **Indirección:** En `initStack`, `push` y `pop` pasamos `Stack *s` (un puntero a la lista). Esto es necesario porque queremos modificar el puntero original de la pila que está en el `main`. Por eso usamos `*s` dentro de las funciones.

---

## Main

Main generado por gemini para probar las funciones e tambien poder visualizarlas mejor con ayuda de python tutor.

```c
#include <stdio.h>
#include <stdlib.h>

// ==========================================
// Coloca aquí todo tu código (LInt, Stack y Queue)
// ==========================================

int main() {
    int valor; // Variable auxiliar para los resultados

    // ---------------------------------------------------------
    // TEST 1: PILHA (STACK) - LIFO
    // ---------------------------------------------------------
    printf("=== TESTANDO A PILHA (STACK) ===\n");
    Stack s;
    initStack(&s);

    push(&s, 10);
    push(&s, 20);
    push(&s, 30);
    printf("Empilhados na Stack: 10, 20, 30\n");

    printf("Ordem de saída da Stack: ");
    while (!isEmptyStack(&s)) {
        pop(&s, &valor);
        printf("%d ", valor); // Debería imprimir: 30 20 10
    }
    printf("\n\n");

    // ---------------------------------------------------------
    // TEST 2: FILA (QUEUE) - FIFO
    // ---------------------------------------------------------
    printf("=== TESTANDO A FILA (QUEUE) ===\n");
    Queue q;
    initQueue(&q);

    enqueue(&q, 10);
    enqueue(&q, 20);
    enqueue(&q, 30);
    printf("Enfileirados na Queue: 10, 20, 30\n");

    

    printf("Ordem de saída da Queue: ");
    while (!isEmptyQueue(q)) {
        dequeue(&q, &valor);
        printf("%d ", valor); // Debería imprimir: 10 20 30
    }
    printf("\n\n");

    // Prueba de seguridad: Fila vacía
    printf("Tentando dequeue de uma fila vazia...\n");
    if (dequeue(&q, &valor) == 1) {
        printf("Erro capturado: Fila vazia!\n");
    }

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
