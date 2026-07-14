#include<stdio.h>
#include<stdlib.h>

int ex1() {
	int p;
	scanf("%d", &p);
	int max = p;
	while(p != 0) {
		scanf("%d", &p);
		if (p > max)
			max = p;
	}
	printf("%d", max);
	return max;
}

int ex2() { //Vou imprimir a média em int porque não especifica
	int numElementos = 1, x, soma;
	scanf("%d", &soma);
	x = soma;
	while(x != 0) {
		scanf("%d", &x);
		if (x != 0) {
			soma += x;
			numElementos++;
		}
	}
	int media = soma/numElementos;
	printf("%d", media);
	return media;
}

int ex3() {
	int maior, sMaior;
	int x;
	scanf("%d", &x);
	maior = x;
	scanf("%d", &x);
	if (x > maior) {
		sMaior = maior;
		maior = x;
	} else sMaior = x;
	while(x != 0) {
		scanf("%d", &x);
		if (x!= 0 && x > sMaior) {
			if (x > maior) {
				sMaior = maior;
				maior = x;
			} else sMaior = x;
		}
	}
	printf("%d", sMaior);
	return sMaior;
}

// Ex 4
int bitsUm(unsigned int n) {
	int i, uns = 0;
	for(i = n; i > 0; i/=2) {
		if (i % 2 == 1) uns++;
	}
	return uns;
}

//Ex 5
//unsigned int mas o codeboard use valores negativos para testar lol
int trailingZ(unsigned int n) {
	int i, zeros = 0;
	for(i = n; i > 0; i/=2)
		if (i % 2 == 0) zeros++;
	return zeros;
}

//Ex 6
int qDig(unsigned int n) {
	int i,x = 0, resto = 1;
	for(i = 1; resto != n; i*=10) {
		resto = n % i;
		if (resto != n)
			x++;
	}
	return x;
}

//Ex 7
char *mystrcat(char s1[], char s2[]) {
	int p,i;
	for(p = 0; s1[p] != '\0'; p++); //p final tem s1[p] == '\0'
	for (i = 0; s2[i] != '\0';i++,p++)
		s1[p] = s2[i];
	s1[p] = '\0';
	return s1;
}

//Ex 8
char *mystrcpy(char *dest, char source[]) {
	int i = 0;
	for(i = 0; source[i] != '\0'; i++)
		dest[i] = source[i];
	dest[i] = '\0';
	return dest;
}

//Ex 9
int mystrcmp(char s1[], char s2[]) {
	int i;
	for(i = 0; s1[i] != '\0' && s2[i] != '\0' && s1[i] == s2[i]; i++);
	return s1[i]-s2[i];
}

//Ex 10
char *mystrstr(char s1[], char s2[]) {
    char *res = NULL;
    int i,p;
    if (s2[0] == '\0') return s1;
    for(i = 0; s1[i] != '\0' && res == NULL; i++) {
        for(p = 0; s2[p] != '\0' && s2[p] == s1[i+p];p++);
        if (s2[p] == '\0')
            res = s1 + i;
    }
    return res;
}

//Ex 11
void strrev(char s[]) {
	int size;
	char temp;
	for (size = 0; s[size] != '\0'; size++);
	for (int i = 0; i < size/2; i++) {
		temp = s[i];
		s[i] = s[size-i-1];
		s[size-i-1] = temp;
	}
}

//Ex 12
void strnoV (char t[]){
    int i, pos;
    for (i = 0, pos = 0; t[i] != '\0';i++) {
        if (t[i] != 'a' &&
			t[i] != 'e' &&
			t[i] != 'i' &&
			t[i] != 'o' &&
			t[i] != 'u' &&
			t[i] != 'A' &&
			t[i] != 'E' &&
			t[i] != 'I' &&
			t[i] != 'O' &&
			t[i] != 'U') {
			t[pos++] = t[i];
		}
    }
    t[pos] = '\0';
}

//Ex 13
void truncW(char t[], int n) {
    int i, adi, pos;
    for (i = 0, pos = 0, adi = 0; t[i] != '\0'; i++) {
        if (t[i] == ' ') {
            adi = 0;
            t[pos++] = ' ';
        } else if (adi < n) {
            t[pos++] = t[i];
            adi++;
        }
    }
    t[pos] = '\0';
}

//Ex 14
char charMaisfreq (char s[]) {
	char maisFreq = '0';
	int i, j, freq = 0, f;
	for(i = 0; s[i] != '\0'; i++) {
		f = 0;
		for (j = 0; s[j] != '\0'; j++) {
			if (s[j] == s[i]) f++;
		}
		if (f > freq) {
			freq = f;
			maisFreq = s[i];
		}
	}
	return maisFreq;
}

//Ex 15
int iguaisConsecutivos (char s[]) {
    int i, k;
    int seq = 0, n;
    for (i = 0, n = 0; s[i] != '\0'; i++, n = 0) {
        for (k = i; s[k] == s[i] && s[k] != '\0'; k++) n++;
        if (n > seq) seq = n;
    }
    return seq;
}

//Ex 16
int ex16(char s[]) {
    int n = strlen(s), vs = 0, r = 0, i, o;
    for (i = 0; i < n; i++) {
        vs = 0;
        for (o = i; o < n; o++) {
            if (o == 0) vs++;
            else if (s[o] == ' ') continue;
            else if (s[o - 1] == s[o]) break;
            else vs++;
        }
        if (vs > r) r = vs;
    }
    return r;
}

//Ex 17
int maiorPrefixo (char s1 [], char s2 []) {
	int prefixo = 0;
	int i, k, pre;
	for (i = 0, pre = 0; s1[i] != '\0' && s2[i] != '\0'; i++, pre = 0) {
		for (k = 0; s1[k] != '\0' && s2[k] != '\0' && s1[k] == s2[k]; k++) pre++;
		if (pre > prefixo) prefixo = pre;
	}
	return prefixo;
}

//Ex 18
int maiorSufixo (char s1 [], char s2 []) {
    int n1 = strlen(s1), n2 = strlen(s2), i;
    int n = (n1 < n2 ? n1 : n2), r = 0, pos = 0;
    char s1i[n1], s2i[n2];

    for (i = n1 - 1; i >= 0; i--) s1i[pos++] = s1[i];
    pos = 0;
    for (i = n2 - 1; i >= 0; i--) s2i[pos++] = s2[i];

    for (i = 0; i < n; i++) {
        if (s1i[i] == s2i[i]) r++;
        else break;
    }
    return r;
}

// 19
int sufPref(char s1[], char s2[]) {
  int size = strlen(s1);
  int res = 0;
  int j = 0;
  for (int i = 0; i < size; i++) {
    if (s1[i] == s2[j]) {
      res++;
    } else {
      res = 0;
      j = 0;
    }
  }
  return res;
}

// 20
int contaPal(char s[]) {
  int res = 1;
  int size = strlen(s);
  for (int i = 0; i < size; i++) {
    if (isspace(s[i])) res++;
  }
  return res;
}

// 21
int contaVogais(char s[]) {
  int acc = 0;
  char vogais[] = "aeiouAEIOU";
  int size = strlen(s);
  for (int i = 0; i < size; i++) {
    for (int j = 0; j < 10; j++) {
      if (s[i] == vogais[j]) acc++;
    }
  }

  return acc;
}

// 22 - 1 for true, 0 for false
int contida(char a[], char b[]) {
  int sizeA = strlen(a);
  int sizeB = strlen(b);
  int indexA = 0;
  for (int i = 0; i < sizeA; i++) {
    for (int j = 0; j < sizeA; j++) {
      if (a[i] == b[j]) indexA++;
    }
    if (indexA == (sizeB - 1)) return 1;
  }
  return 0;
}

// 23
int palindorome(char s[]) {
  int size = strlen(s);
  int palindromo = size/2;
  int res = 1;
  for (int i = 0; i < palindromo - 1; i++) {
    if (!(s[i] == s[size - 1 - i])) {
      res = 0;
    }
  }
  return res;
}

// 24
int remRep(char x[]) {
  int size = strlen(x);
  int index = 0;
  char arrFinal[size];
  for (int i = 0; i < size; i++) {
    if (!(x[i] == x[i+1])) {
      arrFinal[index] = x[i];
      index++;
    }
  }
  return strlen(arrFinal);
}

// 25
int limpaEspacos(char t[]) {
  // int size = strlen(t);
  for(int i = 0; t[i]; i++) {
    if (t[i] == ' ' && t[i+1] == ' ') {
      for(int j=i+1; t[j]; j++) t[j] = t[j+1];
      i--;
    }
  }

  return strlen(t);
}

// 26
void insere(int v[], int N, int x) {
  for (int i = 0; v[i]; i++) {
    if (v[i] > x) {
      for (int j = N; j > i; j--) {
        v[j] = v[j-1];
      }
      v[i] = x;
      break;
    }
    if (i == N -1) {
      v[N] = x;
    }
  }
}

// 27
void merge(int r [], int a[], int b[], int na, int nb) {
  int size = na + nb;
  int aacc = 0, bacc = 0;
  int sizeA = na;
  int sizeB = nb;
  for (int i = 0; i < size; i++) {
    if (a[aacc] > b[bacc]) {
      r[i] = b[bacc];
      bacc++;
      sizeB--;
    } else {
      r[i] = a[aacc];
      aacc++;
      sizeA--;
    }
  }
  for (int k = 0; k < size - 1; k++) {
    printf("%d ",r[k]);
  }
}

// 28
int crescente(int a[], int i, int j) {
  for (int index = i; index <= j; index++) {
    if (!(a[index] < a[index + 1])) return 0;
  }
  return 1;
}

// 29
int retiraNeg(int v[], int N) {
  int acc = -1;
  for (int i = 0; i < N; i++) {
    if (v[i] < 0) {
      for (int j = i; j < N - 1; j++) {
        v[j] = v[j + 1];
      }
    } else {
      acc++;
    }
  }
  return acc;
}

//30

int rep(int num, int arr[], int N) {
  int count = 0;

  for (int i = 0; i < N; i++) {
    if (num == arr[i]) count++;
  }
  return count;
}

int menosFreq(int v[], int N) {
  int menos = rep(v[0],v,N);
  int res = v[0];

  for (int i = 0; i < N; i++) {
    int atual = rep(v[i],v,N);
    if (atual < menos) {
      menos = atual;
      res = v[i];
    }
  }
  return res;
}

// 31
int repete(int num, int v[], int N) {
  int count = 0;
  for (int i = 0; i < N; i++) {
    if (num == v[i]) count++;
  }
  return count;
}

int maisFreq(int v[], int N) {
  int maior = repete(v[0], v, N);
  int res = 0;
  for (int i = 0; i < N; i++) {
    int atual = repete(v[i],v,N);
    if (atual > maior) {
      maior = atual;
      res = v[i];
    }
  }

  return res;
}

// 32
int maxCresc(int v[], int N){
    int i, maior = 1, r = 1;

    for(i=0; i<N; i++){
        if(v[i+1] >= v[i])
            r++;
        else {
            if(r>maior)
                maior = r;
            r=1;
        }
    }
    return maior;
}

// 33
// se repetir mais do q 1 vez, retorna > 0
// se repetir 1 vez retorna 0
int pertence(int elem, int v[], int n) {
  int res = -1;
  for (int i = 0; i < n; i++) {
    if (elem == v[i]) res++;
  }
  return res;
}

int elimRep(int v[], int n) {
  int arr[n];
  int index = 0;
  for (int i = 0; i < n; i++) {
    int elem = pertence(v[i],v,n);
    if (elem == 0) {
      arr[index] = v[i];
      index++;
    }
  }
  for (int j = 0; j < index; j++) {
    v[j] = arr[j];
  }
  return index + 1;
}

// 34
int elimRepOrd (int v[], int n) {
  for (int i = 0; i < n - 1; i++) {
    if (v[i] == v[i + 1]) {
      for (int j = i; j < n; j++) {
        v[j] = v[j + 1];
      }
      n--;
    }
  }
  return n - 1;
}

// 35
int comunsOrd(int a[], int na, int b[], int nb) {
  int count = 0;
  for (int i = 0; i < na; i++) {
    for (int j = 0; j < nb; j++) {
      if (a[i] == b[j]) {
        count++;
        i++;
      } else if (a[i] < b[j]) {
        i++;
      }
    }  
  }
  return count;
}

// 36
int pertence2(int b[], int num, int nb) {
  for (int i = 0; i < nb; i++) {
    if (b[i] == num) {
      return 1;
    }
  }
  return 0;
}
int comuns(int a[], int na, int b[], int nb) {
  int count = 0;
  for (int i = 0; i < na; i++) {
    if (pertence2(b, a[i], nb) == 1) count++;
  }
  return count;
}

// 37
int minInd(int v[], int n) {
  int menor = v[0];

  for (int i = 0; i < n; i++) {
    if (v[i] <= menor) menor = v[i];
  }
  
  return menor;
}

// 38
void somasAc (int v[], int Ac [], int N) {
  Ac[0] = v[0];
  for (int i = 1; i < N; i++) {
    Ac[i] = 0;
    for (int j = 0; j <= i; j++) {
      Ac[i] += v[j];
    }
  }
}

// 39
// [
//  1 2 3
//  0 2 3
//  0 0 3
// ]
int triSup (int N, float m[N][N]) {
  for (int i = 1; i < N; i++) {
    for (int j = 0; j < i;j++) {
      if (m[i][j] != 0) return 0;
    }
  }
  return 1;
}

// 40
void transposta(int N, float m [N][N]) {
  float temp;
  for (int i = 0; i < N; i++) {
    for (int j = 0; j < N; j++) {
      temp = m[i][j];
      m[i][j] = m[j][i];
      m[j][i] = temp;
    }
  }
}

// 41
void addTo (int N, int M, int a [N][M], int b[N][M]) {
  for (int i = 0; i < N; i++) {
    for (int j = 0; j < M; j++) {
      a[i][j] += b[i][j];
    }
  }
}

// 42
int unionSet (int N, int v1[N], int v2[N], int r[N]){
  int count = 0;
  for (int i = 0; i < N; i++) {
    r[i] = v1[i] || v2[i];
    count++;
  }
  return count;
}

// 43
int intersectSet(int N, int v1[N], int v2[N], int r[N]) {
  int count = 0;
  for (int i = 0; i < N; i++) {
    r[i] = v1[i] && v2[i];
    count++;
  }
  return count;
}

// 44
int intersectMSet (int N, int v1[N], int v2[N],int r[N]) {
    int len = 0;
    for(int i = 0; i < N; i++) {
        r[i] = v1[i] < v2[i] ? v1[i] : v2[i];
        len += r[i]; 
    }
    return len;
}

// 45
int unionMSet (int N, int v1[N], int v2[N], int r[N]) {
    int len = 0;
    for(int i = 0; i < N; i++) {
        r[i] = v1[i] + v2[i];
        len += r[i]; 
    }
    return len;
}

// 46
int cardinalMSet (int N, int v[N]) {
    int len = 0;
    for(int i = 0; i < N; i++) len += v[i];
    return len;
}


// --------- TESTS ------------

int main() {
  int choice = 0;
  char *res;
  char ola;
  char str[] = "Ola   tudo bem";
  int vetor[100];
  int vetorA[] = {1,3,4,11,11,11,11};
  int vetorB[] = {2,5,10,12};
  int vetor38[] = {1,2,3,4};
  int vetor38_2[5];

  printf("Escolha uma questão: ");
  scanf("%d",&choice);

  switch (choice) {
    case 1:
      ex1();
      break;
    case 2:
      ex2();
      break;
    case 3:
      ex3();
      break;
    case 4:
      bitsUm(15);
      break;
    case 5:
      trailingZ(16);
      break;
    case 6:
      qDig(1990);
      break;
    case 7:
      mystrcat("ola","tudo bem");
      break;
    case 8:
      //char *pArray = &array[0];
      //char *a = strcpyMy("Ola","ola tudo bem");
      //printf("%s",a);
      break;
    case 9:
      mystrcmp("ola", "olb");
      break;
    case 10:
      res = mystrstr("anagrama","ama");
      printf("%s",res);
      break;
    case 11:
      mystrrev("eae ze da manga");
      break;
    case 12:
      mystrnoV("sorvetEEEEEE");
      break;
    case 13:
      mytruncW("liberdade, igualdade e fraternidade", 4);
      break;
    case 14:
      ola = mycharMaisfreq("booooooooooooa");
      printf("%c",ola);
      break;
    case 15:
      choice = iguaisConsecutivos("bom diiiiiiiioooooooooooooooooaa");
      printf("%d",choice);
      break;
    case 16:
      choice = difConsecutivos("ola tuuuuuuuuudo bem");
      printf("%d",choice);
      break;
    case 17:
      choice = maiorPrefixo("ooooola", "oooola");
      printf("%d",choice);
      break;
    case 18:
      choice = maiorSufixo("oooolaaaaa", "ooolaaaaa");
      printf("%d",choice);
        break;
    case 19:
      choice = sufPref("olaaaaaaa","aaaaaalho");
        printf("%d",choice);
        break;
    case 20:
      choice = contaPal("Agua mole e pedra dura");
      printf("%d",choice);
      break;
    case 21:
      choice = contaVogais("conta minhas vogais por favor");
      printf("%d",choice);
      break;
    case 22:
      choice = contida("abe","abcd");
      printf("%d",choice);
      break;
    case 23:
      choice = palindorome("rotatorrrrr");
      printf("%d",choice);
      break;
    case 24:
      choice = remRep("aaabaaabbbaaa");
      printf("%d",choice);
      break;
    case 25:
      choice = limpaEspacos(str);
      printf("%d",choice);
      break;
    // case 26:
      // insere({1,2,3,4,5},3,10);
      // break;
    case 27:
      merge(vetor, vetorA, vetorB,6,5);
      break;
    case 28:
      choice = crescente(vetorA,1,3);
      printf("%d",choice);
      break;
    case 29:
      choice = retiraNeg(vetorA, 6);
      printf("%d",choice);
      break;
    case 30:
      choice = menosFreq(vetorA,6);
      printf("%d",choice);
      break;
    case 31:
      choice = maisFreq(vetorA, 6);
      printf("%d",choice);
      break;
    case 32:
      choice = maxCresc(vetorA, 6);
      printf("%d",choice);
      break;
    case 33:
      choice = elimRep(vetorA, 6);
      printf("%d",choice);
      break;
    case 34:
      choice = elimRepOrd(vetorA, 6);
      printf("%d",choice);
      break;
    case 35:
      // choice = comunsOrd(int *a, int na, int *b, int nb)
      break;
    case 36:
      // choice = comuns(int *a, int na, int *b, int nb)
      break; 
    case 37:
      choice = minInd(vetorA, 6);
      printf("%d",choice);
      break;
    case 38:
      somasAc(vetor38, vetor38_2, 4);
      break;
    case 39:
      // triSup(int N, float (*m)[N])
      break;
    case 40:
      // transposta(int N, float (*m)[N]) 
      break;
    case 41:
      // unionSet(int N, int *v1, int *v2, int *r)
      break;
    case 42:
      // intersectSet(int N, int *v1, int *v2, int *r)
      break;
    
  }

  return 0;
}
