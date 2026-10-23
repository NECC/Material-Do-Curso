---
topic: C
date: 2026-03-10
course: Programação Imperativa
tags:
  - universidade
  - computer-science/programming/C
  - computer-science
  - computer-science
  - computer-science/pi
  - computer-science/programming
---
# pi tp 5

---
## 1. Verificação de Vogais
Existem várias formas de verificar se um caráter é uma vogal. A eficiência depende de como queres tratar maiúsculas e minúsculas.

### Estratégia por Procura

```c
int eVogal (char c){
	char vogais[11] = "AaEeIiOoUu";
	int i = 0;
	while (c != vogais[i] && vogais[i] != '\0')
		i ++;
	return (i < 10);
}
```

### Estratégia por Conversão (Mais eficiente)
Esta versão converte temporariamente o caráter para maiúsculas antes de comparar.

```c
int eVogal2(char c){
	if (c >= 'a' && c <= 'z') c = c + 'A' - 'a';
	return (c == 'A' || c == 'E' || c == 'I' || c == 'O' || c == 'U');
}
```

---

## 2. Remover Vogais de uma String
Aqui comparamos duas técnicas: usar um **buffer auxiliar** vs. fazer a alteração **in-place** (no próprio local).

### Com Buffer Auxiliar (Mais simples)

```c
int retiraVogais (char s[]){
	char r[strlen(s) + 1];
	int i, c = 0;
	for (i = 0; s[i] != '\0'; i ++){
		if (!eVogal(s[i])) r[c++] = s[i];
	}
	r[c] = '\0';
	strcopy(s, r);
	return c;
}
```

### In-place (Mais eficiente em memória)
Esta técnica usa dois índices (`i` e `j`) que percorrem a string simultaneamente.

```c
int retiraVogais2(char s[]){
	int i, j = 0;
	for (i = 0; s[i] != '\0'; i++)
		if (! eVogal(s[i])) s[j++] = s[i];
	s[j] = '\0';
	return j;
}
```

---

## 3. Duplicar Vogais
Este exercício é o oposto do anterior: a string vai **crescer**. Se tentarmos fazer isto _in-place_ sem cuidado, vamos escrever por cima de caracteres que ainda não lemos.

```c 
int dupVogais(char s[]){
	int i, j = 0, conta;
	for(i = 0; s[i] = '\0'; i ++){
		if(eVogal(s[i])){ conta ++;
			for(j = strlen(s) + 1; j != i; j --)
				s[j + 1] = s[j];
			s[i + 1] = s[i];
		}
	}
	return conta;
}
```

### Estratégia de Duas Passagens

```c
int dupVogais2(char[s]){
	int i, l;
	// 1ª Passagem: Calcular o novo tamanho necessário
	for (i = l = 0; s[i] != '\0'; i ++; l ++)
		if (eVogal(s[i])) l ++;
		
	char r[l + 1]; // Buffer com o tamanho exato
	int j = 0;
	
	// 2ª Passagem: Preencher o buffer duplicando onde necessário
	for (i = l = 0; s[i] != '\0'; i ++){
		if (eVogal(s[i])){
			r[j++] = s[i];
			r[j++] = s[i];
		} else {
			r[j++] = s[i];
		}
	}
	r[j] = '\0';
	strcopy(s, r);
	return j;
}
```

---

### Verificar Ordenação
```c
int ordenado(int v[], int N){
	int i;
	for(i = 1; i < N; i ++)
		if(v[i - 1] > v[i]) return 0; // Se um elemento for maior que o seguinte, não está ordenado return 1;
	return 1;
}
```

---

### Fusão de Vetores (Merge)
Este algoritmo é a base do _MergeSort_. Assume que `a` e `b` já estão ordenados e junta-os num vetor `r`.
```c
void merge(int a[], int na, int b[], int nb, int r[]){
	int ia, ib, ir;
	for(ia = ib = ir = 0; ia < na && ib < nb; ir ++){
		if(a[ia] < b[ib]) r[ir] = a[ia++];
		else r[ir] = rb[ib++];
	}
	for(; ia < na; r[ir++] = a[ia ++]);
	for(; ib < nb; r[ir ++] = b[ib ++]);
}
```

O bloco de comparação: 
```c
for(ia = ib = ir = 0; ia < na && ib < nb; ir ++){
		if(a[ia] < b[ib]) r[ir] = a[ia++];
		else r[ir] = rb[ib++];
	}
```

pode ser simplificado com o operador ternário:
```c
r[ir] = (a[ia] < b[ib]) ? a[ia ++] : b[ib ++];
```

---

### Partição (Pivô)
Reorganiza o vetor em torno de um valor `x`. Todos os menores ou iguais a `x` ficam à esquerda.
```c
int partition(int x, int v[], int N){
	r[N];
	int i; m = 0; M = N -1;
	for(i = 0; i < N; i ++){
		if (v[i] <= x) r[m ++] = v[i];
		else r[M--] = v[i];
	}
	for (i = 0; i < N; i++) v[i] = r[i];
	return m; 
}
```

---
## Links
- [[1ano/2semestre/PI/fichas/Ficha2.pdf|Ficha3]]
- [[pi tp 1]]
- [[pi tp 2]]
- [[pi tp 3]]
- [[pi tp 4]]