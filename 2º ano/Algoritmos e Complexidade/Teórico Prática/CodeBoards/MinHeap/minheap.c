#include <stdlib.h>
#include "minheap.h"

void swap (Elem h[], int a, int b) {
    int t = h[a];
    h[a] = h[b];
    h[b] = t;
}

void initHeap_sol (Heap *h, int size) {
    h->values = calloc(size, sizeof(Elem));
    h->size = size;
    h->used = 0;
}

// versão recursiva
/*void bubbleUp_sol (Elem *a, int i) {
    
    if (i!=0) {
        if (a[i] < a[PARENT(i)]) {
            swap(a, i, PARENT(i));
            bubbleUp_sol (a, PARENT(i));
        }
    }    
    
}
*/
 // versao menos eficiente, melhor caso logaritmico!!
 // pode-se acrescentar "else break" para recuperar o melhor caso constante 
/*
void bubbleUp_sol (Elem *a, int i) {
    
    int p;
    while (i!=0) {
        p = PARENT(i);   
        if (a[i] < a[p]) 
            swap(a, i, p);
        i = p;
    }    
    
}
*/


void bubbleUp_sol (Elem *a, int i) {
    int p = PARENT(i);
    
    while (i!=0 && a[i] < a[p]) {
        swap(a, i, p);
        i = p;
        p = PARENT(i);
    }    
    
}

int  insertHeap_sol (Heap *h, Elem x) {
    if (h->used == h->size) {
        h->values = realloc(h->values, 2*(h->size)*sizeof(Elem)); 
        h->size *= 2;
    }
    h->values[h->used] = x;
    (h->used)++;
    bubbleUp_sol(h->values, h->used-1);
    return 1;
}

// 3 versoes

void bubbleDown_sol (Elem a[], int N) {
    int i = 0, min ;
    
    while (LEFT(i) < N) {
        min = a[i] < a[LEFT(i)] ? i : LEFT(i);
        if (RIGHT(i) < N)
            min = a[min] < a[RIGHT(i)] ? min : RIGHT(i);
        if (min != i) {
            swap(a, i, min);
            i = min;
        }
        else break;
    }
    
}

void bubbleDown_sol_2 (Elem a[], int N) {
    int i = 0, min ;
    
    while (LEFT(i) < N) {
        min = LEFT(i);
        if (RIGHT(i) < N && a[RIGHT(i)] < a[LEFT(i)])
            min = RIGHT(i);
        if (a[min] < a[i]) {
            swap(a, i, min);
            i = min;
        }
        else break;
    }
    
}

void bubbleDown_sol_3 (Elem a[], int N) {
    int i = 0, min ;
    
    while (RIGHT(i) < N &&
           a[min = a[LEFT(i)] < a[RIGHT(i)] ? LEFT(i) : RIGHT(i)] < a[i]) {
        swap(a, i, min);
        i = min;
    }
    if (LEFT(i) < N && a[LEFT(i)] < a[i])
        swap(a, i, LEFT(i));
}

int  extractMin_sol (Heap *h, Elem *x) {
    if (h->used > 0) {
        *x = h->values[0];   
        h->values[0] = h->values[h->used-1]; 
        (h->used)--;
        bubbleDown_sol(h->values, h->used);
        return 1;
    }
    else return 0;
}
