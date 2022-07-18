#include <unistd.h>
#include <sys/wait.h>
#include <stdio.h>

int main() {
    execlp("ls", "ls", "-l", NULL);

    printf("Isto nunca será executado");

    return 0;
}