#include <unistd.h>
#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/wait.h>

/*
Modifique o programa anterior de modo a que, depois de realizar os redireccionamentos, seja criado um
novo processo que realize operaçoes de leitura e escrita. Observe o conteudo dos ficheiros. Repare que o
processo filho “nasce” com as mesmas associaçoes de descritores de ficheiros do processo pai.
*/

int main() {
    int status;
    char buffer[32];
    ssize_t n_read;

    int term_fd = dup(STDOUT_FILENO);
    int inp_fd = open("/etc/passwd", O_RDONLY);
    int out_fd = open("saida.txt", O_WRONLY | O_CREAT | O_TRUNC, 0644);
    int err_fd = open("erros.txt", O_WRONLY | O_CREAT | O_TRUNC, 0644);


    dup2(inp_fd, STDIN_FILENO);
    dup2(out_fd, STDOUT_FILENO);
    dup2(err_fd, STDERR_FILENO);

    close(inp_fd);
    close(out_fd);
    close(err_fd);

    if (fork() == 0) {
        while (n_read = read(STDIN_FILENO, buffer, sizeof(buffer))) {
            write(STDERR_FILENO, buffer, n_read);
            write(STDOUT_FILENO, buffer, n_read);
        }
        _exit(EXIT_SUCCESS);
    }

    wait(&status);

    n_read = sprintf(buffer, "status - %i\n", WEXITSTATUS(status));
    write(term_fd, buffer, n_read);
    write(term_fd, "terminei\n", sizeof("terminei\n"));

    return EXIT_SUCCESS;
}