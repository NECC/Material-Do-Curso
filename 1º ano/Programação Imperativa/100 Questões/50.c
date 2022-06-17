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

//Ex 19
