#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct aluno {
    int numero;
    char nome[100];
    int miniT[6];
    int teste;
} Aluno;

// Ex 1
int nota (Aluno a){
    int total = 0;
    int i;
    for (i = 0; i < 6; i++) {
        total += a.miniT[i];
    }
    total /= 2;
    total += a.teste * 0.7;
    return total;
}

// Ex 2
int procuraNum(int numeroAluno, Aluno t[], int N) {
    int i;
    for (i = 0; i < N && t[i].numero < numeroAluno; i++);
    return (i < N && t[i].numero == numeroAluno) ? i : -1;
}

//Ex 3
void swap(Aluno *x, Aluno *y) {
    Aluno t = *x;
    *x = *y;
    *y = t;
}

void ordenaPorNum(Aluno t[], int N) {
    int i,j;
    for (i = 0; i < N-1; i++) {
        for (j = i+1; j < N; j++) {
            if (t[j].numero < t[i].numero) swap(t+i, t+j);
        }
    }
}

// Ex 4
void swapNums(int *x, int*y) {
    int t = *x;
    *x = *y;
    *y = t;
}

void criaIndPorNum(Aluno t[], int N, int in[]) {
    int i, j;
    int ind[N];
    for (i = 0; i < N; i++) ind[i] = i;

    for (i = 0; i < N; i++) {
        for (j = i; j < N; j++) 
            if (t[ind[j]].numero < t[ind[i]].numero) swapNums(ind+i, ind+j);
        in[ind[i]] = i;
    }
}

// Ex 5
void imprimeTurmaInd (int ind[], Aluno t[], int N){
    int next = 0, i;
    for (next = 0; next < N; next++) {
        for(i = 0; ind[i] != next; i++);
        printf("%d %s\n", t[i].numero, t[i].nome);
    }
    
}

// Ex 6
int procuraNumInd (int num, int ind[], Aluno t[], int N){
    int i;
    
    for (i = 0; i < N && t[i].numero != num; i++);
    
    return (i < N && t[i].numero == num) ? ind[i] : -1;
}

// Ex 7
void criaIndPorNome(Aluno t[], int N, int in[]) {
    int i, j;
    int ind[N];
    for (i = 0; i < N; i++) ind[i] = i;

    for (i = 0; i < N; i++) {
        for (j = i; j < N; j++) 
            if (strcmp(t[ind[j]].nome, t[ind[i]].nome) < 0) swapNums(ind+i, ind+j);
        in[ind[i]] = i;
    }
}
