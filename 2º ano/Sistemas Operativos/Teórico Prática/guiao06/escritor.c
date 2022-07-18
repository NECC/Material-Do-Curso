#include <unistd.h>
#include <fcntl.h>
#include <sys/wait.h>
#include <sys/types.h>
#include <sys/stat.h>

// O segundo repete para este pipe todas as linhas de texto lidas a partir do seu standard input.
// tentei usar um buffer maior mas não funcionava direito
int main() {
    char buffer[1];
    ssize_t n_read;

    int fifo = open("fifo", O_WRONLY);

    while (n_read = read(STDIN_FILENO, buffer, sizeof(buffer))) {
        write(fifo, buffer, n_read);
    }

    // elimina o ficheiro depois de ser terminado
    unlink("fifo");

    return 0;
}