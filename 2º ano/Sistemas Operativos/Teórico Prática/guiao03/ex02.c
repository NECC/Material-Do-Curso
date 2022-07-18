#include <unistd.h>
#include <sys/wait.h>
#include <stdio.h>
#include <stdlib.h>

int main() {
    int status;
    pid_t pid = fork();

    if (pid == 0) {
        execlp("ls", "ls", "-l", NULL);
        fprintf (stderr, "erro no execlp\n");
        _exit(-1);
    } else {
        wait(&status);
        printf("Executado no processo %d com status %d\n", pid, WEXITSTATUS(status));
    }

    return 0;
}