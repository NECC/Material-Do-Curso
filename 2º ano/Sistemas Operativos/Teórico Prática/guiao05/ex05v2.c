#include <unistd.h>
#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/wait.h>
#include <string.h>

/*
Escreva um programa que emule o funcionamento do interpretador de comandos na execuc ̧  ̃ao encadeada
de grep -v ˆ# /etc/passwd | cut -f7 -d: | uniq | wc -l.
*/

#define READ 0
#define WRITE 1

void exec_list();
int tokenizer(char *argv[8], char *line);

int main() {
    char cmd_list[4][30] = {
        "grep -v ˆ# /etc/passwd",
        "cut -f7 -d:",
        "uniq",
        "wc -l"
    };

    exec_list(4, cmd_list);

    return EXIT_SUCCESS;
}

void exec_list(int n, char cmds[n][30]) {
    char *argv[8];
    int pipe_fds[2][2], ptr;

    for(int i = 0; i < n; i++) {
        ptr = i % 2;

        int argc = tokenizer(argv, cmds[i]);
        argv[argc] = NULL;

        if (i == 0) {
            // first
            pipe(pipe_fds[ptr]);

            if (fork() == 0) {
                close(pipe_fds[ptr][READ]);
                dup2(pipe_fds[ptr][WRITE], STDOUT_FILENO);
                close(pipe_fds[ptr][WRITE]);

                execvp(argv[0], argv);
                _exit(EXIT_FAILURE);
            }
            close(pipe_fds[ptr][WRITE]);
            wait(NULL);
        } else if (i+1 == n) {
            // last
            if (fork() == 0) {
                dup2(pipe_fds[(ptr+1) % 2][READ], STDIN_FILENO);
                close(pipe_fds[(ptr+1) % 2][READ]);

                execvp(argv[0], argv);
                _exit(EXIT_FAILURE);
            }
            close(pipe_fds[(ptr+1) % 2][READ]);
            wait(NULL);
        } else {
            // middle
            pipe(pipe_fds[ptr]);

            if (fork() == 0) {
                dup2(pipe_fds[(ptr+1) % 2][READ], STDIN_FILENO);
                close(pipe_fds[(ptr+1) % 2][READ]);
                dup2(pipe_fds[ptr][WRITE], STDOUT_FILENO);
                close(pipe_fds[ptr][WRITE]);

                execvp(argv[0], argv);
                _exit(EXIT_FAILURE);
            }
            close(pipe_fds[(ptr+1) % 2][READ]);
            close(pipe_fds[ptr][WRITE]);
            wait(NULL);
        }
        
    }
}

int tokenizer(char *argv[8], char *line) {
    int argc;
    char *buffer;

    for (argc = 0; (buffer = strtok_r(line, " ", &line)); argc++)
        argv[argc] = strdup(buffer);

    return argc;
}