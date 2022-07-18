#include <unistd.h>
#include <sys/wait.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAX_ARGS 10

int mysystem(char *command) {
    int status, i = 0;
    char *token, *args[MAX_ARGS];

    for (token = strtok(command, " "); token != NULL; token = strtok(NULL, " ")) {
        args[i++] = token;
    }

    args[i] = NULL;

    if (fork() == 0) {
        execvp(args[0], args);
        _exit(-1);
    } else {
        wait(&status);
        return WEXITSTATUS(status);
    }
}

int mysystem2(const char *command) {
    int status;

    if (fork() == 0) {
        execl("/bin/sh", "sh", "-c", command, NULL);
        _exit(-1);
    } else {
        wait(&status);
        return WEXITSTATUS(status);
    }
}

// ./ex04 "ls -l"
int main(int argc, char* argv[]) {
    if (argc < 2)
        return EXIT_FAILURE;

    printf("status %d\n", mysystem2(argv[1]));
    printf("status %d\n", mysystem(argv[1]));

    return 0;
}