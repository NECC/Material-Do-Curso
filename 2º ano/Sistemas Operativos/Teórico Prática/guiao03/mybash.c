#include <unistd.h>
#include <sys/wait.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAX_LINE 128

int mysystem(const char *command) {
    int status;

    if (fork() == 0) {
        execl("/bin/sh", "sh", "-c", command, NULL);
        _exit(-1);
    } else {
        wait(&status);
        return WEXITSTATUS(status);
    }
}

ssize_t readln(int fd, char *line, size_t size) {
    ssize_t i = 0;

    while(read(fd, &line[i], 1) && line[i++] != '\n');
    line[i] = '\0';

    return i;
}

// ./ex04 "ls -l"
// ctrl-d vai gerar EOF logo o n_read será 0
// o & funciona mas é estranho
int main(int argc, char* argv[]) {
    ssize_t n_read;
    char buffer[MAX_LINE] = "";

    do {
        mysystem(buffer);
        write(STDIN_FILENO, "> ", 3);
        n_read = readln(STDIN_FILENO, buffer, MAX_LINE);
    } while (strcmp(buffer, "exit\n") && n_read);

    write(STDIN_FILENO, "\n", 2);

    return EXIT_SUCCESS;
}