#include <unistd.h>
#include <sys/wait.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAX_LINE 128

int mysystem(const char *command) {
    int status;

    if (fork() == 0) {
        execl(command, command, NULL);
        _exit(-1);
    } else {
        wait(&status);
        return WEXITSTATUS(status);
    }
}

// ./ex04 "ls -l"
int main(int argc, char* argv[]) {
    int counter, status;
    pid_t pid, arr[argc];

    for (int i = 1; i < argc; i++) {
        if ((arr[i] = fork()) == 0) {
            for (counter = 1; mysystem(argv[i]) != 0; counter++);
            _exit(counter);
        }
    }

    for (int i = 1; i < argc; i++) {
        pid = wait(&status);

        for (int j = 1; j < argc; j++) {
            if (arr[j] == pid) {
                printf("%s correu %d\n", argv[j], WEXITSTATUS(status));
            }
        }
    }

    return EXIT_SUCCESS;
}