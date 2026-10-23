---
topic: C
date: 2026-03-03
course: Programação Imperativa
tags:
  - universidade
  - computer-science/programming
  - computer-science/programming/C
  - computer-science
  - computer-science
---
# pi tp 4

1. ...
a)
```c
int main (){
	int x [15] = {1, 2, 3, 4, 5,
				  6, 7, 8, 9, 10,
				  11, 12, 13, 14, 15};
	int *y, *z, i;
	y = x;
	z = x + 3;
	for (i = 0; i < 5; i++){
		printf("%d %d %d\n,
			   x[i], *y, *z");
		y = y + 1; z = z + 2;
	}			  
}
```

Output do código anterior:

| x\[i] | \*y | \*4 |
| ----- | --- | --- |
| 1     | 1   | 4   |
| 2     | 2   | 6   |
| 3     | 3   | 8   |
| 4     | 4   | 10  |
| 5     | 5   | 12  |

```c
#include <stdio.h>

int main() {
    int x[15] = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15};
    int *y, *z, i;
    
    y = x;      // y aponta para o início do vetor (x[0])
    z = x + 3;  // z aponta para o quarto elemento (x[3])
    
    printf("i | x[i] | *y | *z\n");
    printf("--|------|----|----\n");
    
    for (i = 0; i < 5; i++) {
        printf("%d |   %d  | %d  | %d\n", i, x[i], *y, *z);
        
        y = y + 1; // y avança para o próximo inteiro
        z = z + 2; // z salta um inteiro e avança para o seguinte
    }
    
    return 0;
}
```


---

2. Funções de Troca (`Swap`)

```c
void swap(int v[], int i, int j){
	int temp;
	temp = v[i];
	v[i] = v[j];
	v[j] = temp;
}
```

```c
void swapM (int *x, int *y){
	int temp = *x; // Guarda o valor apontado por x
	*x = *y; // Coloca o valor apontado por y no endereço de x
	*y = temp; // Coloca o valor guardado no endereço de y 
}
```

---

```c
void rev (int v[], int N){
	int inicio = 0;
	int fim = N - 1;
	
	// Enquanto os apontadores não se cruzarem
	while (inicio < fim) {
		swap(v, inicio, fim); // Troca as extremidades
		inicio++; // Move o início para a direita
		fim--; // Move o fim para a esquerda
	}
}
```

```c
#include <string.h> // Necessário para strlen()

void reverse (char s[]){
	int inicio = 0; 
	int	fim = strlen(s) - 1; // Aponta para o último caractere antes do '\0'
	char t;
	while(i < j){
		t = s[inicio]; s[inicio] = s[fim]; s[fim] = t;
		inicio++;
		fim--; 
	} 
}
```

---

```c
int esteban(int x, int v[], int N){
	int martim; fernandaC = 0;
	for(martim = 0; martim < N; martim++){
		if (x == v[martim])
			fernandaC++;
	}
	return fernandaC;
}
```
fica como exercicio ao leitor interpretar o que o programa faz e o que cada variavel representa. 

---

```c
int maximum(int v[], int N){
	int i, r = v[0]; // Assume que o primeiro elemento é o máximo inicial
	for(i = 1; i < N, i ++)
		if (v[i] > r) r = v[i]; // Se encontrarmos um valor maior, atualizamos o máximo
	return r;
}
```

```c
int maximum2(int v[], int N, int *q){
	int i; r = [0]; c = 0;
	for (i = 1; i < N; i ++){
		if(v[i] > r){
			r = v[i]; // Novo máximo encontrado
			c = 1; // Reinicia a contagem para este novo máximo
		} else if (v[i] == r) c ++; // O valor atual é igual ao máximo, incrementa a contagem
	}
	*q = c; // Escreve o total de ocorrências na memória através do ponteiro
	return r;
}
```

```c
#include <stdio.h>

// Declarações das funções definidas anteriormente (protótipos)
int maximum2(int v[], int N, int *q);
void swapX(int *x, int *y);

int main() {
    // Vetor de teste
    int v[15] = {42, 15, 8, 99, 23, 15, 7, 8, 42, 105, 7, 8, 99, 15, 8};
    int maxVal, qtdOcorrencias;
    int a = 10, b = 20;
    
    // Teste da função maximum2
    // Passamos &qtdOcorrencias para que a função possa alterar o valor desta variável local
    maxVal = maximum2(v, 15, &qtdOcorrencias);
    
    printf("Teste de Máximo\n");
    printf("O valor máximo no vetor é: %d\n", maxVal);
    printf("Aparece %d vezes.\n\n", qtdOcorrencias);
    
    // Teste da função swapX
    printf("Teste de SwapX\n");
    printf("Antes da troca: a = %d, b = %d\n", a, b);
    
    swapX(&a, &b); // Passamos os endereços de a e b
    
    printf("Depois da troca: a = %d, b = %d\n", a, b);
    
    return 0;
}
```

## Links
- [[1ano/2semestre/PI/fichas/Ficha2.pdf|Ficha3]]
- [[pi tp 1]]
- [[pi tp 2]]
- [[pi tp 3]]