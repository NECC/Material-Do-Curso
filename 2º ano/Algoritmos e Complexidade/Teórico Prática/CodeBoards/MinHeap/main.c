/* Main function of the C program. */

#include <stdio.h>
#include <stdlib.h>
#include "minheap.h"

int main()
{

    Heap h;
    int i, x;

    initHeap_sol(&h, 1);
    insertHeap_sol(&h, 30);
    insertHeap_sol(&h, 60);
    insertHeap_sol(&h, 40);
    insertHeap_sol(&h, 10);
    insertHeap_sol(&h, 100);
    insertHeap_sol(&h, 20);
    insertHeap_sol(&h, 90);
    insertHeap_sol(&h, 50);
    insertHeap_sol(&h, 80);
    insertHeap_sol(&h, 70);
  
    printf("Heap construída (capacidade %d):\n", h.size);
    for (i = 0; i < h.used; i++)
        printf("%d\n", h.values[i]);

    printf("Extracção de elementos:\n");
    while (extractMin_sol(&h, &x)) 
        printf("%d\n", x);
}
