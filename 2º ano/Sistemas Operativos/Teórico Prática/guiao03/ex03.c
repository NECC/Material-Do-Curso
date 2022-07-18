#include <unistd.h>
#include <sys/wait.h>
#include <stdio.h>
#include <stdlib.h>

int main(int argc, char* argv[]) {
    int status;
    pid_t pid;

    for (int i = 1; i < argc; i++) {
        if (fork() == 0) {
            execlp(argv[i], argv[i], NULL);
            fprintf(stderr, "erro no execlp\n");
            _exit(-1);
        }
    }
    
    for (int i = 1; i < argc; i++) {
        pid = wait(&status);
        printf("Executado no processo %d com status %d\n", pid, WEXITSTATUS(status));
    }

    return 0;
}