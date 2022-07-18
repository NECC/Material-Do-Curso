#include <unistd.h>
#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/wait.h>

/*
Escreva um programa que emule o funcionamento do interpretador de comandos na execução encadeada
de ls /etc | wc -l.
*/

int main() {
    int pipe_fds[2];
    pipe(pipe_fds);
    int read_fd = pipe_fds[0];
    int write_fd = pipe_fds[1];

    if (fork() == 0) {
        close(read_fd);
        dup2(write_fd, STDOUT_FILENO);
        close(write_fd);

        execlp("ls", "ls", "/etc", NULL);
        _exit(EXIT_FAILURE);
    }
    close(write_fd);
    wait(NULL);

    if (fork() == 0) {
        dup2(read_fd, STDIN_FILENO);
        close(read_fd);

        execlp("wc", "wc", "-l", NULL);
        _exit(EXIT_FAILURE);
    }
    close(read_fd);
    wait(NULL);

    return EXIT_SUCCESS;
}