#include <sys/types.h>
#include <sys/stat.h>
#include <unistd.h>
#include <fcntl.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>

#define NOME_SIZE 128
#define SOURCE "./bd.txt"

void exit_if(int cond, char* message) {
	if (cond) {
		perror(message);
		exit(EXIT_FAILURE);
	}
}

typedef struct pessoa {
    unsigned int idade;
    char nome[NOME_SIZE];
} Pessoa;

Pessoa new_pessoa(char *nome, char *idade) {
    Pessoa new;
    strcpy(new.nome, nome);
    new.idade = atoi(idade);
    return new;
}

void insert(int fd, Pessoa pessoa) {
    Pessoa p;

    while(read(fd, &p, sizeof(Pessoa))) {
        exit_if(
            (!strcmp(p.nome, pessoa.nome)),
            "conflito: a pessoa que está a tentar inserir já existe"
        );
    }
        
    off_t offset = lseek(fd, 0, SEEK_END);
    write(fd, &pessoa, sizeof(Pessoa));
    printf("registo %ld\n", (offset/sizeof(Pessoa))+1);
}

void update(int fd, Pessoa pessoa) {
    Pessoa p;

    while(read(fd, &p, sizeof(Pessoa))) {
        if (!strcmp(pessoa.nome, p.nome)) {
            lseek(fd, -sizeof(Pessoa), SEEK_CUR);
            write(fd, &pessoa, sizeof(Pessoa));
            return;
        }
    }
}

void update_by_id(int fd, int id, int idade) {
    Pessoa p;

    // ler o que está escrito
    lseek(fd, sizeof(Pessoa)*(id-1), SEEK_SET);
    read(fd, &p, sizeof(Pessoa));
    p.idade = idade;

    // escrever a idade
    lseek(fd, sizeof(Pessoa)*(id-1), SEEK_SET);
    write(fd, &p, sizeof(Pessoa));
}

void list(int fd) {
    Pessoa p;

    while(read(fd, &p, sizeof(Pessoa))) {
        printf("%s %d\n", p.nome, p.idade);
    }
}

/*
Escreva um programa que, consoante a opção, permita:
-i - Acrescentar pessoas a um ficheiro de dados binário.
-u - Actualizar a idade de uma determinada pessoa no ficheiro de dados.
Exemplos:
$ pessoas -i "José Mourinho" 55
$ pessoas -u "José Mourinho" 56
*/
int main(int argc, char* argv[]) {
	int src;
    Pessoa pessoa;
	
	exit_if((argc < 4), "erro nos argumentos");
	
	src = open(SOURCE, O_CREAT | O_RDWR, 0600);
	exit_if((src == -1), "erro na abertura do ficheiro");

    pessoa = new_pessoa(argv[2], argv[3]);

    if (argv[1][1] == 'i') {
        // inserir
        insert(src, pessoa);
    } else if (argv[1][1] == 'u') {
        // update
        update(src, pessoa);
    } else if (argv[1][1] == 'o') {
        // update by id
        update_by_id(src, atoi(argv[2]), atoi(argv[3]));
    } else if (argv[1][1] == 'l') {
        // list
        list(src);
    } else {
        perror("option error");
        return EXIT_FAILURE;
    }

	exit_if((close(src) == -1), "erro de escrita");

	return EXIT_SUCCESS;
}
