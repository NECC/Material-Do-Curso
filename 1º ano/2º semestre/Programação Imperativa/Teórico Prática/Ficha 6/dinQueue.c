#include <stdio.h>
#include <stdlib.h>
#include "Queue.h"

struct dinQueue {
	int size;
	int front;
	int length;
	int *values;
};
typedef struct dinQueue *DQueue;

int dupQueue (DQueue q) {
    int r = 0, i, p;
    int *t = malloc(sizeof(int) * 2 * q->size);
    
    if (t == NULL) r = 1;
    else {
        for (i = 0, p = q->front; i < q->length; i++) {
            t[i] = q->values[p];
            p = (p+1) % q->size;
        }
        free (q->values);
        q->values = t;
        q->front = 0;
        q->size *= 2;
    }
	return r;
}

void DinitQueue (DQueue q) {
    q->size = 5;
    q->front = 0;
    q->length = 0;
    q->values = malloc(sizeof(int) * q->size);
}

int  DisEmptyQ (DQueue q) {
	return q->length == 0;
}

int  Denqueue (DQueue q, int x){
	int r = 0;
	
	if (q->length == q->size) dupQueue(q);
	q->values[(q->front + (q->length)++) % q->size] = x;
	
	return r;
}

int  Ddequeue (DQueue q, int *x){
    int r = 0;
    
    if (q->length == 0) r = 1;
    else {
        *x = q->values[(q->front)++];
        (q->length)--;
    }
    
	return r;
}

int  Dfront (DQueue q, int *x){
    int r = 0;
    
    if (q->length == 0) r = 1;
    else {
        *x = q->values[q->front];
    }
    
	return r;
}
