#include <unistd.h>
#include <sys/wait.h>
#include <stdio.h>

int main() {
    int status;
    pid_t pid;

    for (int i = 1; i <= 10; i++) {
        if (fork() == 0) {
            printf("Filho: %d\n", getpid());
            _exit(i);
        }
    }

    for (int i = 1; i <= 10; i++) {
        pid = wait(&status);
        printf("Terminou o filho: %2d - %d\n", WEXITSTATUS(status), pid);
    }

    printf("Pai: %d\n", getpid());

    return 0;
}