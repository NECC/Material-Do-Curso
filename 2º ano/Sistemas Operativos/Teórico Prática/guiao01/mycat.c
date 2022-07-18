#include <sys/types.h>
#include <sys/stat.h>
#include <unistd.h>
#include <fcntl.h>
#include <stdlib.h>
#include <stdio.h>

#define SIZE 1


int main(int argc, char* argv[]) {
	ssize_t n_read;
	char buffer[SIZE];

	while(n_read = read(STDIN_FILENO, &buffer, SIZE))
		write(STDOUT_FILENO, &buffer, n_read);
	
	return EXIT_SUCCESS;
}
