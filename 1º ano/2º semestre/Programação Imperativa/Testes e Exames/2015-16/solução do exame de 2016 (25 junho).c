// Parte A

// Ex 1
char *strcpy(char *des, char *source) {
	int i = 0;
	while (source[i] != '\0')
		dest[i] = source[i++];
	dest[i] = '\0';
	return dest;
}

// Ex 2
void strnoV(char s[]) {
	int i = pos = 0;
	for (; s[i] != '\0'; i++) {
		if (s[i] != 'a' && s[i] != 'e' &&
			s[i] != 'i' && s[i] != 'o' &&
			s[i] != 'u' && s[i] != 'A' &&
			s[i] != 'E' && s[i] != 'I' &&
			s[i] != 'O' && s[i] != 'U') s[pos++] = s[i];
	}
	s[pos] = '\0';
}

// Ex 3
int dumpAbin(ABin a, int v[], int N) {
	if (a == NULL) return 0;
	if (N == 0) return 0;
	int e = d = 0;
	e = dumpAbin(a->esq, v, N);
	if (e == N) return N;
	v[e] = a->valor;
	d = dumpAbin(a->dir, b, N-e-1);
	return e + d + 1;
}

// Ex 4
int lookupAB(ABin a, int x) {
	while (a != NULL && a->valor != x)
		a = (a->valor > x) ? a->esq : a->dir;
	return a == NULL;
}

// Parte B

// Ex 1
int inc(Hist *h, char *pal) {
	Hist ant = NULL;
	Hist ite = *h;
	while (ite != NULL && strcmp(ite->pal, pal) < 0) {
		ant = ite;
		ite = ite->prox;
	}
	if (ite == NULL) {
		ite = malloc(sizeof(Nodo));
		ite->pal = malloc(sizeof(char) * strlen(pal));
		strcpy(ite->pal, pal);
		ite->cont = 0;
		ite->prox = NULL;
	} else {
		if (strcmp(ite->pal, pal) != 0) {
			Hist temp = malloc(sizeof(Nodo));
			temp->pal = malloc(sizeof(char) * strlen(pal));
			strcpy(temp->pal, pal);
			temp->prox = ite;
			temp->cont = 0;
			ite = temp;
		}
	}
	if (ant == NULL) *h = ite;
	else ant->prox = ite;
	return ++(ite->cont);
}

// Ex 2
char *remMaisFreq(Hist *h, int *count) {
	if (*h == NULL) return NULL;
	Hist ite = (*h)->prox;
	Hist antIte = maisFreq = *h;
	Hist ant = NULL;
	while (ite != NULL) {
		if (ite->cont > maisFreq->cont) {
			ant = antIte;
			maisFreq = ite;
		}
		antIte = ite;
		ite = ite->prox;
	}
	char *palavra = malloc(sizeof(char) * strlen(maisFreq->pal));
	strcpy(palavra, maisFreq->pal);
	if (ant == NULL) *h = maisFreq->prox;
	else ant->prox = maisFreq->prox;
	*count = maisFreq->cont;
	free(maisFreq->pal);
	free(maisFreq);
	return palavra;
}

// Ex 3
void filtraString(char *s) {
	int i = pos = 0;
	for (; s[i] != '\0'; i++) {
		if ('A' <= s[i] && s[i] <= 'Z')
			s[pos++] = s[i];
		else if ('a' <= s[i] && s[i] <= 'z')
			s[pos++] = s[i] + ('a'-'A'); // 'a'-'A' == 32
	}
	s[pos] = '\0';
}

void libertaHist(Hist *h) {
	if (*h != NULL) {
		Hist temp = (*h)->prox;
		Hist ant = *h;
		while (temp != NULL) {
			free(ant->palavra);
			free(ant);
			ant = temp;
			temp = temp->prox;
		}
		free(ant->palavra);
		free(ant);
	}
}

int main() {
	char lerPalavra[61];
	Hist grama = NULL;
	while (1) {
		scanf("%s", lerPalavra);
		filtraString(lerPalavra);
		if (lerPalavra[0] == '\0') break;
		inc(&grama, lerPalavra);
	}
	// Histograma já tem todas as palavras e frequencias
	// Assumindo que corre tudo bem
	int imprimidas = 0;
	while (imprimidas < 10 && grama != NULL) {
		int freq = 0;
		char *palavra = remMaisFreq(&grama, &freq);
		if (strlen(palavra) > 3) {
			printf("Palavra: %s", palavra);
			printf("Contagem: %d", freq);
			i++;
		}
		free(palavra);
	}
	libertaHist(&grama);
	return 0;
}
