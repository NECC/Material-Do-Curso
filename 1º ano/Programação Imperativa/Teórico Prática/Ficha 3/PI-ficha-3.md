---
excalidraw-plugin: parsed
tags:
  - excalidraw
excalidraw-open-md: true
date: "2026-03-02"
---

2. ...
```c
int swapM (int *x, int *y){
	int empty;
	empty = *x;
	*x = *y;
	*y = empty; 
}
```

3. ...
```c
void swap (int v[], int i, int j){
	int empty;
	empty = v[j];
	v[j] = v[j];
	v[j] = empty;
}
```

4. ...
```c
int soma (int v[], int N){
	int i = 0, resultado = 0;
	while (i < N){
		resultado += v[i];
		i ++;
	}
	return resultado; 
}
```

5. ...
```c
void inverterArray (int v[], int N){
	int inicio = 0;
	int fim = N - 1;
	while (inicio < fim){
		swap (v, inicio, fim);
		inicio ++;
		fim --;
	}
}
```

ou 

```c
void inverterArray (int v[], int N){
	int inicio = 0;
	int fim = N - 1;
	while (inicio < fim){
		swapM(&v[inicio], &v[fim]);
		inicio ++;
		fim --;
	}
}
```

6. ...
```c
int maximum (int v[], int N, int *m){
	int i; 
	if (n <= 0) return 1;
	*m = v[0];
	for (i = 1; i < N; i ++){
		if (v[i] > *m) *m = v[i];
	}
	return 0;
}
```

7. ...
```c
void quadrados (int q[], int N){
	int i;
	for (i = 0; i < N, i ++)
		q[i] = q[i - 1] + (2 * (i - 1) + 1);
}
```

ou 

```c
void quadrados (int q[], int N){
	q[0] = 0;
	int i;
	int impar = 1;
	for (i = 1; i < N; i ++){
		q[i] = q[i - 1] + impar;
		impar += 2;
	}
}
```

8. ...
```c
void pascal(int p[], int n){
	int i, j;
	p[0] = 1;
	for(i = 0; i < n; i++){
		p[i + 1] = 1;
		for(j = i; j >= 1; j--);
			p[j] = p[j] + p[j - 1];
	}
}
```















