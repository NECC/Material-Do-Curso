---
topic: C
date: 2026-02-25
course: Programação Imperativa
tags:
  - universidade
  - computer-science/programming/C
  - computer-science/programming
  - computer-science/pi
---
# pi tp 3

## 1. Multiplicação (Método Russo / Multiplicação por Duplicação)
### Background Teórico
O primeiro problema aborda a multiplicação sem usar o operador `*`. A matemática por trás destas funções baseia-se numa propriedade muito elegante da aritmética binária: podemos multiplicar dois números dividindo um por dois (divisão inteira) e multiplicando o outro por dois.
Seja a operação $n⋅f$:
- Se n é par: $n⋅f=\frac{2}{n}​⋅(2f)$
- Se n é ímpar: $n⋅f=f+\frac{n}{2}⋅(2f)$

```c 
float mult(int n, float f){
	if (n==0) return 0;
	if (n%2==0) return (mult(n/2, f + f));
	else return (f + mult(n+2, f + f)); 
}
```

```c
float mult(int n, float r){
	float r = 0; 
	while (n > 0){
		if (n%2 ==1)
			r += f;
		n = n/2; f += f;
	}
	return r;
}
```
A versão recursiva consome memória extra porque empilha chamadas na memória do computador (a _Call Stack_). A versão iterativa (com o `while`) utiliza apenas as variáveis locais, o que a torna mais segura e eficiente em termos de memória espacial (complexidade de espaço $O(1))$.

---
## 2. Potenciação (Exponenciação Rápida)

### Background Teórico
A potenciação normal $f^n$ exige multiplicar $f$ por si mesmo $n$ vezes. No entanto, podemos usar uma propriedade matemática para acelerar isto drasticamente: $$f^n=(f^2)^{\frac{n}{2}}$$
Se quisermos calcular $2^{10}$, não precisamos de fazer $10$ multiplicações. Podemos fazer $(2^2)^5=4^5$. Reduzimos o problema a metade.

```c
float pot(int n, float f){
	float r = 1;
	int i;
	for (i=0; i<n; i ++)
		r *=f;
	return r;
}
```

```c
float pot(int n, float f){
	float r = 1;
	while (n>0){
		if (n%2 == 1) 
			r *=f;
		r = f * f ; //elevamos a base ao quadrado
		n = n/2; // Reduzimos o expoente a metade
	}
	return r;
}
```
A primeira versão tem uma complexidade de tempo $O(n)$. $Se\space n=1.000.000$, o ciclo corre um milhão de vezes. A versão otimizada divide o $n$ por $2$ em cada passo. Para $n=1.000.000$, o ciclo executa apenas cerca de 20 vezes. A eficiência temporal passa a ser algorítmica ou $O(\log n)$.

---
## 3.  Máximo Divisor Comum (MDC)

### Background Teórico
Aqui entramos no coração da teoria dos números. O segundo código implementa o famoso **Algoritmo de Euclides**, que se apoia diretamente no Algoritmo da Divisão. O teorema fundamental dita que, se dividirmos n por m obtendo um resto r, então:
$$mdc(n,m)=mdc(m,r)$$
Isto permite substituir um número grande pelo resto da sua divisão sucessivamente, até atingir o zero.

O primeiro código (força bruta) procura o MDC testando todos os números menores, começando do menor entre n e m e descendo (`c--`).
```c
int mdc(int n, int m){
	int c; 
	if (n<m) c = n; // ou  c = (n<m)? n:m
	else c = m;
	while (!(n%c == 0 && m%c == 0))
		c--;
	return c;
}
```

```c 
int mdc(int n, int m){
	while(n!=0 && m!=0){
		if (n>m) n = n%m;
		else m = m%n;
	}
	if (n==0) return m;
	else return n;
}
```
O primeiro código pode exigir milhares de subtrações e testes de divisibilidade. O Algoritmo de Euclides (o segundo código) usa a operação de módulo (`%`), que calcula o resto instantaneamente. Isto transforma um algoritmo lento e exaustivo numa operação elegante que resolve o problema numa fração mínima de segundos.

---
## 4. Sequência de Fibonacci
### Background Teórico
A sequência de Fibonacci é uma relação de recorrência clássica onde cada termo é a soma dos dois anteriores: $Fn​=Fn−1​+Fn−2​$, com $F_{0}=0$ e $F_{1}=1$.

![[Pasted image 20260225200618.png]]

```c 
int fib(int n){
	if (n<2) return n;
	else return (fib(n-1) + fib(n-2));
}
```

```c
long fib(int n){
	long F[n+1]; int i;
	f[0] = 0; F[1] = 1;
	for (i = 2; i <= n; i ++)
		F[i] = F[i-1] + F[i-2];
	return F[n];
}
```

```c
int main(){
	int x;
	scanf("%d", &x);
	printf("fib(%d)=%d", x, fib(n));
	return 0;
}
```
A recursividade ingénua (primeiro código) é catastrófica aqui. Para calcular `fib(5)`, o programa calcula `fib(3)` várias vezes de forma redundante. O tempo de execução cresce exponencialmente $(O(2^n))$. A segunda versão cria um vetor e resolve o problema de baixo para cima (bottom-up), consultando os resultados anteriores. Demora apenas $n$ passos (complexidade de tempo $O(n))$, transformando um problema que demoraria anos para um n grande num cálculo instantâneo.

## Links
- [[1ano/2semestre/PI/fichas/Ficha2.pdf|Ficha2]]
- [[pi tp 1]]
- [[pi tp 2]]