```c
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
```
# 1. Representações
Considere os seguintes tipos para representar grafos.
```c
#define NV 6
typedef struct aresta {
    int dest; 
    int custo;
    struct aresta *prox;
} *LAdj, *GrafoL [NV];

typedef int GrafoM [NV][NV];
```
Para cada uma das funções descritas abaixo, analize a sua complexidade no pior caso.
## 1. Defina a função void fromMat (GrafoM in, GrafoL out) que constrói o grafo out a partir do grafo in. Considere que in[i][j] == 0 sse não existe a aresta i → j.
```c
void fromMat (GrafoM o, GrafoL d){
  int i,j;
  struct aresta* aux;
  for(i=0; i<NV; i++) d[i] = NULL;
  for(i = 0; i<NV; i++){
      for(j = 0; j<NV; j++){
          if(o[i][j] != 0){
             aux = malloc(sizeof(struct aresta));
             aux -> dest = j;
             aux -> custo = o[i][j];
             aux -> prox = d[i];
             d[i] = aux;
          }
      }
  }
}
```
R.: O(NV^3) mas pode ser otimizado para O(NV^2).

## 2. Defina a função void inverte (GrafoL in, GrafoL out) que constrói o grafo out como o inverso do grafo in.
```c
void inverte (GrafoL o, GrafoM d){
  int j,i;
  struct aresta* aux;
  for(i = 0,j=0; i<NV && j<NV; i++,j++) d[i][j] = 0;
  for(i=0;i<NV;i++){
    for(aux=o[i]; aux != NULL; aux = aux->prox){
      d[i][aux->dest] = aux->custo;
    }
  }
}
```
R.: O(NV + E).

## 3. O grau de entrada (saída) de um grafo define-se como o número máximo de arestas que têm como destino (origem) um qualquer vértice. Defina a função int inDegree (GrafoL g) que calcula o grau de entrada do grafo.
```c
int inDegree (GrafoL o){
  int i,res=0;
  int v = 1; // vertice que quero chegar
  struct aresta* aux;
  for(i = 0; i<NV;i++){
    aux=o[i];
    for(;aux && aux->dest < v;aux=aux->prox){
      res++;
    }
  }
  return res;
}
```
R.: O(NV+E).

## 4. Uma coloração de um grafo é uma função (normalmente representada como um array de inteiros) que atribui a cada vértice do grafo a sua cor, de tal forma que, vértices adjacentes (i.e., que estão ligados por uma aresta) têm cores diferentes. Defina uma função int colorOK (GrafoL g, int cor[]) que verifica se o array cor corresponde a uma coloração válida do grafo.

```c
int colorOK (GrafoL g, int cor[]) {
    int o;
    LAdj d;

    for (o = 0; o < NV; o++)
        for (d = g[o]; d != NULL; d = d->prox)
            if(cor[o] == cor[d->dest])
                return 0;

    return 1;
}
```
R.: O(NV+E)
## 5. Um homomorfismo de um grafo g para um grafo h é uma função f (representada como um array de inteiros) que converte os vértices de g nos vértices de h tal que, para cada aresta a → b de g existe uma aresta f(a) → f(b) em h. Defina uma função int homomorfOK (GrafoL g, GrafoL h, int f[]) que verifica se a função f é um homomorfismo de g para h.
```c
int homomorfOK (GrafoL g, GrafoL h, int f[]) {
    int o;
    LAdj a, b;

    for (o = 0; o < NV; o++) {
        for (a = g[o]; a != NULL; a = a->prox) {
            for (b = h[f[a]]; b != NULL; b = b->prox)
                if(a->dest == f[b->dest])
                    break;
            
            if (b == NULL)
                return 0;
        }
    }

    return 1;
}
```
R.: O(NV+E)

Para Testes:
```c
void initGrafoL(GrafoL l){
  int i;
  for(i = 0; i<NV ;i++)
      l[i] = malloc(sizeof(struct aresta));
      l[i] = NULL;
}

void printGrafoL(GrafoL l){
  int i;
  for(i = 0; i<NV ;i++){
    if(l[i] == NULL) printf("O Grafo está a Null\n");
    else printf("Dest: %d Custo: %d\n",l[i]->dest, l[i]->custo);
  }
  printf("\n");
}

void printMatriz(GrafoM m){
  int i,j;
  for(i = 0; i<NV; i++){
      for(j = 0; j<NV; j++){
        printf("Em m[%d][%d]: %d %d\n",i,j,m[i][0],m[0][j]);
      }
  }
  printf("\n");
}

int main(){
  GrafoL l;
  GrafoM arr;
  for(int i = 0; i<NV; i++)
    for(int j = 0; j<NV; j++)
        arr[i][j] = 0;
  arr[0][1] = 4;
  arr[0][2] = 3;
  arr[0][4] = 1;
  arr[1][4] = 4;
  arr[2][0] = 2;
  arr[3][2] = 1;
  arr[3][5] = 2;
  arr[4][3] = 3;
  arr[5][4] = 1;
  printMatriz(arr);
  printf("Inicialização:\n");
  initGrafoL(l);
  printGrafoL(l);
  printf("Matriz para Grafo:\n");
  fromMat(arr, l);
  printGrafoL(l);
  printf("Grafo para Matriz:\n");
  inverte(l,arr);
  printMatriz(arr);
  int res = inDegree(l);
  printf("Grau de entrada: %d\n",res);
}
```
# 2 Travessias
Considere as seguintes definições de funções que fazem travessias de grafos.
```c
int DF(GrafoL g, int or, int v[], int p[], int l[])
{
    int i;
    for (i = 0; i < NV; i++)
    {
        v[i] = 0;
        p[i] = -1;
        l[i] = -1;
    }
    p[or] = -1;
    l[or] = 0;
    return DFRec(g, or, v, p, l);
}

int DFRec(GrafoL g, int or, int v[], int p[], int l[])
{
    int i;
    LAdj a;
    i = 1;
    v[or] = -1;
    for (a = g[or];
         a != NULL;
         a = a->prox)
        if (!v[a->dest])
        {
            p[a->dest] = or ;
            l[a->dest] = 1 + l[or];
            i += DFRec(g, a->dest, v, p, l);
        }
    v[or] = 1;
    return i;
}

int BF(GrafoL g, int or, int v[], int p[], int l[])
{
    int i, x;
    LAdj a;
    int q[NV], front, end;
    for (i = 0; i < NV; i++)
    {
        v[i] = 0;
        p[i] = -1;
        l[i] = -1;
    }
    front = end = 0;
    q[end++] = or ; //enqueue
    v[or] = 1;
    p[or] = -1;
    l[or] = 0;
    i = 1;
    while (front != end)
    {
        x = q[front++]; //dequeue
        for (a = g[x]; a != NULL; a = a->prox)
            if (!v[a->dest])
            {
                i++;
                v[a->dest] = 1;
                p[a->dest] = x;
                l[a->dest] = 1 + l[x];
                q[end++] = a->dest; //enqueue
            }
    }
    return i;
}
```
Usando estas funções ou adaptações destas funções, defina as seguintes.
## 1. A função int maisLonga (GrafoL g, int or, int p[]) que calcula a distância (número de arestas) que separa o vértice v do que lhe está mais distante. A função deverá preencher o array p com os vértices correpondentes a esse caminho.

```c
int maisLonga (GrafoL g, int or, int p[]) {
    int i, r, max = or;
    int vis[NV], pai[NV], dist[NV];

    BF(g, or, vis, pai, dist);

    for (i = 0; i < NV; i++) {
        if (dist[i] > dist[max]) {
            max = i;
        }
    }

    r = dist[max];

    while (max != -1) {
        p[dist[max]] = max;
        max = pai[max];
    }

    return r;
}

```

## 2. A função int componentes (GrafoL g, int c[]) recebe como argumento um grafo não orientado g e calcula as componentes ligadas de g, i.e., preenche o array c de tal forma que, para quaisquer par de vértices x e y, c[x] == c[y] sse existe um caminho a ligar x a y. A função deve retornar o número de componentes do grafo.

```c
int componentes (GrafoL g, int c[]) {
    int i, j, next = 0;
    int vis[NV], pai[NV], dist[NV];

    for (i = 0; i < NV; i++)
        c[i] = 0;

    for (i = 0; next < NV; i++) {
        BF(g, next, vis, pai, dist);

        for (j = 0, next = NV; j < NV; j++) {
            if (vis[j])
                c[j] = i+1;
            else if (c[j] == 0 && j < next)
                next = j;
        }
    }

    return i;
}
```

## 3. Num grafo orientado e acíclico, uma ordenação topológica dos seus vértices é uma sequência dos vértices do grafo em que, se existe uma aresta a → b então o vértice a aparece antes de b na sequência. Consequentemente, qualquer vértice aparece na sequência depois de todos os seus alcançáveis. A função int ordTop (GrafoL g, int ord[]) preenche o array ord com uma ordenação topológica do grafo.

## 4. Considere o problema de guiar um robot através de um mapa com obstáculos. O mapa é guardado numa matriz de caracteres em que o caracter ’#’ representa um obstáculo. A posição (0,0) corresponde ao canto superior esquerdo do mapa e a posição (L,C) corresponde ao canto inferior direito.

O robot pode-se deslocar na vertical (Norte/Sul): passando da posição (a,b) para a posição (a+1,b)/(a-1,b); ou na horizontal (Este/Oeste): passando da posição (a,b) para a posição (a,b+1)/(a,b-1).
Defina a função int caminho (int L, int C, char *mapa[L], int ls, int cs, int lf, int cf) que determina o número mínimo de movimentos para chegar do ponto (ls,cs) ao ponto (lf,cf).
Pode ainda generalizar essa função de forma a imprimir no ecran a sequência de movimentos necessários.
Sugestão: Em alguns casos as representações habituais de grafos introduzem um grand overhead no processo. Neste caso em particular, a informação sobre os adjacentes a um vértice (ponto do mapa) pode ser facilmente obtida por inspecção da matriz que representa o mapa.

Por exemplo, para o mapa
```c
char *mapa [10] = {"##########"
                  ,"# # # #"
                  ,"# # # # #"
                  ,"# # # #"
                  ,"##### # #"
                  ,"# # #"
                  ,"## #### #"
                  ,"# # #"
                  ,"# # #"
                  ,"##########"};
```
a invocação caminho (10, 10, mapa, 1,1,1,8) deverá dar como resultado 31.

```c
typedef struct coord {
    int l;
    int c;
    int dist;
} coord;

coord newC(int l, int c) {
    coord n = {l, c, 0};
    return n;
}

int equals(coord a, coord b) {
    return a.l == b.l && a.c == b.c;
}

int valid(coord a, int L, int C, char mapa[L][C]) {
    return (a.l >= 0 && a.l < L) && (a.c >= 0 && a.c < C) && mapa[a.l][a.c] == ' ';
}

/*
* O array de visitados é necessário se não estivermos a escrever no array (ASCII print)
*/
int caminho (int L, int C, char mapa[L][C], int ls, int cs, int lf, int cf) {
    int front, end, vis[L][C], i, j;
    coord queue[2*L*C], curr, dest;

    front = end = 0;
    dest = newC(lf, cf);
    queue[end++] = newC(ls, cs); //enqueue

    for (i = 0; i < L; i++)
        for (j = 0; j < C; j++)
            vis[i][j] = 0;

    while (front != end) {
        curr = queue[front++]; //dequeue

        if (equals(curr, dest)) {
            mapa[curr.l][curr.c] = '$';
            return curr.dist;
        }

        if (vis[curr.l][curr.c] == 1) {
            continue;
        } else {
            vis[curr.l][curr.c] = 1;
        }
        
        // ASCII print
        mapa[curr.l][curr.c] = curr.dist+'0';

        coord next_moves[4] = {
            {curr.l-1, curr.c, curr.dist+1},
            {curr.l+1, curr.c, curr.dist+1},
            {curr.l, curr.c-1, curr.dist+1},
            {curr.l, curr.c+1, curr.dist+1},
        };

        for (i = 0; i < 4; i++) {
            if (valid(next_moves[i], L, C, mapa)) {
                printf("*%d %d;  ", next_moves[i].l, next_moves[i].c);
                queue[end++] = next_moves[i];
            }
        }
    }

    return -1;
}
```
