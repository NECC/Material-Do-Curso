---

---

# 1. Funções sobre strings

<https://codeboard.io/projects/22589dd3>

1. Defina uma função `int contaVogais(char * s)` que conta quantas vogais uma $string$ tem.
```c title:"Conta Vogais"
int isVogal(char c){
  return (c == 'a' || c == 'A' ||
          c == 'e' || c == 'E' ||
          c == 'i' || c == 'I' ||
          c == 'o' || c == 'O' ||
          c == 'u' || c == 'U')
}

int contaVogais(char *s){
  int i = 0, conta = 0;
  while (s[i] != '\0'){
    if(isVogal(s[i])) conta++;
    i++;
  }
  return conta;
}
```

2. Defina uma funçao `int retiraVogaisRep(char *s)` que remove de uma $string$ todas as repetições consecutivas de vogais. A função deverá retornar o número de vogais removidas. Por exemplo, se a string `a == "Estaa e umaa string coom duplicadoos`, depois de invocarmos `retiraVogaisRep a`, a string deverá ter o valor "Esta e uma string com duplicados".
- Para evitar fazer muitos deslocamentos de caracteres, apresente uma definição que usa um array auxiliar onde a string resultante será construída. No final terá que copiar essa string de volta para o array argumento.
- Altere a função que definiu acima de forma a não precisar de usar o array auxiliar.
```c title:"Retira vogais repetidas"
int retiraVogaisRep(char *s){
  int i = 0, j = 0;
  while(s[i] != '\0'){
    s[j] = s[i];
    j++;
    if(isVogal(s[i])){
      while(s[i + 1] == s[i]) i++;
    }
  }
  s[j] = '\0';
  return (i - j);
}
```

3. Defina uma função `int duplicaVogais(char *s)` que duplica todas as vogais de uma $string$. A função deve retornar o número de caracteres. Assuma que o array recebido como argumento tem capacidade para armazenar o resultado pretendido.
- Mais uma vez, e de forma a evitar muitos deslocamentos de caracteres, defina esta função usando um array auxiliar para construir a string resultante.
- Apresente ainda uma definição alternativa onde não seja de facto necessário usar o dito array auxiliar.
```c title:"Duplica vogais"
int duplicaVogais(char *s){
  int i = 0, conta = 0;
  while(s[i] != '\0'){
    if(isVogal(s[i])){
      conta++;
      int j = strlen(s);
      while(j > i){
        s[j + 1] = s[j]; 
        j--;
      }
      s[i + 1] = s[i];
      i++;
    }
    i++;
  }
  return conta;
}
```

```c title: "Main para testar"
#include <stdio.h>
int main()
{   char s1 [100] = "Estaa e umaa string coom duuuplicadoos";
    int x;
    
    printf ("Testes\n");
    printf ("A string \"%s\" tem %d vogais\n", s1, contaVogais (s1));
    
    x = retiraVogaisRep (s1);
    printf ("Foram retiradas %d vogais, resultando em \"%s\"\n", x, s1);
    
    x = duplicaVogais (s1);
    printf ("Foram acrescentadas %d vogais, resultando em \"%s\"\n", x, s1);
    
    printf ("\nFim dos testes\n");

    return 0;
}
```

# 2. Arrays ordenados
<https://codeboard.io/projects/225895>

1. Defina uma função `int ordenado(int v[], int N)` que testa se um array de inteiros esta ordenado por ordem crescente.
```c title:"Ordenado"
int ordenado (int v[], int N){
  int i = 0;
  while(i < N - 1){
    if(v[i] > v[i + 1]) return 0;
    else i++;
  }
  return 1;
}
```

2. Defina uma função `void merge(int a[], int na, int b[], int nb, int r)` que recebe dois arrays ordenados `a` e `b` (com tamanhos `na` e `nb` respectivamente) e os funde num só array ordenado `r`. Assuma que o array `r` tem capacidade para armazenar os `na + nb` elementos.
```c title:Merge
void merge(int a[], int na, int b[], int r[]){
  int ia, ib, ir;
  for(ia = ib = ir = 0; ia < na && ib < nb; ir++){
    r[ir] = (a[ia] < b[ib]) ?  a[ia++] : b[ib++];
  }
  for(; ia < na; r[ir++] = a[ia++]);
  for(; ib < nb; r[ir++] = b[ib++]);
}
```

3. Defina uma função `int partition (int v[], int N, int x)` que, dado um array `v` de tamanho `N` e um inteiro `x`, reorganiza o array de forma a que começam por aparecer todos os elementos menores ou iguais a `x` seguidos dos restantes elementos. A função retorna o número de elementos que ficaram na primeira parte do array (i.e., que são menores ou iguais a x)
- Comece por definiruma versão desta função que usa um array auxiliar para construiro resultado pretendido. No final deve copiar o conteúdo desse array de volta para o array recebido como argumento.
- Apresente uma definição alternativa para esta função que não usa um array auxiliar. Para isso considere a seguinte estratégia:
  Sejam `a` e `b` dois índices do array em que se verifica a seguinte propriedade:
  - todos os elementos nos índices `[0..a[` são menores ou iguais a `x`
  - todos os elementos nos índices `[a..b[` são maiores do que `x`

```c title:"partition (array aux)"
int partition(int v[], int N, int x){
  int r[N];
  int i, m = 0, M = N-1;
  for(i = 0; i < N; i++){
    (v[i] <= x) ? (r[m++] = v[i]) : r[M--] = v[i]; 
  }
  for(i = 0; i < N; i++) v[i] = r[i];
  return m;
}
```

```c title:"partition (in-place)"
int partition(int v[], int N, int x){
  int i = 0, j, temp;
  for(j = 0; j < N; j++){
    if(v[j] <= x){
      temp = v[i];
      v[i] = v[j];
      v[j] = temp;
      i++;
    }
  }
  return i;
}
```

```c title:"Main para testar"
int main(){
	int a [15] = {10, 3,45,56, 8,23,13,42,77,31,18,88,24,45, 1},
        b [10] = { 4,12,34,45,48,52,61,73,84,87}, 
        c [10] = { 1, 3, 8,22,33,35,38,41,44,49}, 
        d [50];
    int x;
    
    printf ("Testes\n\n");

    printf ("O array "); dumpV(a,15);
    simNao (ordenado (a,15)); printf (" está ordenado\n");
    printf ("O array "); dumpV(b,10);
    simNao (ordenado (b,10)); printf (" está ordenado\n");
    
    printf ("\n\nMerge dos arrays "); dumpV (b,10);
    printf ("\ne                "); dumpV (c,10); 
    merge (b, 10, c, 10, d);
    printf ("\nresulta em       "); dumpV (d,20);

    printf ("\n\n\nA partição do array  "); dumpV (a,15);
    printf ("\nusando 30 resulta em "); 
    x = partition (a,15,30); 
    dumpV (a,15); printf (" e retorna %d \n", x);

    printf ("\nFim dos testes\n");
    return 0;
}
```

