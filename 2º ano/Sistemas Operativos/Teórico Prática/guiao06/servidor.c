#include <unistd.h>
#include <fcntl.h>
#include <sys/wait.h>
#include <sys/types.h>
#include <sys/stat.h>

/*
Escreva um programa “servidor”, que fique a correr em background, e acrescente a um ficheiro de “log”
todas as mensagens que sejam enviadas por “clientes”. Escreva um programa cliente que envia para o
servidor o seu argumento. Cliente e servidor devem comunicar via pipes com nome.
*/

#define PIPE "FifoEx2"

int main() {
    if (mkfifo(PIPE, 0666) == -1) {
        write(STDERR_FILENO, "mkfifo error", sizeof("mkfifo error"));
        return -1;
    }

    char buffer[1];
    ssize_t n_read;
    int log = open("log.txt", O_CREAT | O_WRONLY, 0666);
    int fifo = open(PIPE, O_RDONLY);

    if (log == -1) {
        write(STDERR_FILENO, "erro log\n", sizeof("erro log\n"));
        return -1;
    }

    while (n_read = read(fifo, buffer, sizeof(buffer))) {
        write(log, buffer, n_read);
    }

    close(log);
    unlink(PIPE);

    return 0;
}