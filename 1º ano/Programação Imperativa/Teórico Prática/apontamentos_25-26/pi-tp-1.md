---
topic: C
date: 2026-02-19
course: Programação Imperativa
tags:
  - universidade
  - computer-science/pi
  - computer-science/programming/C
  - computer-science/programming
---
# pi tp 1

## Exercicios

1
```c
int i = 0; 
while (i < 10){
	if (i % 2 == 0) putchar('_');
	else putchar('#');
	i = i + 1;
}
putchar('\n');


int main() {
	for (int i = 1; i < 10, i ++){
	printf("%d\n", i);
	}
	return 0;
}
```

2
```c
#include <stdio.h>
int main(){
	int x; int i;
	printf("até que número?");
	scanf("%d", &x);
	for (i = 1; i <= x; i++);
		printf("%d\n", x);
	return 0;
}
```

3 
```c
#include <stdio.h>
int main() {
	int main x, y;
	scanf("%d", &y);
	for (x = 1; x <= y; x ++);
		putchar('#');
	putchar('\n');
}
```

4
```c
#include <stdio.h>

void linha(int y) {
	int x; 
	for (x = 1; x <= y; x ++) {
		putchar('#');
	}
	putchar('\n');
}


int main() {
	int x, y;
	scanf("%d", &y);
	for (x = 1; x <= y; x ++);
		linha (y);
	return 0; 
}
```

5 
```c
#include <stdio.h>

void linha (int y) {
	int x; 
	for (x = i; x <= y; x ++){
		if (x + y % 2 == 0) putchar('_');
		else putchar('#');
	}
	putchar('\n');
}


int main(){
	int x, y; 
	scanf("%d", &y);
	for(x = 1; x <= y; x ++);
		linha (y);
	return 0; 
}


```

## Links 
- [[1ano/2semestre/PI/fichas/Ficha1.pdf|Ficha1]]