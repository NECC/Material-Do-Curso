#include <sys/types.h>
#include <sys/stat.h>
#include <unistd.h>
#include <fcntl.h>
#include <stdlib.h>
#include <stdio.h>

#define SIZE 1

void exit_if(int cond, char* message) {
	if (cond) {
		perror(message);
		exit(EXIT_FAILURE);
	}
}

int main(int argc, char* argv[]) {
	int src, dst;
	ssize_t n_read = 0;
	char buffer[SIZE];
	
	exit_if((argc < 3), "erro nos argumentos");
	
	src = open(argv[1], O_RDONLY);
	exit_if((src == -1), "erro na abertura do ficheiro de input");
	
	dst = open(argv[2], O_CREAT | O_RDWR, 0600);
	exit_if((src == -1), "erro na abertura do ficheiro de output");

	while((n_read = read(src, &buffer, SIZE)) != 0)
		write(dst, &buffer, n_read);
	
	exit_if((close(dst) == -1), "erro na escrita do ficheiro");
	
	return EXIT_SUCCESS;
}
