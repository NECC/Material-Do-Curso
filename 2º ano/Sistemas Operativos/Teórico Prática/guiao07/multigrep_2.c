#include <sys/stat.h>
#include <sys/wait.h>
#include <sys/types.h>
#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <unistd.h>
#include <signal.h>

/*
Modifique o programa anterior de modo a abortar os processos que demorem mais do que 10 segundos a
executar.
*/

// grep exit status:
// 0 -> found
// 1 -> not found
// >1 -> error

#define T_LIMIT 10

sig_atomic_t *pids;
sig_atomic_t n_files;

void alarm_handler(int signum) {
    write(STDERR_FILENO, "Tempo limite excedido\n", sizeof("Tempo limite excedido\n"));

    for (int i = 0; i < n_files; i++) {
        kill(pids[i], SIGKILL);
    }

    _exit(EXIT_FAILURE);
}

int main(int argc, char* argv[]) {
    int pid, status;
    signal(SIGALRM, alarm_handler);

    if (argc < 3) {
        write(STDERR_FILENO, "Argumentos insuficientes\n", sizeof("Argumentos insuficientes\n"));
        return EXIT_FAILURE;
    }

    alarm(T_LIMIT);

    n_files = argc - 2;
    pids = malloc(n_files * sizeof(sig_atomic_t));

    for (int i = 0; i < n_files; i++) {
        if ((pid = fork()) == 0) {
            // Para forçar o erro
            sleep(T_LIMIT + 1);

            execlp("grep", "grep", argv[1], argv[2+i], NULL);
            write(STDERR_FILENO, "Erro execlp\n", sizeof("Erro execlp\n"));
            _exit(EXIT_FAILURE);
        } else if (pid == -1) {
            write(STDERR_FILENO, "Erro fork\n", sizeof("Erro fork\n"));
            return EXIT_FAILURE;
        }

        pids[i] = pid;
    }

    for (int i = 0; i < n_files; i++) {
        pid_t terminado = wait(&status);

        if (!WEXITSTATUS(status)) {
            for (int j = 0; j < n_files; j++) {
                kill(pids[j], SIGKILL);

                if (pids[j] == terminado) {
                    char buffer[256];
                    int bytes = sprintf(buffer, "\nEncontrado no ficheiro %s\n", argv[2+j]);
                    write(STDOUT_FILENO, buffer, bytes);
                }
            }

            return EXIT_SUCCESS;
        }
    }

    write(STDOUT_FILENO, "A palavra não foi encontrada\n", sizeof("A palavra não foi encontrada\n"));
    return 1;
}