#include <sys/types.h>
#include <sys/stat.h>
#include <unistd.h>
#include <fcntl.h>
#include <stdlib.h>
#include <stdio.h>

#define SIZE 1000
#define BUFF 128

void exit_if(int cond, char* message) {
	if (cond) {
		perror(message);
		exit(EXIT_FAILURE);
	}
}

ssize_t readln(int fd, char *line, size_t size) {
    char buffer[BUFF];
	ssize_t n_read, ptr_read, ptr_write = 0;

	while(n_read = read(fd, buffer, BUFF)) {
        for (ptr_read = 0; ptr_read < n_read && ptr_write < size; ptr_read++) {
            line[ptr_write++] = buffer[ptr_read];

            if (buffer[ptr_read] == '\n')
                return ptr_write;
        }
    }

	return ptr_write;
}

ssize_t readln2(int fd, char *line, size_t size) {
    static char buffer[BUFF];
    static ssize_t ptr_read;
	ssize_t n_read, ptr_write = 0;

    // ainda existem dados no buffer
    if (ptr_read  > 0) {
        while (ptr_read < size && buffer[ptr_read] != '\n') {
            
        }
    }

	while(n_read = read(fd, buffer, BUFF)) {
        for (ptr_read = 0; ptr_read < n_read && ptr_write < size; ptr_read++) {
            line[ptr_write++] = buffer[ptr_read];

            if (buffer[ptr_read] == '\n')
                return ptr_write;
        }
    }

	return ptr_write;
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
