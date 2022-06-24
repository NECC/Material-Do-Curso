# 1 Contagem
## 1. Para cada uma das funções de ordenação abaixo 

• Identifique o melhor e pior casos em termos do número de comparações entre elementos do array e em termos do número de trocas efectuadas.

• Calcule o número de comparações entre elementos do array efectuadas nesses casos identificados.

(a) 
```c
void bubbleSort (int v[], int N){
int i, j;
for (i=N-1; i>0; i--)
for (j=0; j<i; j++)
if (v[j] > v[j+1]) swap (v,j,j+1);
}
```
R.:
**Melhor caso:** array ordenado  
**Pior caso:** array com ordem invertida  
**Nº comparações =** sum_{0 < i < N} i 
    
(b) 
```c
void iSort (int v[], int N){
int i, j;
for (i=1; i<N; i++)
for (j=i; j>0 && v[j-1] > v[j]; j--)
swap (v,j,j-1);
}
```
R.: 
**Melhor caso:** array ordenado  
**Pior caso:** array com ordem invertida  
**Nº comparações melhor caso =** sum_{0 < i < N} 1  
**Nº comparações pior caso =** sum_{0 < i < N} i 
    
## 2. Considere as seguintes definições de funções (já estudadas na Ficha 1) que calculam o produto de dois números inteiros não negativos.
```c
int mult1 (int x, int y){            |     int mult2 (int x, int y){
// pre: x>=0                         |     // pre: x>=0
int a=x, b=y, r=0;                   |     int a=x, b=y, r=0;
while (a>0){                         |     while (a>0) {
r = r+b; a = a-1;                    |     if (a%2 == 1) r = r+b;
}                                    |     a=a/2; b=b*2;
// pos: r == x * y                   |     }
return r;                            |     // pos: r == x * y
}                                    |     return r;
                                     |     }
```
Para cada uma destas funções efectue uma contagem do número de vezes que as operações primitivas1(+ - \*2 /2 %2) contidas no corpo do ciclo são executadas no pior caso. Considere que o tamanho do input é o número de bits necessários para representar os números inteiros passados como argumento. Recorde que, por exemplo, os números cuja representação requer 5 bits são {16, . . . , 31}.

R.: 
**Nº comparações =** 2 * x  
**Melhor caso** é ter 2^(n-1)  
**Pior caso** é ter 2^n-1

**Nº comparações =** 3 * (log_2(x) + 1) + nº de ocorrências de ímpares  
**Melhor caso** é ter `100...0`  
**Pior caso** é ter `111...1`  

## 3. Considere a seguinte definição de uma função que calcula a maior soma de um segmento de um array de inteiros.
```c
int maxSoma (int v[], int N) {            |     int soma (int v[], int a, int b) {
int i, j, r=0, m;                         |     int r = 0, i;
for (i=0; i<N; i++)                       |     for (i=a; i<=b; i++)
for (j=i; j<N; j++) {                     |     r=r+v[i];
m = soma(v,i,j);                          |     return r;
if (m>r) r = m;                           |     }
}                                         |     
return r;                                 |     
}                                         |     
```
(a) Determine a complexidade da função maxSoma em termos do número de acessos ao array argumento.

R.: sum_{0 < i < N} sum_{i <= j < N} j-i+1 

(b) Uma forma alternativa de resolver este problema consiste em usar um array auxiliar c com N elementos, que será preenchido de acordo com a seguinte propriedade o elemento c[i] contem a maior soma de um segmento do array que termina (e inclui) v[i]. Implemente esta estratégia e compare a complexidade desta solução com a da função apresentada.

```c
int maxSoma (int v[], int N) {
  int i, j, r, m, c[N];
  c[0] = v[0];
  r = c[0]
  for (i = 1; i<N; i++)
    c[i] = (c[i-1] + v[i] > v[i]) ? c[i-1] + v[i] : v[i];
  for (i = 1; i<N; i++)
    if (c[i] > r) r = c[i];
  return r;
}
```
## 4. Considere a seguinte função que calcula o comprimento do maior segmento crescente de uma array de inteiros.
```c
int crescente (int v[], int N) {            |     int maxcresc (int v[], int N) {
  int i;                                    |       int r = 1, i = 0, m;
  for (i=1; i<N; i++)                       |       while (i<N-1) {
    if (v[i] < v[i-1]) break;               |         m = crescente (v+i, N-i);
  return i;                                 |         if (m>r) m = r;
}                                           |       i++;
                                            |       }
                                            |       return r;
                                            |     }
```
Identifique o melhor e pior caso da função maxcresc em termos do número de comparações entre elementos do array argumento. Calcule ainda esse número para o pior caso identificado. Note que as operações \*2, /2 e %2 se podem escrever como >>1, <<1 e &1.

R.:
**Melhor caso:** array por ordem decrescente  
**Pior caso:** array por ordem crescente  
**Nº =** comprimento dos segmentos crescentes

# 2 Definições Recursivas
## 1. Utilize uma árvore de recorrência para encontrar limites superiores para o tempo de execução dados pelas seguintes recorrências (assuma que para todas elas T(0) é uma constante):

(a) T(n) = k + T(n − 1) com k constante

R.: 
Temos que uma árvore com este tempo de execução, será do tipo:
```
T(N) - k
|
T(N-1) - k
| 
...
|
T(1) - k
|
T(0) - K'
```
sum_{0 <= i < n} k + k'; O(n)

(b) T(n) = k + T(n/2) com k constante

R.:
Temos que uma árvore com este tempo de execução, será do tipo:
```
T(N) - k
|
T(N/2) - k
| 
...
|
T(1) - k
|
T(0) - K'
```
sum_{0 <= i < log_2(n)} k + k'; O(log_2(n))

(c) T(n) = k + 2 ∗ T(n/2) com k constante

R.: 
Temos que uma árvore com este tempo de execução, será do tipo:
```
           T(N) - k
         /    \
     k-T(N/2)  T(N/2) - k
        /\       /\
        ...     ...
       / 
      T(1) - k
      / 
     T(0) - K'
```
(sum_{0 <= i < log_2(n)} 2^i) * k + 2^(log_2(n)) * k'; O(n)  

(d) T(n) = n + T(n − 1)

R.:
Temos que uma árvore com este tempo de execução, será do tipo:
```
T(N) - N
|
T(N-1) - N-1
| 
...
|
T(1) - 1
|
T(0) - K'
```
sum_{0 <= i < n} n + k' = (n^2)/2 + n/2 + k'; O(n^2)  

(e) T(n) = n + T(n/2)

R.:
Temos que uma árvore com este tempo de execução, será do tipo:
```
T(N) - N
|
T(N/2) - N/2
| 
...
|
T(1) - 1
|
T(0) - K'
```
(sum_{0 <= i < log_2(n)} n/2^i) + k' = 2n - 1; O(n)  

(f) T(n) = n + 2 ∗ T(n/2)

R.: 
Temos que uma árvore com este tempo de execução, será do tipo:
```
           T(N) - N
         /    \
     N/2-T(N/2)  T(N/2) - N/2
        /\       /\
        ...     ...
       / 
      T(1) - 1
      / 
     T(0) - K'
```     
(sum_{0 <= i < log_2(n)} n/2^i) + 2^(log_2(n)+1) * k'; O(n * log_2(n))  

## 2. Exprima a complexidade da função maxSomaR (em termos do número de acessos ao array argumento) como uma recorrência.
```c
int maxSomaR (int v[], int N) {
  int r=0, m1, m2, i;
  if (N>0) {
    m1 = m2 = v[0];
    for (i=1; i<N; i++) {
      m2 = m2+v[i];
      if (m2>m1) m1=m2;
    }
    m2 = maxSomaR (v+1,N-1);
    if (m1>m2) r = m1; else r = m2;
  }
  return r;
}
```
R.: 
T(0) = 0  
T(n) = n + T(n-1)  
n^2/2 + n/2

## 3. Considere o seguinte algoritmo para o problema das Torres de Hanoi:
```c
void Hanoi(int nDiscos, int esquerda, int direita, int meio)
{
  if (nDiscos > 0) {
    Hanoi(nDiscos-1, esquerda, meio, direita);
    printf("mover disco de %d para %d\n", esquerda, direita);
    Hanoi(nDiscos-1, meio, direita, esquerda);
  }
}
```
Escreva uma relação de recorrência que exprima a complexidade deste algoritmo (por exemplo, em função do número de linhasimpressas). Desenhe a árvore de recursão do algoritmo e obtenha a partir dessa árvore um resultado sobre a sua complexidade assimptótica.

R.:  Assim sendo, a árvore de recursão do algoritmo é:
```
        T(N) - 1
         /    \
     1-T(N-1)  T(N-1) - 1
        /\       /\
        ...     ...
       / 
      T(1) - 1
      / 
     T(0) - 0
```

T(0) = 0  
T(n) = k + 2 * T(n-1)  
sum_{0 <= i < n} 2^i = 2^n -1 

## 4. Considere a seguinte definição da função que ordena um vector usando o algoritmo de merge sort.
```c
void msort (int v[], int N) {
  int m = N/2;
  if (N>1) {
    msort (v, m); msort (v+m, N-m);
    mergeH (v, N);
  }
}
```
Considere que a função int mergeH (int a[], int N) executa em tempo Tmerge(N) = 2∗N. Apresente uma relação de recorrência que traduza o tempo de execução de msort em função do tamanho do vector argumento. Apresente ainda uma solução dessa recorrência.

R.:
T(1) = k  
T(n) = k' + 2 * n + 2 * T(n/2)  
T(n) = 2n + 2(2(n/2) + 2T(n/4)) = 2n + 2(n + 2T(n/4)) = 2n + 2n + 4T(n/4)  
Vamos ter log_2(n) parcelas, cada uma delas com o valor 2n logo será log_2(n) * 2n  
O(n * log_2(n))  

## 5. Considere a definição da função altura sobre árvores binárias Descreva a sua complexidade com uma recorrência, considerando duas configurações extremas de árvores:

(1) árvores equilibradas (os elementos estão distribuidos uniformemente pelas duas sub-
árvores) ou (2) árvores ”lista” (em que cada nodo tem pelo menos uma das sub-árvores
vazias).
```c
int altura (ABin a){
  int r=0;
  if (a!=NULL)
    r = 1 + max (altura (a->esq),
    altura (a->dir));
  return r;
}
```
R.:

**1º Caso:** T(0) = k  
T(n) = k' + 2 * T(n/2)  

**2º Caso:** T(0) = k  
T(n) = k' + T(n-1) + T(0) 

# 3 Análise de caso médio
## 1. Relembre a função crescente definida acima.
```c
int crescente (int v[], int N) {
  int i;
  for (i=1; i<N; i++)
    if (v[i] < v[i-1]) break;
  return i;
}
```
Considerando que os valores do array são perfeitamente aleatórios e por isso, para qualquer índice i, a probabilidade de a posição i conter um valor menor do que a posição i-1 é 0.5. Calcule o número médio de comparações efectuadas por esta função. Com base no resultado obtido, calcule o custo médio da função maxcresc apresentada na Secção 1.

R.: **Nº médio de comparações =** (N-1) * (1/2)^(N-1) + sum_{0 < i < N} i * (1/2)^i

**maxcresc =** sum_{0 <= i <= N-2} 2 - 1/(2^(N-i-2)

## 2. Com as mesmas considerações feitas na alínea anterior, num array aleatório v, e para cada posição i, em média, metade dos elementos de v entre as posições 0 e i são maiores do que v[i]. Com base neste facto, faça a análise de tempo médio da função iSort apresentada na Secção 1.

## 3. Considere a função intcmp que recebe como argumento dois arrays de N bits (representando dois inteiros) e compara os valores representados. Note que a função cmp é a mesma função, com os inteiros x e y representados da forma habitual.
```c
int intcmp (int x[], int y[], int N){
  for (i=N-1;i>=0 && x[i] == y[i];i--);
  if (i==0) return 0;
  else return (x[i] - y[i]);
}

int cmp (unsigned x, unsigned y) {
    while (x!=0 && y!=0 && x&1 == y&1){
      x=x>1; y=y>1;
    }
    if (x==0 && y==0) return 0;
    else return (x&1 - y&1);
}
```
Assumindo que a probabilidade de dois bits aleatórios serem iguais é 0.5, determine o custo médio (número de comparações entre elementos dos arrays) desta função.

R.: N * (1/2)^N + sum_{1 <= i <= N} i * (1/2)^i

## 4. Considere a seguinte definição da função inc que recebe um array de N bits (representando um inteiro x) e que modifica o array de forma a representar x+1.
```c
int inc (int x[], int N){
  int i=N-1;
  while (i>=0 && x[i] == 1)
    x[i--] = 0;
    if (i<0) return 1;
    x[i] = 1;
return 0;
}
```
Calcule o custo médio desta função (em termos do número de bit alterados).

R.: N * (1/2)^N + sum_{1 <= i <= N} i * (1/2)^i

## 5. Relembre o algoritmo de procura numa árvore binária de procura.
```c
int elem (int x, ABin a){
while (a != NULL && a->valor != x)
if (x < a->valor) a = a->esq;
else a = a->dir;
return (a!=NULL);
}
```
Analise a complexidade média (em termos de número de nodos consultados) desta função, assumindo que o elemento que se procura existe com igual probabilidade em cada posição da árvore. Faça esta análise para duas configurações extremas de árvores: (1) árvores equilibradas (os elementos estão distribuidos uniformemente pelas duas sub-árvores) ou (2) árvores ”lista” (em que cada nodo tem pelo menos uma das sub-árvores vazias).

R.:

**Árvores equilibradas:** sum_{0 <= i <= log_2(N)} 2^i * 1/N

**Árvores ”lista”:** sum_{0 < i <= N} i * (1/N)^i

# 4 Análise amortizada
## 1. Uma implementação possível de uma fila de espera (Queue) utiliza duas stacks A e B, por exemplo:
```c
typedef struct queue {
Stack a;
Stack b;
} Queue;
```
• A inserção (enqueue) de elementos é sempre realizada na stack A;

• para a remoção (dequeue), se a stack B não estiver vazia, é efectuado um pop nessa stack; caso contrário, para todos os elementos de A excepto o último, faz-se sucessivamente pop e push na stack B. Faz-se depois pop do último, que é devolvido como resultado.

(a) Efectue a análise do tempo de execução no melhor e no pior caso das funções enqueue e dequeue, assumindo que todas as operações das stacks são realizadas em tempo constante.

R.:
**Enqueue:**

**Melhor Caso:** A stack A não tem nenhum elemento para inserir, T(n) = 1 ou T(n) = k

**Pior:** Tem de se adicionar toda a stack A, T(n) = N

**Dequeue:**

**Melhor Caso:** A stack A não tem nenhum elemento, T(n) = 1

**Pior:** A stack A está cheia e temos de de fazer pop e push na stack B mas apenas tem custo o push, T(n) = N

(b) Mostre que o custo amortizado de cada uma das operações de enqueue ou dequeue numa sequência de N operações é O(1) usando o método do potencial.

Seja Φ (s) o dobro do número de elementos em S1.

Φ (s0) = 0 e Φ (st) ≥ 0 para todos os estados st conforme necessário Um equeue terá um custo real de 1 (push para S1) mais um aumento de 2 no potencial, resultando num custo amortizado de 3.

Um dequeue terá no mínimo um custo real de 2 (vazio + sair da S2). No caso de S2 estar vazio e x for o número de elementos em S1, temos de fazer pop de S1 x vezes fazendo push para S2 x vezes (tendo um custo real de 2x), mas isto será cancelado pela redução no potencial de precisamente 2x. O custo amortizado é 2.

Levando-nos a ter um custo amortizado constante!

(Mais info aqui: https://www.dcc.fc.up.pt/~pribeiro/aulas/alg1819/slides/3_amortized_08102018.pdf)

## 2. Considere-se uma estrutura de dados do tipo stack com a habitual operação ‘push‘, mas em que a operação ‘pop‘ é substituída por uma operação ‘multipop‘, uma generalização que remove os k primeiros elementos, deixando a pilha vazia caso contenha menos de k elementos. Uma implementação possível será
```c
void multiPop(S,k) {
     while (!IsEmpty(S) && k != 0) {
           pop(S);
           k -= 1;
     }
}
```
Pela análise tradicional de pior caso,

• ‘push‘ executa em tempo O(1)

• ‘multiPop‘ executa em tempo O(N)

Utilize um dos métodos estudados, para mostrar que em termos amortizados a operação ‘multiPop‘ executa também ela em tempo constante O(1).

R.: Consideremos o método do potencial e, ainda, que O(s) corresponde ao dobro do número de elementos existentes na stack. Temos que O(s0)=0 e O(st)>=0 para todos os estados st.
Temos que, se a stack estiver vazia, tem um custo de 1(não é necessário fazer pop). Mas no caso, em que existem x elementos, é necessário fazer um 1 multiPop(S,x), o que corresponde a fazer x vezes a instrução pop, o que dá  um custo de x. Mas considerando a diminuição do potencial em x, ficamos com um custo amortizado de 1. Logo executa em tempo constante. 

## 3. Considere um algoritmo de inserção ordenada numa lista (crescente), com uma particularidade: são apagados os nós iniciais da lista contendo valores inferiores ao que está a ser inserido. Por exemplo, a inserção de 30 na lista [10, 20, 40, 50] resulta na lista [30, 40, 50]. A função seguinte implementa este algoritmo em C.
```c
node *insert_rem (node *p, int x) {
     node *new = malloc(sizeof(node)); new->value = x;
     while (p && x > p->value)
     { 
      aux = p; 
      p = p->next; 
      free (aux); 
     }
     new->next = p;
     return new;
}
```
(a) Analise o tempo de execução assimptótico de ‘insert rem‘, identificando o pior e o melhor caso.

R.:

**Melhor caso:** Quando temos que todos os elementos da lista, são maiores que o valor de x. Ou seja, não é necessário apagar os elementos, basta apenas fazer a inserção. T(N)=1

**Pior Caso:** Quando todos os elementos da lista, são menores que x. Ou seja, é necessário apagar todos os elementos e só depois adicionar o x. T(N)=N

(b) Em termos amortizados a operação de inserção da questão anterior executa em tempo constante. Efectue a sua análise agregada considerando a sequência de inserções 20, 70, 60, 30, 40, 50, 10, 80 (partindo de uma lista vazia). Considere que o custo real de cada inserção/remoção efectuada à cabeça da lista é 1, por isso a inserção de 30 na lista [10, 20, 40, 50] tem custo 3. Apresente ainda uma função de potencial apropriada sobre as listas, e calcule a partir dela o custo amortizado constante desta operação ‘insert rem‘.

R.:

Queremos analisar o custo agregado de inserir 20,70,60,30,40,50,10,80.

Temos que inicialmente a stack está vazia. Ou seja, 
     
     -> Podemos fazer logo a inserção de 20. Logo, T(N)=1.
     
     -> Inserção do 70 (Apagar o 20 e inserir 70) T(N)=2
     
     -> Inserção do 60 (Como 70 é maior do 60, é apenas necessário inserir o 60) T(N)=1
     
     -> Inserção do 30 T(N)=1
     
     -> Inserção do 40 (Apagar o 30 e inserir o 40)  T(N)=2
     
     -> Inserção do 50 (Apagar o 40 e inserir o 50) T(N)=2
     
     -> Inserção do 10 (Inserir apenas o 10) T(N)=1
     
     -> Inserção do 80 (Temos que apagar tudo, ou seja, o 10,50,60,70 e inserir o 80) T(N)=5
     
Temos que o custo agragado é dado por: 1/n\* sum(i=0 to n) ci = 1/8 \*(1+2+1+1+2+2+1+5)=1/8 \* 15 = 2.

Logo, todas operações acima têm custo agregado de 2.
