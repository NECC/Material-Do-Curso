// Exame 20/21
// Ex 1
void swap(int *n1, int *n2) {
    int aux = *n1;
    *n1 = *n2;
    *n2 = aux;
}

int paresImpares (int v[], int N) {
    for (int i = 0; i < N; i++) {
        if (v[i] % 2) { // se for impar
            for (int j = i + 1; j < N; j++) { // procurar um elemento par e efetuar troca
                if ((v[j] % 2) == 0) {
                    swap(&v[i], &v[j]);
                    break;
                }
            }
        }
    }
}

// Ex 2
typedef struct Nodo {
    int valor;
    struct Nodo *next;
} *LInt;

void merge (LInt *r, LInt a, LInt b) {
    for (; a != NULL && b != NULL; r = &((*r)->next)) {
        if (a->valor < b->valor) {
            *r = a;
            a = a->next;
        } else {
            *r = b;
            b = b->next;
        }
    }
    
    *r = (b == NULL) ? a : b;
}

// Ex 3
void latino (int N, int m[N][N]) {
    for (int i = 0; i < N; i++) {
        for (int j = 0; j < N; j++) {
            m[i][j] = (i + j % N) + 1;
        }
    }
}

// Ex 4
ABin next (ABin a) {
    if (a == NULL) return NULL;
    
    if (a->dir == NULL && a->pai == NULL) {
        return NULL;
    } else if (a->dir == NULL && a->pai->dir == a) {
        return a->pai->pai;
    } else if (a->dir == NULL && a->pai->esq == a) {
        return a->pai;
    }

    return a->dir;
}

// Last ESTÁ IMCOMPLETA!!!!
/*
    int strcmp( const char *lhs, const char *rhs );

    Return value
        Negative value if lhs appears before rhs in lexicographical order.
        Zero if lhs and rhs compare equal.
        Positive value if lhs appears after rhs in lexicographical order.
*/
int acrescentaPal (Palavras *p, char *pal) {
    int cmp = strcmp(p, pal->palavra);
    if (cmp == 0) {
        pal->n0corr += 1;
        return pal->n0corr;
    } else if (cmp < 0) {
        return acrescentaPal(p, pal->esq);
    } else {
        return acrescentaPal(p, pal->dir);
    }
}