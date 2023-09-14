// Parte A

// Ex 1
int retiraNeg(int v[], int N) {
	int i = 0, pos = 0;
	for(; i < N; i++)
		if (v[i] >= 0)
			v[pos++] = v[i];
	return pos;
}

// Ex 2
// A correção da codeboard deste ex é completamente incompreensivel
int difConsecutivos(char s[]) {
    int maior = 0, subString = 0;
    int i = 0, j = 0, lastPos = 0;
    while (s[i] != '\0') {
        j = i+1;
        lastPos = i;
        subString = 1;
        for (; s[j] != '\0' && (s[j] == ' ' || s[j] != s[lastPos]); j++) {
            if (s[j] != ' ') {
                lastPos = j;
                subString++;
            }
        }
        if (s[j] != '\0' && s[j+1] == s[j]) subString--;
        if (subString > maior) maior = subString;
        i++;
    }
    return maior;
}

// Ex 3
int maximo(LInt l) {
	int maior = l->valor;
	l = l->prox;
	while (l != NULL) {
		if (l->valor > maior) maior = l->valor;
		l = l->prox;
	}
	return maior;
}

// Ex 4
int removeAll(LInt *l, int x) {
	int rem = 0;
	LInt ite = *l;
	LInt ant = NULL;
	while (ite != NULL) {
		if (ite->valor == x) {
			if (ant != NULL) {
			    ant->prox = ite->prox;
			    free(ite);
			    ite = ant->prox;
			} else {
			    *l = ite->prox;
			    ant = NULL;
			    free(ite);
			    ite = *l;
			}
			rem++;
		} else {
			ant = ite;
			ite = ite->prox;
		}
	}
	return rem;
}

// Ex 5
LInt arrayToList(int v[], int N) {
	if (N == 0) return NULL;
	LInt inicio = NULL;
	LInt ite = NULL;
	for (int i = 0; i < N; i++) {
		LInt temp = malloc(sizeof(struct slist));
		temp->valor = v[i];
		temp->prox = NULL;
		if (inicio == NULL) {
			inicio = temp;
			ite = temp;
		} else {
			ite->prox = temp;
			ite = temp;
		}
	}
	return inicio;
}

// Parte B -> Estas não testei, podem estar mal

// Ex 1
int minHeapOK(ABin a) { //1 se nao for min-heap, 0 se for min-heap
	if (a == NULL) return 0;
	int cond = 0;
	if (a->esq != NULL && a->esq->valor < a->valor) return 1;
	cond = minHeapOK(a->esq);
	if (!cond) {
		if (a->dir != NULL && a->dir->valor < a->valor) return 1;
		cond = minHeapOK(a->dir);
	}
	return cond;
}

// Ex 2
int maxHeap(ABin a) {
	int maior = a->valor;
	if (a->esq != NULL) {
		int x = maxHeap(a->esq);
		maior = (maior > x) ? maior : x;
	}
	if (a->dir != NULL) {
		int x = maxHeap(a->dir);
		maior = (maior > x) ? maior : x;
	}
	return maior;
}

// Ex 3
void removeMin(ABin *a) {
	if (*a != NULL) {
		if ((*a)->esq == NULL) {
			if ((*a)->dir == NULL) {
				ABin temp = *a;
				*a = temp->dir;
				free(temp);
			} else {
				free(*a);
				*a = NULL;
			}
		} else {
			if ((*a)->dir == NULL) {
				ABin temp = *a;
				*a = temp->esq;
				free(temp);
			} else {
				ABin next = (a->esq->valor < a->dir->valor) ? a->esq : a->dir;
				(*a)->valor = next->valor;
				removeMin(&next);
				(*a)->prox = next;
			}
		}
	}
}

// Ex 4
void heapSort(int v[], int N) {
	ABin arvore = NULL;
	for (int i = 0; i < N; i++)
		add(&arvore, v[i]);
	for (int i = 0; i < N; i++) {
		v[i] = arvore->valor;
		removeMin(&arvore);
	}
}

// Ex 5
int kMaior(int v[], int N, int k) {
	if (N == 0 || k == 0) return -1;
	int lidos = 0;
	ABin arvore = NULL;
	for (int i = 0; i < N; i++) {
		if (lidos < k) {
			add(&arvore, v[i]);
			lidos++;
		} else if (arvore->valor < v[i]) {
			removeMin(&arvore);
			add(&arvore, v[i]);
		}
	}
	return arvore->valor;
}