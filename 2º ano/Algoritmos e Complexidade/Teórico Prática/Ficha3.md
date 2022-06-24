```c
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
```
# 1. Min-heaps

Uma min-heap é uma árvore binária em que cada nodo é menor ou igual a todos os seus sucessores.
Por outro lado, uma árvore diz-se semi-completa se todos os níveis da árvore estão completos, com a possível excepção 
do último, que pode estar parcialmente preenchido (da esquerda para a direita).
As árvores semi-completas têm uma representação ”económica” em array: os nodos são armazenados por nível, sempre da esquerda 
para a direita.

Por exemplo, a árvore (que é uma min-heap)

                   10    
              /           \       
            15             11
           /   \         /   \
         16     22     35     20
         /\     /\     /\     /\
       21  23 34  37 80  43 22  25
       /\
     24  28

pode ser armazenada no array (de tamanho 17)

0 : 10 | 1 : 15 | 2 : 11 | 3 : 16 | 4 : 22 | 5 : 35 | 6 : 20 | 7 : 21 | 8 : 23 | 

9 : 34 | 10 : 37 | 11 : 80 | 12 : 43 | 13 : 22 | 14 : 25 | 15 : 24 | 16 : 28 |

Nota: posArray : folha

O índice onde se encontra a sub-árvore esquerda do nodo da posição i.

R.: Todas as sub-árvores esquerdas encontram-se em posições ímpares logo fica 2 x i + 1.  

(b) O índice onde se encontra a sub-árvore direita do nodo da posição i.

R.: Todas as sub-árvores direitas encontram-se em posições pares logo fica 2 x i + 2.

(c) O índice onde se encontra o pai do nodo da posição i.

R.: Os pais de todo o nodo encontram-se nas posições dadas por (i-1) / 2

(d) O índice onde se encontra a primeira folha, i.e., o primeiro nodo que não tem
sucessores.

R.: Temos de ir ao pai do nodo e descer até à sua folha, ou seja pai(i) + (i + 1) e pai(i) + (i + 2) 

## 2. Defina a função void bubbleUp (int i, int h[]) que (por sucessivas trocas com o pai) puxa o elemento que está na posição i da min-heap h até que satisfaça a propriedade das min-heaps. Identifique o pior caso desta função e calcule o número de comparações/trocas efectuadas nesse caso.
```c
void swap(int *ar, int i, int j)
{
    int temp = ar[i];
    ar[i] = ar[j];
    ar[j] = temp;
}

void bubbleUp(int i, int h[])
{
    while (i > 0 && h[i] > h[(i - 1) / 2])
        swap(h, i, (i - 1) / 2), i = (i - 1) / 2;
}
```
Pior Caso: O i é o maior valor e temos de comparar todos os pais dos nodos, tendo complexidade T(N) = N.

## 3. Defina a função void bubbleDown (int i, int h[], int N) que (por sucessivas trocas com um dos filhos) empura o elemento que está na posição i da min-heap h até que satisfaça a propriedade das min-heaps. Identifique o pior caso desta função e calcule o número de comparações/trocas efectuadas nesse caso.
```c
void bubbleDown1(int i, int h[], int N)
{
    int p, control = 1;
    while ((2 * i + 2) < N && control)
    {

        if (h[2 * i + 1] > h[2 * i + 2])
            p = h[2 * i + 1];
        else
            p = h[2 * i + 2];

        if (h[i] > h[p])
            swap(h, i, p), i = p;
        else
            control = 0;
    }
    if ((2 * i + 1) < N && h[2 * i + 1] < h[i])
        swap(h, i, 2 * i + 1);
}

//Or

#define LEFT(i) 2 * i + 1
#define RIGHT(i) 2 * i + 2

void bubbleDown2(int i, int h[], int N)
{
    int p;
    while (LEFT(i) < N)
    {
        p = (RIGHT(i) < N && h[RIGHT(i)] < h[LEFT(i)]) ? RIGHT(i) : LEFT(i);

        if (h[p] > h[i])
            break;

        swap(h, i, p);
        i = p;
    }
}
```
Pior Caso: O i implica que todos os filhos da heap sejam reorganizados, tendo complexidade T(N) = N + 1 = N.

## 4. Considere agora o problema de implementar uma fila com prioridades, i.e., uma fila em que o próximo elemento a retirar da fila é o menor que lá estiver. Uma possível implementação desta estrutura de dados consiste em usar uma min-heap.
```c
#define Max 100

typedef struct pQueue
{
    int valores[Max];
    int tamanho;
} PriorityQueue;
```

Apresente as definições das operações habituais sobre este género de tipos (buffers).

void empty (PriorityQueue \*q) que inicializa q com a fila vazia.
```c
void empty (PriorityQueue *q){
    q->tamanho = 0;
}
```

int isEmpty (PriorityQueue \*q) que testa se está vazia.
```c
int isEmpty(PriorityQueue *q)
{
    if (q->tamanho == 0)
        return 1;
    return 0;
}
```

int add (int x, PriorityQueue \*q) que adiciona um elemento à fila (retornando 0 se a operação for possível).
```c
int add(int x, PriorityQueue *q)
{
    if (q->tamanho == Max)
        return 1;
    q->valores[q->tamanho] = x;
    bubbleUp(q->tamanho, q->valores);
    q->tamanho++;
    return 0;
}
```

int remove (PriorityQueue \*q, int *rem) que remove o próximo elemento
(devolvendo-o em *rem) e retornando 0 se a operação for possível.
```c
int remove(PriorityQueue *q, int *rem)
{
    if (q->tamanho == 0)
        return 1;
    rem = &q->valores[0];
    q->valores[0] = q->valores[q->tamanho - 1];
    q->tamanho--;
    bubbleDown2(0, q->valores, q->tamanho);
    return 0;
}

// Para testes:

void init(PriorityQueue *q)
{
    *q->valores = calloc(5, sizeof(struct pQueue));
    q->tamanho = 5;
}

void printMinHeap(PriorityQueue *q)
{
    for (int i = 0; i < q->tamanho; i++)
        print("Val[%d] = %d\n", i, q->valores[i]);
    print("\n");
}

int main()
{
    PriorityQueue q;
    init(&q);
    printf("Inicialização:\n");
    printMinHeap(&q);
    add(20, &q);
    add(23, &q);
    add(2, &q);
    add(12, &q);
    add(32, &q);
    printf("Depois de adição:\n");
    printMinHeap(&q);
    int a = 2;
    remover(&q, &a);
    printf("Depois de remover:\n");
    printMinHeap(&q);
    return 0;
}
```

## 5. A operação void heapify (int v[], int N) consiste em obter uma permutação do array que seja uma min-heap.

Duas estratégias para implementar esta função são:

top-down: Assumindo que as primeiras p posições do array constituem uma min-heap (de tamanho p) efectuar a invocação 
bubbleUp (p, v, N) de forma a obtermos uma min-heap de tamanho p+1.

bottom-up: Para cada nodo da árvore, desde o mais profundo até à raiz, aplicar a função bubbleDown. Note-se que a invocação 
para as folhas é desnecessária, uma vez que não têm sucessores.

Implemente a função heapify usando estas duas estratégias. Para cada uma delas, identifique a complexidade dessa função no 
caso em que o array original está ordenado por ordem decrescente.
```c
void heapifyUp(int v[], int N){
  for(int i=1; i<N; i++)
      bubbleUp(i, v);
}

void heapifyDown(int v[], int N){
  for(int i = (N-1)/2; i>=0 ; i--)
      bubbleDown1(i, v, N);
}
```
## 6. Defina uma função void ordenaHeap (int h[], int N) que, usando a função bubbleDown definida acima, transforma a min-heap h, num array ordenado por ordem decrescente.
```c
void ordenaHeap (int h[], int N){
  for (int i = 1; i < N; i++)
      {
      swap(h, 0, N-i);
      bubbleDown(i, h, N-i);
      }
}
```

## 7. Considere o problema de ler uma sequência de N números e seleccionar os k maiores, com k < N, (tipicamente, k muito menor do que N). Uma solução possível consiste em começar por ler os k primeiros elementos e organizálos numa min-heap. Para cada um dos N−k seguintes, caso seja maior do que o menor dos números organizados, insere-se esse elemento na min-heap, removendo o menos dos que lá estão. Analise o custo desta solução (no pior caso) comparando-o com outra solução alternativa de, por exemplo, armazenar os k maiores números lidos numa lista ligada ordenada por ordem crescente. 

R.: Assumindo `add = O(log(N))` e `remove = O(log(N))`, o pior caso seria dar os elemento de forma crescente. Sendo assim efetuados N add's e (N-k) remove's.  
`O(N*log(k) + (N-k)*log(k)) = O(N*log(k))`

No caso de uma lista ligada a inserção na cauda seria `O(k)` e a remoção da cabeça seria `O(1)`, o pior caso seria dar os elemento de forma crescente. Sendo assim efetuados N insert's e (N-k) remove's.  
`O(N*k + (N-k)) = O(N*k)`  

# 2 Tabelas de Hash

Nos exercícios seguintes pretende-se usar uma tabela de Hash para implementar multi-conjuntos de strings. Para cada string deve 
ser guardado o número de vezes que ela ocorre no multiconjunto. As operações em causa são por isso:

• inicialização de um multi-conjunto a vazio

• adição de um elemento a um multi-conjunto

• teste de pertença (saber qual a multplicidade de um elemento num multi-conjunto)

• remoção de uma ocorrência de um elemento de um multi-conjunto

Vamos por isso assumir a existência de uma funçãoo unsigned hash (char *chave), como
por exemplo a seguinte (http:www.cse.yorku.ca/~oz/hash.html)
```c
unsigned hash(char *str)
{
    unsigned hash = 5381;
    int c;
    while (c = *str++)
        hash = ((hash << 5) + hash) + c; /* hash * 33 + c */
    return hash;
}
```

# 2.1 Chaining
Vamos usar o seguinte tipo.
```c
#define Size 11

typedef struct nodo
{
    char *chave;
    int ocorr;
    struct nodo *prox;
} Nodo, *THash[Size];
```

Defina as funções
## 1. void initEmpty (THash t) que inicializa um multi-conjunto a vazio
```c
void initEmpty (THash t){
    int i;
    for(i = 0; i < Size; i++){
        t[i] = malloc(sizeof(struct nodo));
        if(t[i] == NULL){ printf("Oh no something is wrong :(\n"); break;}
        t[i] -> chave = "";
        t[i] -> ocorr = 0;
        t[i] -> prox = NULL;
    }
}
```

## 2. void add (char \*s, THash t) que regista mais uma ocorrência de um elemento a um multi-conjunto
```c
void addHash (char *s, THash t){
     unsigned p = hash(s);
     Nodo* ant = NULL;
     Nodo* ptr = NULL;
     for(ptr = t[p]; ptr != NULL; ptr = t[p]->prox){
       if(strcmp(ptr->chave,s)){
          ptr->ocorr++;
          return;
       }
       ant = ptr;
     }
     //Não encontrar um igual
     ptr = calloc(sizeof(Nodo));
     strcpy(ptr->chave,s);
     ptr->ocorr = 1;
     ptr ->prox = NULL;
     if(ant != NULL) ant->prox = ptr;
     else t[p] = ptr;
}
```

## 3. int lookup (char \*s, THash t) que calcula a multiplicidade de um elemento num multi-conjunto
```c
int lookup (char *s, THash t){
    unsigned p = hash(s);
    for(Nodo* ptr = t[p]; ptr != NULL ; ptr = t[p]->prox){
      if(strcmp(ptr->chave,s)) return ptr->ocorr; 
    }
    return 0;
}
```

## 4. int remove (char \*s, THash t) que remove uma ocorrência de um elemento de um multi-conjunto.
```c
int removeHash (char *s, THash t){
    unsigned p = hash(s);
    Nodo* ptr;
    Nodo* ant;
    for(ptr = t[p]; strcmp(ptr->chave,s); ptr = t[p]->prox){
      if(ptr == NULL){
        return -1;
      }
      ant = ptr;
    }
    if(ptr->ocorr == 0){
      if(ant != NULL){
        ant->prox = ptr->prox;
      }else{
        t[p] = ptr->prox;
      }
      free(ptr);
    }
    return 0;
}
```

Para testes
```c
void display(THash t){
  for (int i = 0; i < Size; i++) printf("key: %s pos: %d ocorr: %d \n", t[i]->chave, i, t[i]->ocorr);
  printf("\n");
}

int main(){
    THash t;
    initEmpty(t);
    printf("Inicialização:\n");
    display(t);
    addHash("Madara",t);
    addHash("Nami",t);
    addHash("Boruto",t);
    addHash("Luffy",t);
    addHash("Naruto",t);
    addHash("Sanji",t);
    addHash("Sasuke",t);
    addHash("Zoro",t);
    addHash("Sakura",t);
    addHash("Usopp",t);
    addHash("Kakashi",t); //Colisão possivel
    printf("Depois da inserção:\n");
    display(t);
    int r1 = lookup("Kakashi",t);
    printf("Resultado do LookUp: %d\n", r1);
    int r2 = lookup("Zoro",t);
    printf("Resultado do LookUp: %d\n\n", r2);
    remove("Madara",t);
    remove("Franky",t);
    printf("Depois de remover:\n");
    display(t);
	  return 0;
}
```
# 2.2 Open Addressing
Vamos usar o seguinte tipo.

```c
#define Size 11
#define Free 0
#define Used 1
#define Del 2

typedef struct bucket {
    int status;  // Free | Used | Del
    char *chave; int ocorr;
} THash [Size];
```

## 1. Comece por definir a função int where (char \*s, THash t) que calcula o índice de t onde s está (ou devia estar) armazenada.
```c
int where (char *s, THash t){
    int c, hash = 5381;
    while (c == *s++)
        hash *= 33 + c;
    return hash % Size;
}
```
## 2. Defina as funções usuais sobre multi-conjuntos:

(a) void initEmpty (THash t) que inicializa um multi-conjunto a vazio
```c
void initEmpty (THash t){
  for(int i = 0; i < Size ; i++){
    t[i].status = Free;
    t[i].chave = NULL;
    t[i].ocorr = 0;
  }
}
```
(b) void add (char \*s, THash t) que regista mais uma ocorrência de um elemento
a um multi-conjunto
```c
void add (char *s, THash t){
  int p, i, pos = where(s,t);
  for(i = 0; t[pos].status > Free && i < Size; i++, pos = i % Size){
    if(strcmp(t[i].chave,s)){
      t[i].ocorr++; 
      return;
    }
  }
  if(t[pos].status == Free){
    t[pos].status = Used;
    strcpy(t[i].chave, s);
    t[pos].ocorr = 1;
  }else{
    printf("Something went wrong the table is full\n");
  }
}
```
(c) int lookup (char \*s, THash t) que calcula a multiplicidade de um elemento
num multi-conjunto
```c
int lookup (char *s, THash t){
  int i, pos = where(s,t);
  for(i=0; t[pos].status != Free && i < Size; i++, pos = i % Size){
    if(strcmp(t[pos].chave,s))
    return t[pos].ocorr;
  }
  return -1;
}
```
(d) int remove (char \*s, THash t) que remove uma ocorrência de um elemento de
um multi-conjunto.
```c
int remover (char *s, THash t){
  int i, pos = where(s,t);
  for(i=0; strcmp(t[pos].chave,s) ; i++, pos = i%Size){
    if(t[pos].status == Free || i == Size){
      return -1;
    }
  }
  t[pos].ocorr--;
  if(t[pos].ocorr == 0){
    t[pos].status = Del;
    t[pos].chave = NULL;
  }
  return 0;
}
```

Para testes
```c
void display(THash t){
  for(int i = 0; i<Size;i++){
    printf("Status: %d Chave: %s Ocorr: %d\n", t[i].status, t[i].chave, t[i].ocorr);
  }
  printf("\n");
}

int main(){
	THash t;
  initEmpty(t);
  printf("Inicialização:\n");
  display(t);
  add("Madara",t);
  add("Nami",t);
  add("Boruto",t);
  add("Luffy",t);
  add("Naruto",t);
  add("Sanji",t);
  add("Sasuke",t);
  add("Zoro",t);
  add("Sakura",t);
  add("Usopp",t);
  add("Kakashi",t); //Colisão possivel
  printf("Depois de inserção:\n");
  display(t);
  int r1 = lookup("Kakashi",t);
  printf("Resultado do LookUp: %d\n", r1);
  int r2 = lookup("Zoro",t);
  printf("Resultado do LookUp: %d\n\n", r2);
  remover("Madara",t);
  remover("Franky",t);
  printf("Depois de remover:\n");
  display(t);
  return 0;
}
```

## 3. Defina a função int garb_collection (THash t) que reconstrói a tabela t de forma a não haver chaves apagadas (status==Del).
```c
void copy(char* nova, int novasOcorr,THash t){
  int i;
  for(i = where(nova,t); i < Size; i = (i+1) % Size)
      t[i].status = Used;
      strcpy(t[i].chave,nova);
      t[i].ocorr = novasOcorr; 
}

int garb_collection (THash t){
  int i,j = 0;
  char* nova[Size];
  int novasOcorr[Size];
  for(i = 0; i < Size ; i++){
    if(t[i].status == Used){
      novasOcorr[j] = t[i].ocorr;
      strcpy(nova[j],t[i].chave);
      j++;
    }
    initEmpty(t);
    for(i=0 ; i < j ; i++){
      copy(nova[i],novasOcorr[i],t);
    }
  }
  return 0;
}
```

## 4. Uma forma de diagnosticar a qualidade da tabela de hash consiste em acrescentar,em cada célula (bucket), a informação do número de colisões que a inserção dessa chave teve que resolver. Modifique a definição da função de inserção apresentada acima de forma a armazenar também essa informação.
```c
typedef struct bucket {
    int probC;
    int status;  //Free | Used | Del
    char *chave; int ocorr;
} THash [Size];

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define Size 11
#define Free 0
#define Used 1
#define Del 2
typedef struct bucket {
    int probC;
    int status;  //Free | Used | Del
    char *chave; int ocorr;
} THash [Size];

int where (char *s, THash t){
    int c, hash = 5381;
    while (c == *s++)
        hash *= 33 + c;
    return hash % Size;
}

void init(THash t){
  int i;
  for(i =0; i<Size;i++){
      t[i].status = Free;
      t[i].probC = 0;
      t[i].chave = "";
      t[i].ocorr = 0;
  }
}

void addHash(THash t, char *val){
  int i;
  int pos = where(val,t);
  for(int i=0; i<Size && t[pos].status>Free; i++, pos = i%Size){
      if(strcmp(t[pos].chave,val)){
         t[i].ocorr++; 
         t[i].probC = i/Size;
         return;
      }
  }
  if(t[i].status == Free){
    t[i].ocorr = 1;
    t[i].status = Used;
    strcpy(t[i].chave, val);
    t[i].probC = 0;
  } else{
    printf("Something went wrong the table is full\n");
  }
}

void printHash(THash t){
  int i;
  for(i = 0;i<Size; i++){
    printf("Probc: %d Status: %d Chave: %s Ocorr: %d\n",t[i].probC, t[i].status, t[i].chave, t[i].ocorr);
  }
  printf("\n");
}

int main(){
  THash t;
  printf("Inicialização:\n");
  init(t);
  printHash(t);
  printf("Inserção:\n");
  addHash(t,"Sakura");
  addHash(t,"Sakura");
  addHash(t,"Sakura");
  addHash(t,"Sakura");
  addHash(t,"Sakura");
  printHash(t);
  return 0;
}
```
