#include <unistd.h>
#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/wait.h>

/*
Escreva um programa que emule o funcionamento do interpretador de comandos na execuc ̧  ̃ao encadeada
de grep -v ˆ# /etc/passwd | cut -f7 -d: | uniq | wc -l.
*/

#define READ 0
#define WRITE 1

int main() {
    int pipe_fds[2][2];
    pipe(pipe_fds[0]);

    if (fork() == 0) {
        close(pipe_fds[0][READ]);
        dup2(pipe_fds[0][WRITE], STDOUT_FILENO);
        close(pipe_fds[0][WRITE]);

        execlp("grep", "grep", "-v",  "^#", "/etc/passwd", NULL);
        _exit(EXIT_FAILURE);
    }
    close(pipe_fds[0][WRITE]);
    wait(NULL);

    pipe(pipe_fds[1]);

    if (fork() == 0) {
        dup2(pipe_fds[0][READ], STDIN_FILENO);
        close(pipe_fds[0][READ]);
        dup2(pipe_fds[1][WRITE], STDOUT_FILENO);
        close(pipe_fds[1][WRITE]);

        execlp("cut", "cut", "-f7", "-d:", NULL);
        _exit(EXIT_FAILURE);
    }
    close(pipe_fds[0][READ]);
    close(pipe_fds[1][WRITE]);
    wait(NULL);

    pipe(pipe_fds[0]);

    if (fork() == 0) {
        dup2(pipe_fds[1][READ], STDIN_FILENO);
        close(pipe_fds[1][READ]);
        dup2(pipe_fds[0][WRITE], STDOUT_FILENO);
        close(pipe_fds[0][WRITE]);

        execlp("uniq", "uniq", NULL);
        _exit(EXIT_FAILURE);
    }
    close(pipe_fds[1][READ]);
    close(pipe_fds[0][WRITE]);
    wait(NULL);

    if (fork() == 0) {
        dup2(pipe_fds[0][READ], STDIN_FILENO);
        close(pipe_fds[0][READ]);

        execlp("wc", "wc", "-l", NULL);
        _exit(EXIT_FAILURE);
    }
    close(pipe_fds[0][READ]);
    wait(NULL);

    return EXIT_SUCCESS;
}