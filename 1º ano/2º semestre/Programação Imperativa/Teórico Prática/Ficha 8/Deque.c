#include <stdio.h>
#include <stdlib.h>

// Assumi que front é o início porque não diz qual é no enunciado
void initDeque (Deque *q){
    q->back = NULL;
    q->front = NULL;
}

int DisEmpty (Deque q){
    return q.front == NULL;
}

int pushBack (Deque *q, int x){
    DList temp = newDList(x, NULL);
    temp->ant = q->back;
    if (q->back == NULL) q->front = temp;
    else q->back->prox = temp;
    q->back = temp;
    
    return 0;
}

int pushFront (Deque *q, int x){
    DList temp = newDList(x, q->front);
    if (q->front == NULL) q->back = temp;
    else q->front->ant = temp;
    q->front = temp;
    
    return 0;
}

int popBack (Deque *q, int *x){
    if (q->back == NULL) return -1;
    
    DList temp = q->back;
    *x = temp->valor;
    q->back = temp->ant;
    free(temp);
    
    if (q->back != NULL) q->back->prox = NULL;
    else q->front = NULL;
    
    return 0;
}

int popFront (Deque *q, int *x){
    if (q->front == NULL) return -1;
    
    DList temp = q->front;
    *x = temp->valor;
    q->front = temp->prox;
    free(temp);
    
    if (q->front != NULL) q->front->ant = NULL;
    else q->back = NULL;
    
    return 0;
}

int popMax (Deque *q, int *x){
    DList max = q->front;
    if (max == NULL) return -1;
    DList temp = max;
    
    while (temp->prox != NULL) {
        if (temp->valor > max->valor) max = temp;
        temp = temp->prox;
    }
    
    *x = max->valor;
    DList anterior = max->ant;
    DList seguinte = max->prox;
    
    if (anterior == NULL) { // É primeiro elemento
        if (seguinte != NULL) { // É primeiro e último
            q->back = NULL;
            q->front = NULL;
        }
        q->front = seguinte;
        seguinte->ant = NULL;
    } else if (seguinte != NULL) { // É último elemento
        q->back = anterior;
        anterior->prox = NULL;
    }
    
    free(max);
    return 0;
}

int back (Deque q, int *x){
    if (q.back == NULL) return -1;
    *x = q.back->valor;
    return 0;
}

int front (Deque q, int *x){
    if (q.front == NULL) return -1;
    *x = q.front->valor;
    return 0;
}
