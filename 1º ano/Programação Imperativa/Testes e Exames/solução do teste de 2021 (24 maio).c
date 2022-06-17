// Teste 20/21
// Ex 1
int sumhtpo (int n) {
    int i, max = 0;

    for (i = 1; n != 1; i++) {
        if (n > max) max = n;

        n = (n%2 == 0) ? n/2 : 1+(3*n);
    }

    return (i < 100) ? -1 : max;
}

// Ex 2
int moda(int v[], int N, int *m) {
    int n;
    int cnt = 0;
    int flag = 1;

    for (int i = 0; i < N; i++) {
        int num = v[i];
        int count = 0;

        for (int j = 0; j < N; j++) {
            if (v[i] == v[j])
                count++;
        }

        if (count > cnt) {
            n = num;
            cnt = count;´
            flag = 0;
        } else if (count == cnt) {
            flag = 1; // multi-conjunto encontrado
        }
    }

    if (flag) return 0;

    *m = n;
    return cnt;
}

// Ex 3
int procura (LInt *l, int x) {
    for (LInt aux = *l; aux != NULL; aux = aux->next) {
        if (aux->valor == x) {
            ant->next = aux->next;
            aux->next = head;
            head = aux;
            return 1;
        }
    }

    return 0;
}

// Ex 4
int freeAB(ABin a) {
    if (a == NULL) return 0;

    int ret = freeAB(a->esq) + freeAB(a->dir) + 1;
    free(a);

    return ret;
}

// Ex 5
void caminho(ABin a) {
    if (a == NULL || a->pai == NULL) return;

    caminho(a->pai);

    printf((a->pai->esq == a) ? "esq " : "dir ");
}