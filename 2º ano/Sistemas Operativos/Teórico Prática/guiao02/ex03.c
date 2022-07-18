#include <unistd.h>
#include <sys/wait.h>
#include <stdio.h>

int main() {
    int status;
    pid_t pid;

    for (int i = 1; i <= 10; i++) {
        if (fork() == 0) {
            printf(
                "Pai:   %d\n"
                "Filho: %d\n",
                getppid(), getpid()
            );
            _exit(i);
        } else {
            pid = wait(&status);
            printf("Terminou o filho: %2d - %d\n\n", WEXITSTATUS(status), pid);
        }
    }

    return 0;
}