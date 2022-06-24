
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "hashing.h"


int hash(char key[], int size) {
    int i,hashVal=0;
    for(i=0; i<size && key[i]!='\0';i++){
        hashVal+=key[i];
    }
    return hashVal%size;
}


void initHT(HT *h, int size) {
     h->size = size;
     h->tbl = calloc(size,sizeof(struct pair));
     int i;
     for(i=0;i<size;i++){
         strcpy(h->tbl[i].key,EMPTY);
     }
}


int freeHT(HT *h, int k) {
    return (strcmp(h->tbl[k].key,EMPTY) || strcmp(h->tbl[k].key,DELETED));
}



int writeHT (HT *h, char key[], int value) {
    int pos = hash(key,h->size);
    
    return writeHT_sol (h, key, value);
}



int readHT (HT *h, char key[], int* value) {
    
    return readHT_sol (h, key, value);
}



int deleteHT (HT *h, char key[]) {

    return deleteHT_sol (h, key);
}




