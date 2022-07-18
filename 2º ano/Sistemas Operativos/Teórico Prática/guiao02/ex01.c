#include<unistd.h>
#include<sys/wait.h>
#include <stdio.h>

int main() {
    pid_t pid = fork();

    if (pid != 0) {
        printf("Filho: %d\n", pid);
        printf("Pai: %d\n", getpid());
    } else {
        printf("Filho\n");
    }

    return 0;
}