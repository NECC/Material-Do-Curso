---
topic: C
date: 2026-03-24
course: Programação Imperativa
tags:
  - universidade
  - computer-science/programming/C
  - computer-science/programming
---
# pi tp 7

```c
typedef struct st {
	int tam;
	int *v;
	int sp;
} STACK;
```

```c
void empty (STACK *s){
	s->v = malloc(10*sizeof(int));
	s->tam = 10;
	s->sp = 0;
}
```

```c
int isEmpty (STACK *s){
	return (s->sp == 0);
}
```

```c
void pop2(STACK *s, int *t){
	int flag = 1;
	if(s->sp > 0){
		s->sp -=1;
		*t = s->v[s->sp];
		flag = 0;
	}
	return flag;
}
```

```c
void push(STACK *s, int x){
	int *v2; int i;
	if(s->sp == s->tam){
	v2 = malloc(2*s->tam*sizeof(int));
	for(i = 0; i < s->tam; i++) v[i] = s->v[i];
	s->v = v2;
	s->tam *= 2; 
	}
	s->v[s->sp] = x;
	s->sp++;
}
```

---

## Links
- [[1ano/2semestre/PI/fichas/Ficha3.pdf|Ficha3]]
- [[1ano/2semestre/PI/fichas/Ficha3.pdf|Ficha4]]
-  [[pi tp 1]]
- [[pi tp 2]]
- [[pi tp 3]]
- [[pi tp 4]]
- [[pi tp 5]]
- [[pi tp 6]]
