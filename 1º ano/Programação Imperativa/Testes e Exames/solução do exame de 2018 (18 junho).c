// Parte 1

// Ex 1
char *strstr(char s1[], char s2[]) {
    int j1, i1, i2;
    char *res = NULL;
    if (s2[0] == '\0') return s1;

    for (; s1[0] != '\0'; s1++) {
        for (i2 = 0; s1[i2] != '\0' && s2[i2] != '\0' && s1[i2] == s2[i2]; i2++);
        if (s2[i2] == '\0') {
            res = s1;
            break;
        }
    }
    
    return res;
}

// Ex 2
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

// Ex 3
typedef struct posicao {
	int x, y;
} Posicao;

float dist(Posicao p) {
	return sqrt(p.x * p.x + p.y * p.y);
}

int maisCentral(Posicao pos[], int N) {
    if (N == 0) return -1;
	float distMax = dist(pos[0]);
	int p = 0, i;

	for (i = 1; i < N; i++) {
		float d = dist(pos[i]);
		if (d < distMax) {
			distMax = d;
			p = i;
		}
	}

	return p;
}

// Ex 4
typedef struct slist {
	int valor;
	struct slist *prox;
} *LInt;

LInt newLInt(int x) {
	LInt l = malloc(sizeof(struct slist));
	l->valor = x;
	l->prox = NULL;
	return l;
}

LInt somasAcL (LInt l) {
	if (l == NULL) return NULL;
	int x = l->valor;
	LInt ant = newLInt(x);
	LInt ini = ant;
	l = l->prox;
	while (l != NULL) {
	    x += l->valor;
		LInt temp = newLInt(x);
		ant->prox = temp;
		ant = temp;
		l = l->prox;
	}
	return ini;
}

// Ex 5
int addOrd (ABin *a, int x) {
	ABin temp = *a, ant = NULL;

	while (temp != NULL) {
		ant = temp;
		if (x == temp->valor) return 1;
		if (x < temp->valor) temp = temp->esq;
		else temp = temp->dir;
	}
	temp = malloc(sizeof(struct nodo));
	temp->valor = x;
	temp->esq = temp->dir = NULL;
	if (ant != NULL) {
		if (x < ant->valor) ant->esq = temp;
		else ant->dir = temp;
	} else ant = temp;
	if (*a == NULL) *a = ant;

	return 0;
}

// Parte 2
typedef struct celula {
	char *palavra;
	int comp;
	struct celula *prox;
} *Palavras;

// Ex 1
int daPalavra (char *s, int *e) {
	if (s[0] == '\0') return 0;

	for (*e = 0; isspace(s[*e]); (*e)++);

	if (s[*e] == '\0') return 0;

	int size = 0;
	for (size = *e; !isspace(s[size]) && s[size] != '\0';size++);

    return size-*e;
}

// Ex 2
Palavras words (char *texto) {
    int deslocamento = 0, esp = 0;

    Palavras pal = malloc(sizeof(struct celula));
    pal->comp = daPalavra(texto, &esp);
    pal->prox = NULL;
    pal->palavra = texto + esp;
    deslocamento = pal->comp + esp;
    if (pal->comp == 0) {
        free(pal);
        return NULL;
    }
    Palavras ant = pal;
    while (texto[deslocamento] != '\0') {
        Palavras temp = malloc(sizeof(struct celula));
        temp->comp = daPalavra(texto + deslocamento, &esp);
        temp->prox = NULL;
        temp->palavra = texto + deslocamento + esp;
        deslocamento += temp->comp + esp;
        if (temp->comp == 0) {
            free(temp);
            break;
        }
        ant->prox = temp;
        ant = temp;
    }

    return pal;
}

// Ex 3
// Estou a assumir que são palavras seguidas senão era masoquista
// Tripa-se se houver um palavra de comprimento > n
Palavras daLinha (Palavras t, int n) {
    Palavras ant = NULL, prox = t;
    int tam = 0;
    for (tam = 0; prox != NULL && tam + prox->comp <= n; prox = prox->prox) {
        tam += prox->comp + 1;
        ant = prox;
    }
    if (ant != NULL) ant->prox = NULL;
    else return NULL;
    return prox;
}

// Ex 4
void escreveLinha (Palavras p, int n) {
    Palavras resto = p, ant = NULL;
    do {
        p = resto;
        resto = daLinha(p, n);
        for (; p != NULL; p=p->prox) {
        	free(ant);
            for (int i = 0; i < p->comp; i++) putchar((p->palavra)[i]);
            putchar(' ');
        	ant = p;
        }
        if (p != NULL) free(p);
        putchar('\n');
    } while (resto != NULL);
}

// Ex 5
void formata (char texto[], int largura) {
	Palavras p = words(texto);
	escreveLinha(p, largura);
}
