#include <unistd.h>
#include <fcntl.h>
#include <sys/wait.h>

// É uma cópia do ex01 porque esse já faz o necessário para o ex02
int main() {
    char buffer[16];
    ssize_t n_read;

    int pipe_fds[2];
    pipe(pipe_fds);
    int read_fd = pipe_fds[0];
    int write_fd = pipe_fds[1];


    if (fork() == 0) {
        close(write_fd);
        //Temos extremidade de leitura do pipe.
        while (n_read = read(read_fd, buffer, sizeof(buffer))) {
            write(STDOUT_FILENO, buffer, n_read);
        }

        close(read_fd);
        _exit(0);
    }
    
    close(read_fd);

    // Temos extremidade de escrita do pipe.
    char message[] = "O pai está a escrever para o filho\n";
    write(write_fd, message, sizeof(message));

    sleep(2);
    write(write_fd, "Está à espera\n", sizeof("Está à espera\n"));

    close(write_fd);
    wait(NULL);

    return 0;
}