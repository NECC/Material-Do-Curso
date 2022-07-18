#include <sys/stat.h>
#include <sys/wait.h>
#include <sys/types.h>
#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <unistd.h>
#include <signal.h>

/*
Considere o programa grep, que procura ocorrˆencias de uma dada palavra num dado ficheiro. O c ́odigo
de sa ́ıda deste programa  ́e 0 caso encontre ocorrˆencias no ficheiro.
grep "palavra" ficheiro.txt
Implemente o programa multigrep com a mesma funcionalidade, tirando partido do programa grep,
mas que permite ter v ́arios processos a procurar uma dada palavra em v ́arios ficheiros concorrentemente.
Certifique-se de que todos os processos terminam assim que um deles encontre a palavra.
*/

// grep exit status:
// 0 -> found
// 1 -> not found
// >1 -> error

int main(int argc, char* argv[]) {
    int pid, status;

    if (argc < 3) {
        write(STDERR_FILENO, "Argumentos insuficientes\n", sizeof("Argumentos insuficientes\n"));
        return EXIT_FAILURE;
    }

    int n_files = argc - 2;
    int pids[n_files];

    for (int i = 0; i < n_files; i++) {
        if ((pid = fork()) == 0) {
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