# Static

## Static Stacks

Considere o seguinte tipo para representar `stacks` de números inteiros.

```c title:"Static Stack"
struct staticStack {
 int sp;
 int values [Max];
};
typedef struct staticStack *SStack;
```

defina as seguintes funções sobre este tipo:
a) `void SinitStack(SStack s)` que inicializa uma stack (passa a representar uma stack vazia)

b) int SisEmpty(SStack s) que testa se uma stack é vazia.

c) `int Spush(SStack s, int x)` que acrescenta `x` ao topo de s; a função deve retornar 0 se a operação for feita como sucesso (i.e., se a stack não tiver cheia) e 1 se a operação não for possível (i.e., se a stack estiver cheia).

d) `int Spop(SStack s, int *x)` que remove de uma stack o elemento que está no topo. A função deverá colocar no endereço `x` o elemento removido. A função deverá retornar `0` se a operação for possível (i.e., se a stack não está vazia) e `1` em caso de erro (stack vazia).

e) `int Stop (SStack s, int *x)` que coloca no endereço `x` o elemento que está no topo da stack (sem modificar a stack). A função deverá retornar `0` se a operação for possível (i.e., a stack não está vazia) e `1` em caso de erro (stack vazia).

```c title:"Operções para a SStack"
void SinitStack (SStack s){
  s->sp = 0;
}

int  SisEmpty (SStack s){
  return (s->sp == 0);
}

int  Spush (SStack s, int x){
 int r = 0;
 if(s->sp == Max) r = 1;
  else{
    s->values[s->sp] = x;
    s->sp++;
  }
 return r;
}

int  Spop (SStack s, int *x) {
 int r=0;
  if(s->sp == 0) r = 1;
  else{
    s->sp -= 1;
    *x = s->values[s->sp];
  }
 return r;
}

int  Stop (SStack s, int *x) {
 int r=0;
 if(s->sp == 0) r = 1;
  else{
    *x = s->values[s->sp - 1];
  }
 return r;
}

void ShowSStack (SStack s){
    int i;
    printf ("%d Items: ", s->sp);
    for (i=s->sp-1; i>=0; i--) 
        printf ("%d ", s->values[i]);
    putchar ('\n');
}
```

## Static Queues

Considere o seguinte tipo para representar `queues` de números inteiros.

```c title:"Static queues"
struct staticQueue {
 int front;
 int length;
 int values [Max];
};
typedef struct staticQueue *SQueue;
```

Defina as seguintes funçoes sobre este tipo:

a) `void SinitQueue(SQueue q)` que inicializa uma queue (passa a representar uma queue vazia).

b) `int SisEmbtyQ(SQueue q)` que testa se uma queue é vazia.

c) `int Senqueue(SQueue q, int x)` que acrescenta `x` ao fim de `q`; a função deve retornar `0` se a operação for feita com sucesso (i.e., se a queue ainda não estiver cheia) e `1` se a operação não for feita com sucesso (i.e., se a queue estiver cheia).

d) `int Sdequeue(SQueue q, int *x)` que remove de uma queue o elemento que está no início. A função deverá colocar no endereço `x` o elemento removido. A função deverá retornar `0` se a operação for possível (i.e., a queue não está vazia) e `1` em caso de erro (queue vazia).

e) `int Sfront(SQueue q, int *x)` que coloca no endereço `x` o elemento que está no início da queue (sem modificar a queue). A função deverá retornar `0` se a operação for possível (i.e., a queue não está vazia) e `1` em caso de erro (queue vazia).

```c title:"Static queues operations"
void SinitQueue (SQueue q){
 q->front = 0;
  q->length = 0;
}

int  SisEmptyQ (SQueue q){
 return (q->length == 0);
}

int  Senqueue (SQueue q, int x){
 int r = 0;
  if(q->length == Max) r = 1;
  else{
    q->values[(q->front + q->length) % Max] = x;
    q->length++;
  }
 return r;
}

int  Sdequeue (SQueue q, int *x) {
 int r = 0;
  if(q->length == 0) r = 1;
  else{
    *x = q->values[q->front];
    q->length--;
    q->front = (q->front + 1) % Max;
  }
 return r;
}

int  Sfront (SQueue q, int *x) {
  int r = 0;
 if(q->length == 0) r = 1;
  else{
    *x = q->values[q->front];
  }
  return r;
}

void ShowSQueue (SQueue q){
    int i, p;
    printf ("%d Items: ", q->length);
    for (i=0, p=q->front; i<q->length; i++) {
        printf ("%d ", q->values[p]);
        p = (p+1)%Max;
    }
    putchar ('\n');
}

```

# Dynamic

Na representação de stacks e queues sugeridas nas alíneas anteriores o array de valores tem um tamanho fixo (definido pela constante `MAX`). Uma consequência dessa definição é o facto de as funções de inserção (`push` e `enqueue`) poderem não ser executadas por se ter excedido a capacidade das estruturas.
Uma definição alternativa consiste em não ter um array com tamanho fixo e sempre que seja preciso mais espaço, realocar o array para um tamanho superior (normalmente duplica-se o tamanho do array).
Considere então as seguintes definições alternativas e adapte as funções definidas atrás para esta nova representação.
Use as funções `malloc` e `free` cujo tipoo está definido em `stdlib.h`

```c title:"Dynamic LIFO and FIFO"
struct dinStack {
 int size;
 int sp;
 int *values;
};
typedef struct dinStack *DStack;

struct dinQueue {
 int size;
 int front;
 int length;
 int *values;
};
typedef struct dinQueue *DQueue;
```

```c title:" Dynamic LIFO and FIFO operations"
int dupStack (DStack s) {
 int r = 0, i;
 int *t = malloc (2*s->size*sizeof(int));

 if (t == NULL) r = 1;
 else {
  for (i=0; i<s->size; i++) 
   t[i] = s->values[i];
  free (s->values);
  s->values = t;
  s->size*=2;
 }
 return r;
}

void DinitStack (DStack s) {
 s->size = Max;
  s->values = malloc(s->size * sizeof(int));
  s->sp = 0;
}

int  DisEmpty (DStack s) {
 return (s->sp == 0);
}

int  Dpush (DStack s, int x){
 int r=0;
 if(s->sp == s->size){
    s->values = realloc(s->values, 2 * s->size * sizeof(int));
    s->size *= 2;
  }
  s->values[s->sp] = x;
  s->sp++;
 return r;
}

int  Dpop (DStack s, int *x){
 int r=0;
 if(s->sp == 0) r = 1;
  else{
    s->sp -= 1;
    *x = s->values[s->sp];
  }
 return r;
}

int  Dtop (DStack s, int *x){
 int r=0;
 if(s->sp == 0) r = 1;
  else{
    *x = s->values[s->sp - 1];
  }
 return r;
}

void ShowDStack (DStack s){
    int i;
    printf ("%d Items: ", s->sp);
    for (i=s->sp-1; i>=0; i--) 
        printf ("%d ", s->values[i]);
    putchar ('\n');
}

int dupQueue (DQueue q) {
 int i = 0, j = q->size;
  q->values = realloc(q->values, 2 * j * sizeof(int));
  q->size *= 2;
  whileI(i < q->front) q->values[j++] = q->values[i++];
 return 0;
}

void DinitQueue (DQueue q) {
  q->size = Max;
 q->values = malloc(q->size * sizeof(int));
  q->length = 0;
  q->front = 0;
}

int  DisEmptyQ (DQueue q) {
 return (q->length == 0);
}

int  Denqueue (DQueue q, int x){
  int i = 0, j = q->size;
  if(q->size == q->length){
    q->values = realloc(q->values, 2 * q->size * sizeof(int));
    q->size *= 2;
    while(i < q->front) q->values[j++] = q->values[i++];
  }
  q->values[(q->front + q->length) % q->size] = x;
  q->length++;
  return 0;
}

int  Ddequeue (DQueue q, int *x){
 if(q->length == 0) return 1;
  *x = q->values[q->front];
  q->length--;
  q->front = (q->front + 1) % q->size;
 return 0;
}

int  Dfront (DQueue q, int *x){
 int r = 0;
  if(q->length == 0) r = 1;
  else{
    *x = q->values[q->front];
  }
 return r;
}

void ShowDQueue (DQueue q){
    int i, p;
    printf ("%d Items: ", q->length);
    for (i=0, p=q->front; i<q->length; i++) {
        printf ("%d ", q->values[p]);
        p = (p+1)%q->size;
    }
    putchar ('\n');
}
```

## Main
```c title:"Main para testar"
int main() {
  int i ; 
  struct staticStack s1;
  SStack S1 = &s1;
  struct dinStack d1;
  DStack D1 = &d1;

  struct staticQueue q1;
  SQueue Q1 = &q1;
  struct dinQueue r1;
  DQueue R1 = &r1;
  
  printf ("Testing Stacks .... \n");
  SinitStack (S1);
  DinitStack (D1);
  for (i=0; i<15; i++) {
    if (Spush (S1,i) != 0) printf ("ERROR pushing %d\n", i);
    if (Dpush (D1,i) != 0) printf ("ERROR pushing %d\n", i);
  }
  ShowSStack (S1);
  ShowDStack (D1);
  
  printf ("Testing Queues .... \n");
  SinitQueue (Q1);
  DinitQueue (R1);
  for (i=0; i<15; i++) {
    if (Senqueue (Q1,i) != 0) printf ("ERROR enqueueing %d\n", i);
    if (Denqueue (R1,i) != 0) printf ("ERROR enqueueing %d\n", i);
  }
  ShowSQueue (Q1);
  ShowDQueue (R1);

  return 0;
} 
```


