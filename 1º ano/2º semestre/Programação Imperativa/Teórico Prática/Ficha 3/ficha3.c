#include<stdio.h>
#include<stdlib.h>

/*
// Ex 1
> 1 1 4
> 2 2 6
> 3 3 8
> 4 4 10
> 5 5 12

// Ex 2
> 13

*/

// Ex 2
void swapM(int *x, int *y) {
    int temp = *x;
    *x = *y;
    *y = temp;
}

// Ex 3
void swap(int v[], int i, int j) {
    int temp = v[i];
    v[i] = v[j];
    v[j] = v[i];
}

// Ex 4
int soma(int v[], int N) {
    int soma = 0;
    for (int i = 0; i < N; i++) soma += v[i];
    return soma;
}

// Ex 5 - Usando swap de vetor
void inverteArray(int v[], int N) {
    for (int i = 0; i < N/2; i++) swap(v, i, N-1-i);
}

// Ex 5 - usando swap normal
void inverteArray(int v[], int N) {
    for (int i = 0; i < N/2; i++) swapM(v+i, v+N-1-i);
}

// Ex 6
int maximum(int v[], int N, int *m) {
    if (N < 1) return -1;
    *m = v[0];
    for (int i = 1; i < N; i++) {
        if (v[i] > *m) *m = v[i];
    }
    return 0;
}

// Ex 7
void quadrados(int q[], int N) {
    q[0] = 0;
    for (int i = 0; i < N-1; i++) q[i+1] = q[i] + 2*i+1;
}

// Ex 8a
void pascal(int v[], int N) {
    for (int n = 1; n <= N; n++) {
        v[n-1] = 1;
        for (int i = n-2; i > 0; i--) {
            v[i] = v[i] + v[i-1];
        }
    }
}

// Ex 8b
void desenhaTrianguloP(int N) {
    int v[N];
    for (int n = 1; n <= N; n++) {
        v[n-1] = 1;
        for (int i = n-2; i > 0; i--) {
            v[i] = v[i] + v[i-1];
        }
        for (int i = 0; i < n; i++) printf("%d ", v[i]);
        putchar('\n');
    }
}