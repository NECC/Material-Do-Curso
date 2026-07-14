#include <stdio.h>
#include <stdlib.h>
#include "Stack.h"

void initStack (Stack *s){
    (*s) = NULL;
}
int SisEmpty (Stack s){
    return s == NULL;
}
int push (Stack *s, int x){
    (*s) = newLInt(x, (*s));
    return (*s) != NULL;
}
int pop (Stack *s, int *x){
    if ((*s) == NULL) return -1;
    *x = (*s)->valor;
    (*s) = (*s)->prox;
    return 0;
}
int top (Stack s, int *x){
    if (s == NULL) return -1;
    *x = s->valor;
    return 0;
}
