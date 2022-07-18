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
    char buffer[1];
    ssize_t n_read;
    int fifo = open(PIPE, O_WRONLY);

    while (n_read = read(STDIN_FILENO, buffer, sizeof(buffer))) {
        write(fifo, buffer, n_read);
    }

    return 0;
}