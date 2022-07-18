#include <unistd.h>
#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/wait.h>

/*
Por sua vez, o terceiro programa repete para o seu standard output todas as linhas de texto lidas a partir
deste mesmo pipe.
*/
// tentei usar um buffer maior mas não funcionava direito
int main() {
    char buffer[1];
    ssize_t n_read;

    int fifo = open("fifo", O_RDONLY);

    while (n_read = read(fifo, buffer, sizeof(buffer))) {
        write(STDOUT_FILENO, buffer, n_read);
    }

    return 0;
}