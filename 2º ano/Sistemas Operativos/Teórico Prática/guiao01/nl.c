#include <sys/types.h>
#include <sys/stat.h>
#include <unistd.h>
#include <fcntl.h>
#include <stdlib.h>
#include <stdio.h>

#define SIZE 1000
#define LINE_SIZE 8

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

/*
* LINE_SIZE-2 acontece porque um dos chars é o \0 e o outro o \t
*/
int main(int argc, char* argv[]) {
	int src;
	char buffer[SIZE], line_label[LINE_SIZE];
	ssize_t n_read;
	
	exit_if((argc < 2), "erro nos argumentos");
	
	src = open(argv[1], O_RDONLY);
	exit_if((src == -1), "erro na abertura do ficheiro de input");
	
	for (int i = 1; n_read = readln(src, buffer, SIZE);) {
		if (n_read == 1)
			sprintf(line_label, "%*c\t", LINE_SIZE-2, ' ');
		else
			sprintf(line_label, "%*d\t", LINE_SIZE-2, i++);
		
		write(STDIN_FILENO, line_label, 8);
		write(STDIN_FILENO, buffer, n_read);
	}

	exit_if((close(src) == -1), "erro de escrita");

	return EXIT_SUCCESS;
}
