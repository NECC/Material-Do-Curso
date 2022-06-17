#include<stdio.h>
#include<stdlib.h>

/*
Funções sobre Strings
*/

// Ex 1
int contaVogais(char *s) {
    int num = 0;
    while (*s != '\0')
    {
        if (*s == 'a' || *s == 'A' ||
            *s == 'e' || *s == 'E' ||
            *s == 'i' || *s == 'I' ||
            *s == 'o' || *s == 'O' ||
            *s == 'u' || *s == 'U') num++;
        s++;
    }
    
    return num;
}

// Ex 2
int retiraVogaisRep(char *s) {
    int removidas = 0, pos=0;

    for (int i = 0; s[i] != '\0';pos++) {
        s[pos] = s[i++];
        int min = (s[pos] == 'a' || s[pos] == 'e' || s[pos] == 'i' || s[pos] == 'o' || s[pos] == 'u');
        int mai = (s[pos] == 'A' || s[pos] == 'E' || s[pos] == 'I' || s[pos] == 'O' || s[pos] == 'U');
        if (min || mai) {
            while (s[pos] == s[i]) {
              i++;
              removidas++;
            }
        }
    }
    s[pos] = '\0';
    return removidas;
}

// Ex 3
int duplicaVogais(char *s) {
    int adicionados = 0;
    int len = 0;
    
    while (s[len++] != '\0');

    for(;*s != '\0';s++) {
        int min = (*s == 'a' || *s == 'e' || *s == 'i' || *s == 'o' || *s == 'u');
        int mai = (*s == 'A' || *s == 'E' || *s == 'I' || *s == 'O' || *s == 'U');

        if (min || mai) {
            for (int i = len++; i > 0; i--){
              s[i] = s[i-1];
            }
            adicionados++;
            s++;
        }
        len--;
    }
    
    return adicionados;
}

/*
Arrays ordenados
*/

// Ex 1
int ordenado(int v[], int N) {
    int res = 1;

    for (int i = 1; i < N && res; i++) {
        res = v[i] >= v[i-1];
    }

    return res;
}

// Ex 2
void merge(int a[], int na, int b[], int nb, int r[]) {
    int N = na + nb;
    int pA = 0, pB = 0;

    for(int total = 0; total < N; total++) {
        if (pB >= nb) r[total] = a[pA++];
        else if (pA >= na) r[total] = b[pB++];
        else if (b[pB] > a[pA]) r[total] = a[pA++];
        else r[total] = b[pB++];
    }
}

// Ex 3
void swap(int v[], int i, int j) {
    int temp = v[i];
    v[i] = v[j];
    v[j] = temp;
}

int partition(int v[], int N, int x) {
    int pos = 0;

    for (int i = 0; i < N; i++) {
        if (v[i] <= x) swap(v, i, pos++);
    }

    return pos;
}
