#include <unistd.h>
#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/wait.h>
#include <string.h>

/*
Escreva um programa redir que permita executar um comando, opcionalmente redireccionando a en-
trada e/ou a saída. O programa poder ́a ser invocado, com:
redir [-i fich_entrada] [-o fich_saida] comando arg1 arg2 ...
*/
// pelo menos uma stream tem de ser redirecionada
int main(int argc, char* argv[]) {
    char *in, *out;
    int fd, last = 3;
    int term_fd = dup(STDOUT_FILENO);

    if (!strcmp(argv[1], "-i")) {
        in = strdup(argv[2]);
        out = (!strcmp(argv[3], "-o")) ? strdup(argv[4]) : NULL;
    } else {
        out = strdup(argv[2]);
        in = (!strcmp(argv[3], "-i")) ? strdup(argv[4]) : NULL;
    }

    if (in != NULL) {
        fd = open(in, O_RDONLY);
        dup2(fd, STDIN_FILENO);
        close(fd);
    }

    if (out != NULL) {
        fd = open(out, O_WRONLY | O_CREAT | O_TRUNC, 0644);
        dup2(fd, STDOUT_FILENO);
        close(fd);
    }

    if (argv[3][0] == '-') last = 5;

    if (fork() == 0) {
        execvp(argv[last], (argv + last));
        _exit(EXIT_FAILURE);
    }

    wait(NULL);

    write(term_fd, "terminado\n", sizeof("terminado\n"));

    return EXIT_SUCCESS;
}