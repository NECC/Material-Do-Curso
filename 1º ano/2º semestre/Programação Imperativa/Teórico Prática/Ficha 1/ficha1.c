// 3. Programas Iterativos

// Ex 1
void quadrado(int size) {
	for (int i = 0; i < size; i++) {
		for (int j = 0; j < size; j++)
			printf("#");
		printf("\n");
	}
}

// Ex 2
void xadrez(int size) {
	char elemento = '#';
	for (int i = 0; i < size; i++) {
		for (int j = 0; j < size; j++) {
			printf("%c", elemento);
			elemento = (elemento == '#') ? '_' : '#';
		}
		printf("\n");
	}
}

// Ex 3
void vertical(int size) {
	// Antes de chegar a meio
	for (int i = 0; i <= size; i++) {
		for (int j = 0; j < i; j++)
			printf("#");
		printf("\n");
	}

	// Depois de metade
	for (int i = size-1; i > 0; i--) {
		for (int j = 0; j < i; j++)
			printf("#");
		printf("\n");
	}
}

void horizontal(int size) {
	char array[size][size*2 -1]; 
	int espacos = 0, j;
	for (int i = size-1; i >= 0; i--, espacos++) {
		for (j = 0; j < espacos; j++)
			array[i][j] = ' ';
		for (; j < (2*size - 1 - espacos); j++)
			array[i][j] = '#';
		for (;j < 2*size-1; j++)
			array[i][j] = ' ';
	}
	for(int i = 0; i < size; i++) {
		for (j = 0; j < 2*size-1; j++)
			printf("%c", array[i][j]);
		printf("\n");
	}
}

// Ex 4
int circulo(int raio) {
    int num = 0;
    for (int i =  0; i < raio*2+1; i++) {
        for (int j = 0; j < raio*2+1; j++) {
            float x = raio - i;
            float y = raio - j;
            float dist = sqrt(x*x + y*y);
            if (dist <= raio) {
                putchar('#');
                num++;
            }
            else putchar(' ');
        }
        putchar('\n');
    }

    return num;
}
