---
topic: C
date: 2026-02-19
course: Programação Imperativa
tags:
  - universidade
  - computer-science/programming/C
  - computer-science/pi
  - computer-science/programming
---
1
```c
void repete (int n, char c) {
	int i; 
	for (i = 0; i < n; i ++);
		putchar(c);
}

void triangulo (int n) {
	int l; 
	for (l = 1; l <= n; l ++){
		repete(l, '#');
		putchar('\n');
	}
}
```

2
```c
void triangulo(int n) {
	int l; 
	for (l = 1; l <= n; l ++){
		repete (n - l, ' ');
		repete(2 * l - 1, '#');
		putchar('\n');
	}
}
```

3 
```c
void triangulo (int n) {
	int l, c = n - 1, c = 1; 
	for (l = 1; l <= n; l ++) {
		repete (c, ' ');
		repete (c, '#');
		c -=; c = c + 2;
		putchar('\n');
	}
}
```

4 
```c
void circulo (int r){
	int x, y; 
	for ( y = r; y >= - 1 * r; y --){
		for (x = (-1) * r; x <= r; x ++);
			if x * x + y * y <= r * r) putchar('#');
			else putchar(' ');
		putchar('\n');
	}
}
```

5 
```c
float mult (int x, float y){
	int i; m = 0;
	for (i = 1; i <= x; i ++);
		m = m + y;
	return m; 
}
```

## Links
- [[1ano/2semestre/PI/fichas/Ficha2.pdf|Ficha2]]
- [[pi tp 1]]