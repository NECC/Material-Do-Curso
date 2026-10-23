```c title:"Structs"
typedef struct slist {
  int valor;
  struct slist * prox;
} * LInt;

LInt newLInt (int x, LInt xs) {
  LInt r = malloc (sizeof(struct slist));
  if (r!=NULL) {
    r->valor = x; r->prox = xs;
  }
  return r;
}

typedef LInt Stack;

typedef struct{
  LInt inicio, fim;
} Queue;
```

1. Apresente definições das funções habituais sobre Stacks:
•`void initStack (Stack *s)`
•`int SisEmpty (Stack s)`
•`int push (Stack *s, int x) 1`
•`int pop (Stack *s, int *x)`
•`int top (Stack s, int *x)`

```c title:"Stacks"
#include <stdio.h>
#include <stdlib.h>
#include "Stack.h"

void initStack (Stack *s){
  *s = NULL;
}

int SisEmpty (Stack s){
    return (s == NULL);
}

int push (Stack *s, int x){
  Stack r = malloc(sizeof(struct slist));
  if( r == NULL) return 1;
  r->valor = x;
  r->prox = *s;
  *s = r;
  return 0;
}

int pop (Stack *s, int *x){
  LInt t;
  if(*s == NULL) return 1;
  t = *s;
  *s = (*s)->prox;
  *x = t->valor;
  free(t);
  return 0;
}

int top (Stack s, int *x){
  if(s == NULL) return 1;
  *x = s->valor;
  return 0;
}
```

2. Apresente definições das funções habituais sobre Queues:
•`void initQueue (Queue *q)`
•`int QisEmpty (Queue q)`
•`int enqueue (Queue *q, int x)`
•`int dequeue (Queue *q, int *x)`
•`int front (Queue q, int *x)`

```c title:"Queues"
#include "Queue.h"
#include <stdio.h>
#include <stdlib.h>

void initQueue(Queue *q) {
  q->inicio = NULL;
  q->fim = NULL;
}

int QisEmpty(Queue q) { return (q.inicio == NULL); }

int enqueue(Queue *q, int x) {
  LInt n;
  n = newLInt(x, NULL);
  if (n == NULL)
    return 1;
  if ((*q).fim != NULL) {
    (*q).fim->prox = n;
    (*q).fim = n;
  } else
    (*q).fim = (*q).inicio = n;
  return 0;
}

int dequeue(Queue *q, int *x) {
  LInt t;
  if ((*q).inicio == NULL)
    return 1;
  t = (*q).inicio;
  (*q).inicio = (*q).inicio->prox;
  if ((*q).inicio == NULL)
    (*q).fim = NULL;
  *x = t->valor;
  free(t);
  return 0;
}

int frontQ(Queue q, int *x) {
  if (q.inicio == NULL) return 1;
  *x = q.inicio->valor;
  return 0;
}
```

3. Apresente definições alternativas destas funções usando uma lista circular tal como referido acima.
```c title:"Queue circular"
typedef LInt QueueC;

void initQueueC(QueueC *q){
  *q = NULL;
}

int QisEmptyC(QueueC q){
  return(q == NULL);
}

int enqueueC(QueueC *q, int x) { 
  LInt n = malloc(sizeof(struct slist));
  if(n == NULL) return 1;
  n->valor = x;
  if(*q == NULL){
    n->prox = n;
    *q = n;
  } else {
    n->prox = (*q)->prox;
    (*q)->prox = n;
    *q = n;
  }
  return 0; 
}

int dequeueC(QueueC *q, int *x) {
  if(QisEmptyC(*q)) return 1;
  LInt t = (*q)->prox;
  *x = t->valor;
  if(*q == t) *q = NULL;
  else (*q)->prox = t->prox;
  free(t);
  return 0;
}

int frontC(QueueC q, int *x) {
  if(QisEmptyC(q)) return 1;
  *x = q->prox->valor;
  return 0;
}
```

4. Apresente definições das funções habituais sobre Deques. Implemente ainda uma função não standard deste tipo de dados que corresponde a remover o maior dos elementos armazenados
(popMax),
• `void initDeque (Deque *q)`
• `int DisEmpty (Deque q)`
• `int pushBack (Deque *q, int x)`
• `int pushFront (Deque *q, int x)`
• `int popBack (Deque *q, int *x)`
• `int popFront (Deque *q, int *x)`
• `int popMax (Deque *q, int *x)`
• `int back (Deque q, int *x)`
• `int front (Deque q, int *x)`

```c
typedef struct dlist {
  int valor;
  struct dlist *ant, *prox;
} *DList;

typedef struct {
  DList back, front;
} Deque;

#include <stdio.h>
#include <stdlib.h>
#include "Deque.h"


void initDeque (Deque *q){
  q->back = NULL;
  q->front = NULL;
}

int DisEmpty (Deque q){
    return (q.front == NULL);
}

int pushBack (Deque *q, int x){
  DList n = malloc(sizeof(struct dlist));
  if(n == NULL) return 1;
  n->valor = x;
  n->prox = NULL;
  n->ant = q->back;

  if(q->back != NULL) q->back->prox = n;
  else q->front = n;
  q->back = n;
  return 0;
}

int pushFront (Deque *q, int x){
  DList n = malloc(sizeof(struct dlist));
  if(n == NULL) return 1;
  n->valor = x;
  n->ant = NULL;
  n->prox = q->front;
  if(q->front != NULL){
    q->front->ant = n;
  }
  else{
    q->back = n;
  }
  q->front = n;

  return 0;
}

int popBack (Deque *q, int *x){
  if(DisEmpty(*q)) return 1;
  DList t = q->back;
  *x = t->valor;
  q->back = t->ant;
  if(q->back != NULL){
    q->back->prox = NULL;
  } else{
    q->front = NULL;
  }
  free(t);
  return 0;
}

int popFront (Deque *q, int *x){
  if(DisEmpty(*q)) return 1;
  DList t = q->front;
  *x = t->valor;
  q->front = t->prox;
  if(q->front != NULL){
    q->front->ant = NULL;
  } else {
    q->back = NULL;
  }
  free(t);
  return 0;
}

int popMax (Deque *q, int *x){
  if(DisEmpty(*q)) return 1;
  DList curr = q->front;
  DList maxNode = curr;
  int maxVal = curr->valor;
  while(curr != NULL){
    if(curr->valor > maxVal){
      maxVal = curr->valor;
      maxNode = curr;
    }
    curr = curr->prox;
  }
  *x = maxVal;
  if(maxNode->ant != NULL){
    maxNode->ant->prox = maxNode->prox;
  } else{
    q->front = maxNode->prox;
  }
  if(maxNode->prox != NULL){
    maxNode->prox->ant = maxNode->ant;
  } else {
    q->back = maxNode->ant;
  }
  free(maxNode);
  return 0;
}

int back (Deque q, int *x){
  if(DisEmpty(q)) return 1;
  *x = q.front->valor;
  return 0;  
}

int front (Deque q, int *x){
  if(DisEmpty(q)) return 1;
  *x = q.front->valor;
  return 0;
}
```
5. Tal como acima, em vez de se usarem dois endereços de uma lista, pode-se usar uma lista (duplamente ligada) circular e então, basta usar o endereço da última célula (que por sua vez, por se tratar de uma lista circular, contem o endereço da primeira).
Apresente definições alternativas destas funções usando esta solução.

```c title:Main
#include <stdio.h>
#include "Stack.h"
#include "Queue.h"
#include "Deque.h"

int main (){
  int i, a, b;
  Stack s; Queue q; Deque d;
  printf ("_______________ Testes _______________\n\n");
  printf ("Stack:\n");
  initStack (&s);
  push (&s,1);
  push (&s,1);
  // altere este código de forma a que a stack tenha no final
  // do ciclo a sqwuencia com os numeros de fibonacci
  for (i=0; i<10; i++){
    pop (&s,&a); top (s,&b); push (&s,b); push (&s,a+b);
  }
  while (! SisEmpty (s)) {
    pop (&s,&a);
    printf ("%d ", a);
  }

  printf ("\nQueue:\n");
  initQueue (&q);
  enqueue (&q,1);
  enqueue (&q,1);
  for (i=0; i<10; i++){
    dequeue (&q,&a); frontQ (q,&b); enqueue (&q, a); enqueue (&q,a+b);
  }
  while (! QisEmpty (q)) {
    dequeue (&q,&a);
    printf ("%d ", a);
  }

  printf ("\nDeque:\n");
  initDeque (&d);
  pushFront (&d,1);
  pushBack (&d,1);
  for (i=0; i<10; i++){
    popBack (&d,&a); back (d,&b); pushBack (&d, a); pushFront (&d,a+b);
  }

  popMax (&d,&a);
  printf ("Max: %d \n", a);

  while (! DisEmpty (d)) {
    popBack (&d,&a);
    printf ("%d ", a);
  }

  printf ("\n\n___________ Fim dos Testes ___________\n\n");
  return 0;
}
```

