#include <stdio.h>
#include <stdlib.h>

#define Max 10

struct staticQueue {
	int front;
	int length;
	int values [Max];
};
typedef struct staticQueue *SQueue;

void SinitQueue (SQueue q){
	q->front = 0;
	q->length = 0;
}

int  SisEmptyQ (SQueue q){
	return q->length == 0;
}

int  Senqueue (SQueue q, int x){
    int r = 0;
    
    if (q->length == Max) r = 1;
	else {
	    q->values[(q->front + (q->length)++) % Max] = x;
	}
	
	return r;
}

int  Sdequeue (SQueue q, int *x) {
    int r = 0;
    
    if (q->length == 0) r = 1;
	else {
	    *x = q->values[(q->front)++];
	    (q->length)--;
	}
	
	return r;
}

int  Sfront (SQueue q, int *x) {
    int r = 0;
    
    if (q->length == 0) return 1;
    else {
        *x = q->values[(q->front)];
    }
    
    return r;
}

void ShowSQueue (SQueue q){
    int i, p;
    printf ("%d Items: ", q->length);
    for (i=0, p=q->front; i<q->length; i++) {
        printf ("%d ", q->values[p]);
        p = (p+1)%Max;
    }
    putchar ('\n');
}
