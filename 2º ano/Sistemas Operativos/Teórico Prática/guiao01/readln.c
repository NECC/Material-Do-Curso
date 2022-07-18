#include <sys/types.h>
#include <sys/stat.h>
#include <unistd.h>
#include <fcntl.h>
#include <stdlib.h>
#include <stdio.h>

#define SIZE 1000

void exit_if(int cond, char* message) {
	if (cond) {
		perror(message);
		exit(EXIT_FAILURE);
	}
}

ssize_t readln(int fd, char *line, size_t size) {
	ssize_t i = 0;

	while(read(fd, &line[i], 1) && line[i++] != '\n');

	return i;
}

int main(int argc, char* argv[]) {
	int src;
	ssize_t n_read;
	char line[SIZE];
	
	exit_if((argc < 2), "erro nos argumentos");
	
	src = open(argv[1], O_RDONLY);
	exit_if((src == -1), "erro na abertura do ficheiro de input");
	
	n_read = readln(src, line, SIZE);

	write(1, &line, n_read);
	
	return EXIT_SUCCESS;
}
