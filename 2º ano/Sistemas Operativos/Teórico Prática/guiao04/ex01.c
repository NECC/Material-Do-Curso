#include <unistd.h>
#include <fcntl.h>

int main() {
    char buffer[16];
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

    while (n_read = read(STDIN_FILENO, buffer, sizeof(buffer))) {
        write(STDERR_FILENO, buffer, n_read);
        write(STDOUT_FILENO, buffer, n_read);
    }

    write(term_fd, "terminei\n", sizeof("terminei\n"));

    return 0;
}