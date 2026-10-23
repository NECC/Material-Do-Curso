 # Programação Imperativa — Teste, 27 de Maio de 2026

## 1. Strings (3 valores)
Defina uma função `int parentesis_ok ( char exp[])` que, dada uma string onde está armazenada uma expressão aritmética com parêntesis, testa se os parêntesis estão
corretos. Por exemplo, se a expressão for `"31 + ((2 - 13) - x) + 114"` a função deve retornar verdadeiro (1), enquanto que para a expressão `"31 + (2 - (13 + 4))) + ((2 - x) + 114"` deve retornar falso (0).

```c title:Parentesis
int parentesis_ok2(char exp[]) {
	int balance = 0;
	for (int i = 0; i < strlen(exp); i++) {
		if (exp[i] == '(')
			balance++;
		if (exp[i] == ')') {
			balance--;
			if (balance < 0)
				return 0;
		}
	}
	return (balance == 0) ? 1 : 0;
}
```

## 2. Arrays (3 valores)
Assuma que existe uma função `int random( int N)` que devolve um número aleatório entre 0 e N-1 . Defina uma função `void sorteia( int a[], int N)` que, dado N > 0 ,
preenche o array a , de tamanho N , com todos os números de 0 a N-1 , colocados em
posições aleatórias. No final, cada um desses números deve aparecer exatamente uma
vez no array. Por exemplo, se `N == 5` , o array poderá ficar com os valores `{3, 0, 4, 1, 2}` ou {1, 4, 2, 0, 3} , mas não poderá ficar com `{1, 1, 2, 3, 4}`. Tente minimizar o número de invocações à função random.

```c title:Sorteia
void sorteia(int a[], int N) {
	int i;
	for (i = 0; i < N; i++)
		a[i] = i;
	for (i = N - 1; i > 0; i--) {
		int j = myRandom(i + 1);
		int temp = a[i];
		a[i] = a[j];
		a[j] = temp;
	}
}
```

## 3. Ordenação de arrays (1 + 2 = 3 valores)
### 1.
Defina a função `int minInd ( int v[], int N)` que, dado um array v com N elementos ( N>0 ) calcula um índice do array onde está armazenado o menor elemento do array v.

```c title:"Indice do menor"
int minInd(int v[], int N) {
	int i, m = 0;
	for (i = 1; i < N; i++)
		if (v[i] < v[m])
			m = i;
	return m;
}
```

### 2.
Defina a função `void minSort ( int v[], int N)` que ordena um array de N inteiros por sucessivas chamadas à função `minInd` .

```c title:minSort
void minSort(int v[], int N) {
	int i, m;
	for (i = 0; i < N - 1; i++) {
		m = minInd(v + i, N - i);
		int temp = v[i];
		v[i] = v[m + i];
		v[m + i] = temp;
	}
}
```

## 4. Listas ligadas (3 valores)
Defina uma função `int quantosMaiores ( LInt l)` que, dada uma lista não vazia ,
calcula quantas vezes ocorre na lista o maior elemento.

```c title:"Lista ligada"
typedef struct no {
	int valor;
	struct no *prox;
} *LInt;
```

```c title:"Quantos maiores"
int quantosMaiores(LInt l) {
	int i = 1, maior = l->valor;
	for (l = l->prox; l != NULL; l = l->prox) {
		if (l->valor > maior) {
			maior = l->valor;
			i = 1;
		} else if (l->valor == maior)
			i++;
	}
	return i;
}
```

## 5. Ordenação de listas (3 + 2 = 5)

### 1. 
Defina a função `LInt retiraMaior ( LInt*l)` que retira da lista `*l`o nodo onde se encontra o maior elemento da lista. A função retorna o endereço do nodo removido.

```c title:"Retira maior"
LInt retiraMaior(LInt *l) {
	if (*l == NULL)
		return NULL;
	LInt *curr = l;

	int maior = (*curr)->valor;
	while (*curr != NULL) {
		if ((*curr)->valor > maior)
			maior = (*curr)->valor;
		curr = &((*curr)->prox);
	}
	curr = l;
	while ((*curr)->valor != maior) {
		curr = &((*curr)->prox);
	}
	LInt r = *curr;
	*curr = (*curr)->prox;
	return r;
}
```

### 2.
Defina a função `LInt maxSort ( LInt l)` que ordena uma lista por sucessivas chamadas à função `retiraMaior`.

```c title:"Max sort"
LInt maxSort(LInt l) {
	LInt r, m;
	r = NULL;
	while (l != NULL) {
		m = retiraMaior(&l);
		m->prox = r;
		r = m;
	}
	return r;
}
```

## 6. Árvores binárias (3 valores)
Relembre a função `void mirror (ABin a)` que inverte uma árvore binária. Uma árvore diz-se simétrica se for igual à sua inversa. Defina a função `int simetrica (ABin a)` que testa se uma árvore é simétrica.

```c title:"Árvore binária"
typedef struct nodo {
	int valor;
	struct nodo *esq, *dir;
} * ABin; 
```

```c title:Mirror
void mirror(ABin a) {
	ABin t;
	if (a != NULL) {
		mirror(a->esq);
		mirror(a->dir);
		t = a->esq;
		a->esq = a->dir;
		a->dir = t;
	}
}
```

```c title:Simetrica
int iguais(ABin a, ABin b) {
	if (a == NULL && b == NULL)
		return 1;
	if (a == NULL || b == NULL)
		return 0;
	return (a->valor == b->valor && iguais(a->esq, b->esq) &&
			iguais(a->dir, b->dir));
}

int iguaisM(ABin a, ABin b) {
	if (a == NULL && b == NULL)
		return 1;
	if (a == NULL || b == NULL)
		return 0;
	return (a->valor == b->valor && iguais(a->esq, b->dir) &&
			iguais(a->dir, a->esq));
}

int simetrico(ABin a) { return iguaisM(a, a); }
```
