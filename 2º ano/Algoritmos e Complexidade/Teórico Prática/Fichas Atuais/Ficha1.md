# 1 Especificações

## 1. Descreva o que faz cada uma das seguintes funções

(a)

```c
int fa (int x, int y){
// pre: True
...
// pos: (m == x || m == y) && (m >= x && m >= y)
return m;
}
```
R.: Retorna o maior elemento.

(b) 
```c
int fb (int x, int y){
// pre: x >= 0 && y >= 0
...
// pos: x % r == 0 && y % r == 0
return r;
}
``` 
R.: Retorna o divisor comum de `x` e `y`.

(c) 
```c
int fc (int x, int y){
// pre: x > 0 && y > 0
...
// pos: r % x == 0 && r % y == 0
return r;
}
```
R.: Retorna o múltiplo comum de `x` e `y`.
 
(d) 
```c 
int fd (int a[], int N){
// pre: N>0
...
// pos: 0 <= p< N && forall_{0 <= i< N} a[p] <= a[i]
return p;
}
```
R.: Retorna um índice da lista onde está um elemento menor ou igual a todos os outros.  

(e) 
```c 
int fe (int a[], int N){
// pre: N>0
...
// pos: forall_{0 <= i< N} x <= a[i]
return x;
}
```
R.: Retorna um `x` que é menor ou igual a todos os restantes elementos da lista.

(f)
```c 
int ff (int a[], int N){
// pre: N>0
...
// pos: (forall_{0 <= i< N} x <= a[i]) &&
// (exists_{0 <= i <N} x == a[i])
return x;
}
```
R.: Retorna um `x` que pertence à lista e é menor ou igual a todos os elementos da lista.

(g) 
```c
int fg (int x, int a[], int N){
// pre: N>=0
...
// pos: (p == -1 && forall_{0 <= i < N} a[i] != x) ||
// ( (0 <= p < N ) && x == a[p])
return p;
}
```
R.: retorna -1 caso o elemento `x` não exista na lista o ou seu indice caso exista.

## 2. Escreva as pré e pós-condições para as seguintes funções.

(a) A função `int prod (int x, int y)` que calcula o produto de dois inteiros.

pré: True  
pós: `r == x*y` 

(b) A função `int mdc (int x, int y)` que calcula o maior divisor comum de dois
números inteiros positivos.

pré: True

pós: `(x % r == 0 && y % r == 0) && nexists_{r < i < inf} x % i == 0 && y % i == 0`  

(c) A função `int sum (int v[], int N)` que calcula a soma dos elementos de um
array.

pré: N >= 0  
pós: `r == sum_{0 <= i < N} v[i]` 

(d) A função `int maxPOrd (int v[], int N)` que calcula o comprimento do maior
prefixo ordenado de um array.

pré: N >= 0

pós: `(N == 0 && r == 0) || (forall_{1 <= i < r} v[i-1] < v[i] && v[r] > v[r-1])`  

(e) A função `int isSorted (int v[], int N)` que testa se um array está ordenado
por ordem crescente.

pré: N >= 0

pós: `forall_{1 <= i < N} v[i-1] < v[i]` 

# 2 Correção

## 1. Para cada um dos seguintes triplos de Hoare, apresente um contra-exemplo que mostre a sua não validade.

(a) `{True} r = x+y; {r ≥ x}`

R.: `x = 3, y = -1`

(b) `{True} x = x+y; y = x-y; x = x-y; {x == y}`

R.: `x = 3, y = 2` 

(c) `{True} x = x+y; y = x-y; x = x-y; {x 6= y}`

R.: `x = 3, y = 3`

(d) `{True} if (x>y) r = x-y; else r = y-x; {r > 0}`

R.: `x = 3, y = 3`

(e) `{True} while (x>0) { y=y+1; x = x-1;} {y > x}`

R.: `x = 0, y = -1` 

## 2. Modifique a pré-condição de cada um dos triplos de Hoare da alínea anterior de forma a obter um triplo válido.

a) `x > 0 && y > 0`  
b) `x == y`  
c) `x != y`  
d) `x != y`  
e) `(x <= 0 && y > x) || (x > 0 && y > -x)` ou `y > -|x|`

# 3 Invariantes

## 1.Considere as seguintes implementações de uma função que calcula o produto de dois números.

```c
int mult1 (int x, int y){      |     int mult2 (int x, int y){
// pre: x>=0                   |     // pre: x>=0
int a, b, r;                   |     int a, b, r;
a=x; b=y; r=0;                 |     a=x; b=y; r=0;
while (a>0){                   |     while (a>0) {
r = r+b;                       |     if (a%2 == 1) r = r+b;
a = a-1;                       |     a=a/2; b=b*2;
}                              |     }
// pos: r == x * y             |     // pos: r == x * y
return r;                      |     return r;
}                              |     }
```
(a) Para cada um dos predicados, indique se são verdadeiros no início (Init) e preservados pelos ciclos destas duas funções

| Predicado | Init | Pres | Init | Pres |
|---|---|---|---|---|
| r == a * b | &#x274C; | &#x274C; | &#x274C; | &#x274C; |
| a >= 0 | &#10004; | &#10004; | &#10004; | &#10004; |
| b >= 0 | &#x274C; | &#x274C; | &#x274C; | &#x274C; |
| r >= 0 | &#10004; | &#x274C; | &#10004; | &#x274C; |
| a == x | &#10004; | &#x274C; | &#10004; | &#x274C; |
| b == y | &#10004; | &#10004; | &#10004; | &#x274C; |
| a * b == x * y | &#10004; | &#x274C; | &#10004; | &#x274C; |
| a * b + r == x * y | &#10004; | &#10004; | &#10004; | &#10004; |

(b) Apresente invariantes dos ciclos destas duas funções que lhe permitam provar a
sua correção (parcial).

R.: `a * b + r == x * y && a >= 0`

## 2. Para cada uma das funções seguintes, indique um invariante de ciclo que lhe permita provar a correcção parcial. Em cada um dos casos, mesmo informalmente, apresente argumentos que lhe permitam demonstrar as propriedades (inicialização, preservação e utilidade) dos invariantes definidos

(a) Índice do menor elemento de um array.

```c
int minInd (int v[], int N) {
// pre: N>0
int i = 1, r = 0;
// inv: ???
while (i<N) {
if (v[i] < v[r]) r = i;
i = i+1;
}
// pos: 0 <= r < N && forall_{0 <= k < N} v[r] <= v[k]
return r;
}
```

R.: `0 <= r < i && (forall_{0 <= k < i} v[r] <= v[i])`  

(b) Menor elemento de um array.

```c
int minimo (int v[], int N) {
// pre: N>0
int i = 1, r = v[0];
// inv: ???
while (i<N) {
if (v[i] < r) r = v[i];
i=i+1;
}
// pos: (forall_{0 <= k < N} r <= v[k]) &&
// (exists_{0 <= p < N} r == v[p])
return r;
}
```
R.: `(exists_{0 <= r < i} r == v[p]) && (forall_{0 <= k < i} v[r] <= v[i])`  

(c) Soma dos elementos de um array.
```c
int soma (int v[], int N) {
// pre: N>0
int i = 0, r = 0;
// inv: ???
while (i<N) {
r = r + v[i]; i=i+1;
}
// pos: r == sum_{0 <= k < N} v[k]
return r;
}
```
R.: `r == sum_{0 <= k < i} v[k]`  

(d) Quadrado de um número inteiro positivo.
```c
int quadrado1 (int x) {
// pre: x>=0
int a = x, b = x, r = 0;
// inv: ??
while (a!=0) {
if (a%2 != 0) r = r + b;
a=a/2; b=b*2;
}
// pos: r == x^2
return r;
}
```
R.: `a * b + r = x^2`  

(e)  Quadrado de um número inteiro positivo.
```c
int quadrado2 (int x){
// pre: x>=0
int r = 0, i = 0, p = 1;
// inv: ??
while (i<x) {
i = i+1; r = r+p; p = p+2;
}
// pos: r == x^2
return r;
}
```
R.: `r == i^2`  

(f) Tamanho do maior prefixo ordenado de um array.
```c
int maxPOrd (int v[], int N){
// pre: ??
int r = 1;
// inv: ??
while (r < N && v[r-1] <= v[r])
r = r+1;
// pos: ??
return r;
}
```
R.: `forall_{1 <= i < r} v[i-1] < v[i]`  

(g) Procura de um elemento num array.
```c
int procura (int x, int a[], int N){
// pre: N>0
int p = -1, i = 0;
// inv: ??
while (p == -1 && i < N) {
if (a[i] == x) p = i;
i = i+1;
}
// pos: (p == -1 && forall_{0 <= k < N} a[k] != x) ||
// ( (0 <= p < N ) && x == a[p])
return p;
}
```
R.: `(p == -1 && forall_{0 <= k < i} a[k] != x) || ((0 <= p < i) && x == a[p])`  
e talvez este `(p == -1 && forall_{0 <= k < i} a[k] != x) || (p == i-1 && x == a[p])`  

(h) Soma dos primeiros números inteiros.
```c
int triangulo1 (int n){
// pre: n>=0
int r=0, i=1;
// inv: ??
while (i<=n) {
r = r+i; i = i+1;
}
// pos: r == n * (n+1) / 2;
return r;
}
```
R.: `r == (i-1) * i / 2`  

(i) Soma dos primeiros números inteiros.
```c
int triangulo2 (int n){
// pre: n>=0
int r=0, i=n;
// inv: ??
while (i>0) {
r = r+i; i = i-1;
}
// pos: r == n * (n+1) / 2;
return r;
}
```
R.: `n * (n+1) / 2 == (i * (i+1) / 2) + r`  

(j) Resto da divisão inteira.
```c
int mod (int x, int y) {
// pre: x>=0 && y>0
int r = x;
while (y <= r) {
r = r-y;
}
// pos: 0 <= r < y && exists_{q} x == q*y + r
return r;
}
``` 
R.: `exists_{q} x == q*y + r`  

(k) Valor de um polinómio num ponto.
```c
float valor1 (float x, float coef[], int N){
// pre: N >= 0
float r=0; int i=0;
// inv: ??
while (i<N){
r = r + pow(x,i) * coef[i];
i = i+1;
}
// pos: r = sum_{0<=k<N} x^k * coef[k]
return r;
}
```
R.: `r == sum_{0 <= k < i} x^k * coef[k]`  

(l) Valor de um polinómio num ponto.
```c
float valor2 (float x, float coef[], int N){
// pre: N >= 0
float r=0; int i=N;
// inv: ??
while (i>0){
i = i-1;
r = (r * x) + coef[i];
}
// pos: r = sum_{0<=k<N} x^k * coef[k]
return r;
}
``` 
R.: `r == sum_{i <= k < N} x^k * coef[k]`  

## 3. Para cada uma das funções da alínea anterior, indique um variante de ciclo que lhe permita provar a correção total

a) `N-i`  

b) `N-i`  

c) `N-i`  

d) `a`

e) `x-i`  

f) `N-r`  

g) `N-i`  

h) `n-i+1`  

i) `i`  

j) `r - (x % y)`

k) `N-i`  

l) `i` 
