---
excalidraw-plugin: parsed

  - excalidraw
excalidraw-open-md: true
date: "2026-02-06"
---
1. Escreva um programa que desenha no ecra (usando o caracter '#') um quadrado de dimensão 5. 
```c
void linha(int y) {
	int x;
	for (x = 1; x <= y; x ++) {
		putchar('#');
	}
putchar('\n');
}

void cuadrado(int n) {
	int x, y;
	for (x = 1; x <= y; x ++) {
		linha(n);
	}
}
```

2. Escreva um programa que desenhe no ecrã (usando os caracteres #) um tabuleiro de xadrez. 

```c
void linhas_xadrez(int n) {
	int x;
	for (x = 1; x <= n; x ++) {
		if (x + n % 2 == 0) putchar('_');
		else putchar('#');
	}
putchar('\n');
}


void xadrez(int n) {
	int x;
	for (x = 1; x <= n; x ++) {
		linhas_xadrez(n);
	}
}
```

4. Escreva um programa que desenhe no ecrã (usando os carateres #) um circulo. O
programa deverá começar por ler o raio do circulo pretendido. 
```c
int circulo(int r) {
	int x, y;
	for (y = r; y >= -1 * r; y --){
		for (x = (-1) * r; x <= r; x ++){
			if (x * x + y * y <= r * r) putchar ('#');
			else putchar(' ');
			putchar('\n');
		}
	}
}
```

