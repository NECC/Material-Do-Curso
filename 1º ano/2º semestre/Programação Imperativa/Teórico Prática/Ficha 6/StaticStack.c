#include <stdio.h>
#include <stdlib.h>

#define Max 10

struct staticStack {
	int sp;
	int values [Max];
};
typedef struct staticStack *SStack;

void SinitStack (SStack s){
	s->sp = 0;
}

int  SisEmpty (SStack s){
	return s->sp == 0;
}

int  Spush (SStack s, int x){
	int r = 0;
	
	if (s->sp == Max) r = 1;
	else {
	    s->values[(s->sp)++] = x;
	}
	
	return r;
}

int  Spop (SStack s, int *x) {
	int r=0;
	
	if (s->sp == 0) r = 1;
	else {
	    *x = s->values[--(s->sp)];
	}
	
	return r;
}

int  Stop (SStack s, int *x) {
	int r=0;
	
	if (s->sp == 0) r = 1;
	else {
	    *x = s->values[s->sp-1];
	}
	
	return r;
}
