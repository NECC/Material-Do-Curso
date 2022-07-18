#include <unistd.h>
#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/wait.h>

/*
Escreva um programa que execute o comando wc num processo filho. O processo pai deve enviar ao
filho atrav ́es de um pipe an ́onimo uma sequˆencia de linhas de texto introduzidas pelo utilizador no seu
standard input. Recorra `a t ́ecnica de redireccionamento estudada no gui ̃ao anterior de modo a associar
o standard input do processo filho ao descritor de leitura do pipe an ́onimo criado pelo pai. Recorde a
necessidade de fechar o(s) descritor(es) de escrita no pipe de modo a verificar-se a situac ̧  ̃ao de end of file.
*/

int main() {
    char buffer[32];
    ssize_t n_read;

    int pipe_fds[2];
    pipe(pipe_fds);
    int read_fd = pipe_fds[0];
    int write_fd = pipe_fds[1];

    if (fork() == 0) {
        close(write_fd);
        dup2(read_fd, STDIN_FILENO);
        close(read_fd);

        execlp("wc", "wc", "-w", NULL);
        _exit(EXIT_FAILURE);
    }

    close(read_fd);

    // Temos extremidade de escrita do pipe.
    char message[] = "O pai está a escrever para o filho\n";
    write(write_fd, message, sizeof(message));

    sleep(2);
    write(write_fd, "Está à espera\n", sizeof("Está à espera\n"));

    close(write_fd);
    wait(NULL);

    return EXIT_SUCCESS;
}