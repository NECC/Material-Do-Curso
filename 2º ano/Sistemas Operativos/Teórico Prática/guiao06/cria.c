#include <unistd.h>
#include <fcntl.h>
#include <sys/wait.h>
#include <sys/types.h>
#include <sys/stat.h>

int main() {
    if (mkfifo("fifo", 0666) == -1) {
        write(STDERR_FILENO, "mkfifo error", sizeof("mkfifo error"));
        return -1;
    }

    return 0;
}