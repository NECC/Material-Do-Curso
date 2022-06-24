#include <stdio.h>
#include <stdlib.h>


/* OBS: considera-se um número fixo de Vértices (6) -- seria mais
 flexível considerar NV como o número máximo de vértices admissíveis,
 incluindo um campo adicional numa estrutura que representaria o grafo,
 campo esse que continha o número de vértices efectivamente utilizados... */
#define NV 6

typedef struct aresta {
  int dest; int custo;
  struct aresta *prox;
} *LAdj, *GrafoL [NV];

typedef int GrafoM [NV][NV];

// Funções Utilitárias
void printGrafoL(GrafoL g) {
  int i;
  LAdj aux;
  for (i=0; i<NV; i++) {
    printf("%d : ", i);
    for (aux = g[i]; aux != NULL; aux = aux->prox)
      printf("%d(%d), ", aux->dest, aux->custo);
    printf("\n");
  }
}

void printGrafoM(GrafoM g) {
  int i, j;
  printf("\t");
  for (j=0; j<NV; j++) printf("%d:\t", j);
  printf("\n");
  for (i=0; i<NV; i++) {
    printf("%d :\t", i);
    for (j=0; j<NV; j++) {
      printf("%d,\t", g[i][j]);
    }
    printf("\n");
  }
}

// inicializa grafo 
void initGrafoL(GrafoL g) {
  int i;
  for (i=0; i<NV; i++)
    g[i] = NULL;
}

void initGrafoM(GrafoM g) {
  int i, j;
  for (i=0; i<NV; i++)
    for (j=0; j<NV; j++)
      g[i][j] = 0;
}

// liberta grafo
void freeGrafoL(GrafoL g) {
  int i;
  LAdj aux, temp;
  for (i=0; i<NV; i++) {
    aux = g[i];
    while (aux != NULL) {
      temp = aux->prox;
      free(aux);
      aux = temp;
    }
    g[i] = NULL;
  }
}

// insere nova aresta em lista de adjacência
LAdj cons(int v, int custo, LAdj l) {
  LAdj new = malloc(sizeof(*new));
  new->dest = v;
  new->custo = custo;
  new->prox = l;
  return new;
}

/* grafo de exemplo 1:
             |/----------\
            [0] --> [1]   \
          /\ ^         \    \
         /   |          \/   |
      [2]    |          [3]-/
        \    |         /\
         \/  |        /
           [4] ---> [5]
*/
void testGrafoM1(GrafoM g) {
  initGrafoM(g);
  g[2][0] = 1;
  g[2][4] = 1;
  g[0][1] = 1;
  g[4][0] = 1;
  g[4][5] = 1;
  g[1][3] = 1;
  g[5][3] = 1;
  g[3][0] = 1;
}
void testGrafoL1(GrafoL g) {
  initGrafoL(g);
  g[0] = cons(1,1,g[0]);
  g[1] = cons(3,1,g[1]);
  g[2] = cons(0,1,g[2]);
  g[2] = cons(4,1,g[2]);
  g[3] = cons(0,1,g[3]);
  g[4] = cons(0,1,g[4]);
  g[4] = cons(5,1,g[4]);
  g[5] = cons(3,1,g[5]);
}


// 1.1

void fromMat( GrafoM in, GrafoL out) {
  int i, j;
  initGrafoL(out);
  for (i=0; i<NV; i++)
    for (j=0; j<NV; j++)
      if (in[i][j] > 0)
	out[i] = cons( j, in[i][j], out[i]);
}

void test_1_1() {
  GrafoM g1;
  GrafoL g2;
  printf("----------------------\nTESTE 1.1:\n==========\n");
  testGrafoM1(g1);
  printf("GrafoM Original:\n");
  printGrafoM(g1);
  fromMat(g1, g2);
  printf("GrafoL Obtido:\n");
  printGrafoL(g2);
  freeGrafoL(g2);
  printf("GrafoL Esperado:\n");
  testGrafoL1(g2);
  printGrafoL(g2);
  freeGrafoL(g2);
}

// 1.2
void inverte (GrafoL in, GrafoL out) {
  int i;
  LAdj l;
  initGrafoL(out);
  for (i=0; i<NV; i++)
    for (l=in[i]; l; l=l->prox)
      out[l->dest] = cons(i, l->custo, out[l->dest]);
}

void test_1_2() {
  GrafoL g1, g2;
  printf("----------------------\nTESTE 1.2:\n==========\n");
  testGrafoL1(g1);
  inverte(g1, g2);
  printf("GrafoM Original:\n");
  printGrafoL(g1);
  freeGrafoL(g1);
  printf("GrafoL Invertido:\n");
  printGrafoL(g2);
  freeGrafoL(g2);
}

// 1.3
int inDegree (GrafoL g) {
  LAdj l;
  int deg[NV], i, max;
  for (i=0; i<NV; i++) deg[i] = 0;
  for (i=0; i<NV; i++)
    for (l=g[i]; l; l=l->prox)
      deg[l->dest]++;
  max = deg[0];
  for (i=1; i<NV; i++)
    if (deg[i] > max) max = deg[i];
  return max;
}

void test_1_3() {
  GrafoL g;
  int ind;
  printf("----------------------\nTESTE 1.3:\n==========\n");
  testGrafoL1(g);
  printf("InDegree = %d\n", inDegree(g));
  freeGrafoL(g);
}

// 1.4
int colorOK (GrafoL g, int cor[]) {
  LAdj l;
  int i, ok=1;
  for (i=0; ok && i<NV; i++)
    for (l=g[i]; ok && l; l=l->prox)
      if (cor[i] == cor[l->dest]) ok=0;
  return ok;
}

void test_1_4() {
  GrafoL g;
  int c[NV];
  printf("----------------------\nTESTE 1.4:\n==========\n");
  testGrafoL1(g);
  // coloração válida:
  c[2] = c[1] = c[3] = 1;
  c[0] = 2;
  c[4] = c[3] = 3;
  printf("Coloração OK = %d\n", colorOK(g, c));
  // coloração inválida:
  c[4] = 2;
  printf("Coloração NOK = %d\n", colorOK(g, c));
  freeGrafoL(g);
}

// 1.5
// função auxiliar que retorna peso de aresta (0 se não existir)
int getE(GrafoL g, int orig, int dest) {
  LAdj l;
  int c = 0;
  for (l=g[orig]; c==0 && l; l=l->prox)
    if (l->dest==dest) c = l->custo;
  return c;
}
int homoOK (GrafoL g, GrafoL h, int f[]) {
  LAdj l;
  int i, ok=1;
  for (i=0; ok && i<NV; i++)
    for (l=g[i]; ok && l; l=l->prox)
      ok = ok && getE(h, f[i], f[l->dest]);
  return ok;
}

/* Grafo de test 2:   [0] -> [1] -> [2] -> [3] -> [4] -> [5] */
void testGrafoL2(GrafoL g) {
  initGrafoL(g);
  g[0] = cons(1,1,g[0]);
  g[1] = cons(2,1,g[1]);
  g[2] = cons(3,1,g[2]);
  g[3] = cons(4,1,g[3]);
  g[4] = cons(5,1,g[4]);
}

void test_1_5() {
  GrafoL g1, g2;
  int hom[NV];
  printf("----------------------\nTESTE 1.5:\n==========\n");
  testGrafoL2(g1);
  testGrafoL1(g2);
  // homomorfismo válido
  hom[0] = 2;
  hom[1] = 4;
  hom[2] = 0;
  hom[3] = 1;
  hom[4] = 3;
  hom[5] = 0;
  printf("Homomorfismo OK: %d\n", homoOK(g1, g2, hom));
  // homomorfismo inválido
  hom[1] = 0;
  hom[2] = 4;
  printf("Homomorfismo NOK: %d\n", homoOK(g1, g2, hom));
  freeGrafoL(g1);
  freeGrafoL(g2);
}

int test_Ficha4_1() {
  test_1_1();
  test_1_2();
  test_1_3();
  test_1_4();
  test_1_5();
  return 0;
}

// 2
int DFRec (GrafoL g, int or, int v[], int p[], int l[]) {
  int i;
  LAdj a;
  i = 1;
  v[or] = -1;
  for (a=g[or]; a; a=a->prox)
    if (!v[a->dest]){
      p[a->dest] = or;
      l[a->dest] = 1+l[or];
      i += DFRec(g,a->dest,v,p,l);
    }
  v[or] = 1;
  return i;
}
int DF (GrafoL g, int or, int v[], int p[], int l[]) {
  int i;
  for (i=0; i<NV; i++) {
    v[i]=0;
    p[i] = -1;
    l[i] = -1;
  }
  p[or] = -1; l[or] = 0;
  return DFRec (g,or,v,p,l);
}

void test_DF() {
  GrafoL g;
  int i, n, v[NV], p[NV], l[NV];
  printf("----------------------\nTESTE DF:\n=========\n");
  testGrafoL1(g);
  n = DF(g, 4, v, p, l);
  printf("Visitados = %d\n", n);
  for (i=0; i<NV; i++)
    printf("v[%d] = %d\tp[%d] = %d\tl[%d] = %d\n", i, v[i], i, p[i], i, l[i]);
}

int BF (GrafoL g, int or, int v[], int p[], int l[]){
  int i, x; LAdj a;
  int q[NV], front, end;
  for (i=0; i<NV; i++) {
    v[i]=0;
    p[i] = -1;
    l[i] = -1;
  }
  front = end = 0;
  q[end++] = or; //enqueue
  v[or] = 1; p[or]=-1;l[or]=0;
  i=1;
  while (front != end){
    x = q[front++]; //dequeue
    for (a=g[x]; a!=NULL; a=a->prox)
      if (!v[a->dest]) {
    	i++;
	    v[a->dest]=1;
	    p[a->dest]=x;
	    l[a->dest]=1+l[x];
	    q[end++]=a->dest; //enqueue
      }
  }
  return i;
}

void test_BF() {
  GrafoL g;
  int i, n, v[NV], p[NV], l[NV];
  printf("----------------------\nTESTE BF:\n=========\n");
  testGrafoL1(g);
  n = BF(g, 4, v, p, l);
  printf("Visitados = %d\n", n);
  for (i=0; i<NV; i++)
    printf("v[%d] = %d\tp[%d] = %d\tl[%d] = %d\n", i, v[i], i, p[i], i, l[i]);
}

/* 2.1
   Pontos de interesse:
   - para capturar as distancias à origem, vai-se fazer uso da travessia
     BF (que processo o grafo por níveis).
   - o(s) vértice(s) mais distantes serão o(s) máximo(s) de l[].
   - para um desses vértices, calcula-se o caminho (do fim para o início)
     com base na informação colocada em p[].
*/
int maisLonga(GrafoL g, int or, int p[]) {
    int d, v, i, vis[NV], pai[NV], l[NV];
    BF(g, or, vis, pai, l);
    // encontrar (um dos) vertices mais distantes 
    d = 0; v = or; 
    for (i=0; i<NV; i++) 
        if (l[i]>d) { d=l[i]; v=i; }
    // preencher array do caminho
    i = d;
    p[i--] = v;
    while (pai[v]>=0) {
        v = pai[v];
        p[i--] = v;
    }
    return d;
}

void test_2_1() {
  GrafoL g;
  int i, d, p[NV];
  printf("----------------------\nTESTE 2.1:\n==========\n");
  testGrafoL1(g);
  d = maisLonga(g, 4, p);
  for (i=0; i<=d; i++)
    printf("%d, ", p[i]);
  printf("   (dist=%d)\n", d);
  freeGrafoL(g);
}

/* 4.2 */
int componentes(GrafoL g, int c[]) {
    int i, comp, orig, v[NV], p[NV], l[NV];
    DF(g, 0, c, p, l);
    comp = 1;
    do {
        // encontrar um 0 em c[]
        for (orig=0; orig<NV && c[orig]!=0; orig++);
        if (orig < NV) {
            DF(g, orig, v, p, l);
            comp++;
            for (i=0; i<NV; i++)
                if (v[i]) c[i] = comp;
        }
    } while (orig < NV);
    return comp;
}

/* Grafo de test :  [0] <-> [1] <-> [3]     [2] <-> [4]     [5] */
void testGrafoL3(GrafoL g) {
  initGrafoL(g);
  g[0] = cons(1,1,g[0]);
  g[1] = cons(0,1,g[1]);
  g[1] = cons(3,1,g[1]);
  g[3] = cons(1,1,g[3]);
  g[2] = cons(4,1,g[2]);
  g[4] = cons(2,1,g[4]);
}

void test_2_2() {
    GrafoL g;
    int i, d, p[NV];
    printf("----------------------\nTESTE 2.2:\n==========\n");
    testGrafoL3(g);
    d = componentes(g, p);
    for (i=0; i<NV; i++)
     printf("c[%d]=%d, ", i, p[i]);
    printf("   (comps=%d)\n", d);
    freeGrafoL(g);
}

/* 4.3 

            [0] --> [1]
          /\ ^         \    
         /   |          \/  
      [2]    |          [3]
        \    |         /\
         \/  |        /
           [4] ---> [5]
           
*/
void testGrafoL4(GrafoL g) {
  initGrafoL(g);
  g[0] = cons(1,1,g[0]);
  g[1] = cons(3,1,g[1]);
  g[2] = cons(0,1,g[2]);
  g[2] = cons(4,1,g[2]);
  g[4] = cons(0,1,g[4]);
  g[4] = cons(5,1,g[4]);
  g[5] = cons(3,1,g[5]);
}

// retorna num. de vertices na ordenaçao, ou -1 se ciclo
int OrdTopRec (GrafoL g, int n, int or, int v[], int ord[]) {
  LAdj a;
  v[or] = -1;
  for (a=g[or]; a; a=a->prox) {
    if (v[a->dest]==-1) return -1;
    if (!v[a->dest]){
      n = OrdTopRec(g,n,a->dest,v,ord);
      if (n < 0) return -1;
    }
  }
  v[or] = 1;
  ord[n] = or;
  return n+1;
}

// retorna 0 se OK, 1 se ciclo
int ordTop(GrafoL g, int ord[]) {
  int v[NV], orig, n, i;
  for (i=0; i<NV; i++) v[i] = 0;
  n = 0;
  orig = 0;
  do {
      n = OrdTopRec(g, n, orig, v, ord);
      if (n < 0) return 1;
      if (n < NV) {
          for (orig=1; orig<NV && v[orig]; orig++);
      }
  } while (n < NV);
  return 0;
}

void test_2_3() {
    GrafoL g;
    int i, r, ord[NV];
    printf("----------------------\nTESTE 2.3:\n==========\n");
    testGrafoL4(g);
    r = ordTop(g, ord);
    for (i=0; i<NV; i++)
     printf("%d, ", ord[i]);
    printf("   (erro=%d)\n", r);
    freeGrafoL(g);
    testGrafoL1(g);
    r = ordTop(g, ord);
    for (i=0; i<NV; i++)
     printf("%d, ", ord[i]);
    printf("   (erro=%d)\n", r);
    freeGrafoL(g);
}

/* 2.4
   Alguns pontos:
   - as posições do mapa correspondem às posições do mapa, e as ligações indicam
     um percurso possível (N/S/E/O).
   - o grafo não é representado explicitamente. Em vez disso, calcula-se os
     sucessores de cada posição testando quais das 4 posições adjacentes do mapa
     é uma posição válida e ainda não visitada.
   - o algoritmo adapta a travessia BF. Mas dado que os vértices são agora pares
     (posições (X,Y)), será preciso ajustar as estruturas de dados utilizadas
     (para registar visitados, níveis, pais, e a QUEUE).

   A implementação que se segue procura adoptar algumas das sugestões apresentadas
   na sessão online, nomeadamente:
     - utilizar o próprio mapa para registar informação dos visitados e
       informação que nos permita reconstruir o caminho seguido.
     - adapta o tipo da QUEUE para suportar pares -- aqui implementados numa
       estrutura, mas uma alternativa seria codificar os pares em inteiros
       (mas o código ficaria menos legível)
   Optou-se ainda por separar a solução em duas funções -- uma que realiza
   unicamente a travessia adicionando informação ao mapa, e outra que reconstrói
   o caminho e calcula a distância à posição inicial.
*/
typedef struct { int x, y; } Pos;
Pos newPos(int x, int y) {
  Pos p;
  p.x = x;
  p.y = y;
  return p;
}

// verifica se uma posição é válida e está livre
int livrePos(int L, int C, char mapa[L][C], Pos p) {
    return 0<=p.x && p.x<L && 0<=p.y && p.y<C && mapa[p.x][p.y]==' ';
}

int caminho (int L, int C, char mapa[L][C], int ls, int cs, int lf, int cf) {
  int i;
  // queue de posições
  int front, end;
  Pos q[L*C], p, new_p;
  //
  front = end = 0;
  q[end++] = newPos(ls,cs); //enqueue
  mapa[ls][cs] = 'I'; // Marca do início
  while (front != end){
    p = q[front++]; //dequeue
    if (p.x==lf && p.y==cf) return 0; // CHEGOU!!!
    // S
    new_p = p;
    new_p.x++;
    if (livrePos(L,C,mapa,new_p)) {
      mapa[new_p.x][new_p.y] = 'S';
      q[end++] = new_p; //enqueue NovaPosiçãa
    }
    // N
    new_p = p;
    new_p.x--;
    if (livrePos(L,C,mapa,new_p)) {
      mapa[new_p.x][new_p.y] = 'N';
      q[end++] = new_p; //enqueue NovaPosiçãa
    }
    // E
    new_p = p;
    new_p.y++;
    if (livrePos(L,C,mapa,new_p)) {
      mapa[new_p.x][new_p.y] = 'E';
      q[end++] = new_p; //enqueue NovaPosiçãa
    }
    // O
    new_p = p;
    new_p.y--;
    if (livrePos(L,C,mapa,new_p)) {
      mapa[new_p.x][new_p.y] = 'O';
      q[end++] = new_p; //enqueue NovaPosiçãa
    }
  }
  return 1; // ERRO -- destino não atingível!!!
}

/* recorremos a uma função recursiva para simultaneamente imprimir
   o caminho (reconstruído do fim para o início), e calcular a distância */
int printCaminho(int L, int C, char mapa[L][C], int lf, int cf) {
    int tam = 0;
    switch (mapa[lf][cf]) {
        case 'S':
            tam = printCaminho(L,C,mapa,lf-1,cf);
            printf("S");
            break;
        case 'N':
            tam = printCaminho(L,C,mapa,lf+1,cf);
            printf("N");
            break;
        case 'O':
            tam = printCaminho(L,C,mapa,lf,cf+1);
            printf("O");
            break;
        case 'E':
            tam = printCaminho(L,C,mapa,lf,cf-1);
            printf("E");
            break;
        default:
            return 0;
    }
    return tam + 1;      
}

void printMapa(int L, int C, char mapa[L][C]) {
  int i, j;
  for (i=0; i<L; i++) {
    for (j=0; j<C; j++)
        printf("%c",mapa[i][j]);
    printf("\n");
  }
}

void test_2_4() {
  int d;
  char mapa[10][10] = {"##########"
                      ,"# #   #  #"
	                  ,"# # # #  #"
                      ,"#   # #  #"
	                  ,"##### #  #"
		              ,"#     #  #"
		              ,"## ####  #"
		              ,"#  #     #"
		              ,"#     #  #"
		              ,"##########"};
  printf("----------------------\nTESTE 2.4:\n==========\n");
  caminho(10,10,mapa,1,1,1,8);
  printf("Mapa após travessia:\n");
  printMapa(10,10,mapa);
  printf("Caminho mais curto: ");
  d = printCaminho(10,10,mapa,1,8);
  printf("  (Dist = %d)\n", d);
}



// FUNÇÃO DE TESTE
void test_Ficha4_2() {
  test_DF();
  test_BF();
  test_2_1();
  test_2_2();
  test_2_3();
  test_2_4();
}

int main() {
  test_Ficha4_1();
  test_Ficha4_2();
  return EXIT_SUCCESS;
}
