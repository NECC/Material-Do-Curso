---
topic: C
date: 2026-03-17
course:
tags:
  - universidade
  - computer-science/programming/C
  - computer-science
  - computer-science/pi
  - computer-science/programming
---
# pi tp 6

---

### 1. Triângulo de Pascal (Otimização de Memória)
O objetivo aqui é calcular uma linha do Triângulo de Pascal usando apenas um vetor, atualizando-o "sobre si mesmo".

```c
void pascal(int p[], int n){
	int i, j;
	p[0] = 1; // O primeiro elemento é sempre 1
	for(i = 0; i < n; i++){
		p[i + 1] = 1; // Define o último elemento da linha atual
		for(j = i; j >=1; j--) // Atualizamos de trás para a frente para não perder os valores da "linha anterior"
			p[j] = p[j] + p[j - 1];
	}
}
```
>[!TIP] 
>Porquê de trás para a frente? Se atualizares da esquerda para a direita, vais somar valores
>que já foram alterados na iteração atual, corrompendo o cálculo. Ao vir de trás, garantes que `p[j-1]` ainda é o valor da "linha de cima".


#### Versão alternativa 
```c
/**

* Return an array of arrays of size *returnSize.

* The sizes of the arrays are returned as *returnColumnSizes array.

* Note: Both returned array and *columnSizes array must be malloced, assume caller calls free().

*/

int** generate(int numRows, int* returnSize, int** returnColumnSizes) {
	int i, j, columnSize;
	*returnSize = numRows;
	int **ans = malloc(numRows*sizeof(int*));
	*returnColumnSizes = malloc(numRows * sizeof(int));
	for(i = 0; i < numRows; i++){
		ans[i] = malloc((i + 1) * sizeof(int));
		(*returnColumnSizes)[i] = i + 1;
	}
	ans[0][0] = 1;
	for(i = 1; i < numRows; i ++){
		ans[i][0] = 1;
		ans[i][i] = 1;
		for(j = i - 1; j >= 1; j--) ans[i][j] = ans[i - 1][j] + ans[i-1][j -1];
	}
	return ans;
}
```
---

### 2. Estruturas (`struct`) e Cálculo de Notas
Usamos `struct` para agrupar dados de diferentes tipos (inteiros, strings, floats) sobre uma mesma entidade: o **Aluno**.

```c
typedef struct aluno {
	int numero;
	char nome[100];
	float miniT[5]; // 0..4
	float teste; // 0..20
} Aluno;
```

#### Cálculo da Nota Final
A fórmula segue uma lógica condicional: a média dos mini-testes (m) deve ser ≥8 para que o teste final conte. $$Nota = m \times 0.2 + teste \times 0.8$$
```c
int nota(Aluno a){
	int i, r = 0;
	float m = 0;
	for(i = 0; i < 5; i++)
		m += a.miniT[i];
	if(m >= 8){
		m = m * 0.2 + a.teste * 0.8;
		if(m >= 9.5) r = (int) (m + 0.5); // Arredondamento às unidades: somar 0.5 antes de converter para int
	}
	return r; // Retorna 0 se reprovado ou a nota arredondada
}
```

### 3. Pesquisa Binária em Estruturas

```c
int procuraNum (int num, Aluno t[], int N){
	int r = -1, i = 0, s = N - 1, m;
	while (r == -1 && i <= s){
		m = (i + s) / 2;
		if (t[m].numero == num) r = m;
		else if (t[m].numero > num) s = m - 1;
		else i = m + 1;
	}
	return r; // Retorna o índice ou -1 se não encontrar
}
```


### 4. Ordenação: Direta vs. Indireta
Aqui comparamos o **Bubble Sort** aplicado de duas formas.

```c
void swapA(Aluno v[], int i, int j){
	Aluno x = v[i];
	v[i] = v[j];
	v[j] = x;
}
```
#### Ordenação Direta (Move os dados)
Troca os alunos de lugar no vetor. É pesado se a `struct` for muito grande.
```c
int ordenaPorNum(Aluno t[], int N){
	int i, j;
	for(i = N; i > 0; i --){
		for(j = 0; j < N - 1; j ++){
			if(t[j].numero > t[j].numero)
			swapA(t, j, j + 1)
		}
	}
}
```


#### Ordenação Indireta (Usa Índices)
**Esta é a técnica "eficiente relativamente ao uso de memória**. Não mexemos no vetor de alunos (que pode ser gigante). Em vez disso, ordenamos um vetor de inteiros (`ind`) que aponta para as posições dos alunos.
```c
int ordenaPorInd(Aluno t[], int N, int ind[]){
	int i, j;
	for(i = 0; i < N; i ++) ind[i] = i; // Inicializar o vetor de índices: {0, 1, 2, ..., N-1}
	for(i = 0; j < N; i ++){
		for(j = 0; j < N - 1 - i; j ++){
			if(t[ind[j]].numero > t[ind[j + 1]].numero){
				// swap(ind, j, j + 1);
				int temp = ind[j];
				ind[j] = ind[j+1];
				ind[j+1] = temp;
			}
		}
	}
}
```

---

### 5. Manipulação de Bits
Uma função simples mas essencial para entender como os números são guardados.
```c
int bitsUm(unsigned x){
	int r = 0;
	while (x != 0){
		r += x % 2; // Se o resto for 1, o bit está ligado
		x /= 2; // Desloca para o próximo bit
	}
	return r
}
```

-------
## Links
- [[1ano/2semestre/PI/fichas/Ficha3.pdf|Ficha3]]
- [[1ano/2semestre/PI/fichas/Ficha3.pdf|Ficha4]]
-  [[pi tp 1]]
- [[pi tp 2]]
- [[pi tp 3]]
- [[pi tp 4]]
- [[pi tp 5]]
