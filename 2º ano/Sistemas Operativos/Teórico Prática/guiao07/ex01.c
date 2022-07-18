#include <sys/stat.h>
#include <sys/types.h>
#include <stdio.h>
#include <fcntl.h>
#include <unistd.h>
#include <signal.h>

/*
Usando SIGINT, SIGQUIT e SIGALRM, escreva um programa que v ́a contando o tempo em segundos
desde que comec ̧ou. Se, entretanto, o utilizador carregar em Ctrl+C, o programa dever ́a imprimir o
tempo passado. Se carregar em Ctrl+\ o programa dever ́a indicar quantas vezes o utilizador carregou
em Ctrl+C e terminar de seguida.
*/

sig_atomic_t segundos = 0;
sig_atomic_t sigint_count = 0;

void sigint_handler(int signum) {
    char buffer[64];
    int bytes;

    bytes = sprintf(buffer, "\tPassaram %d segundos.\n", segundos);
    write(STDIN_FILENO, buffer, bytes);

    sigint_count++;
}

void alarm_handler(int signum) {
    segundos++;
    alarm(1);
}

void sigquit_handler(int signum) {
    char buffer[64];
    int bytes;

    bytes = sprintf(buffer, "\n\nTempo total %d segundos\n", segundos);
    write(STDIN_FILENO, buffer, bytes);
    bytes = sprintf(buffer, "O CTRL+C foi utilizado %d vezes\n", sigint_count);
    write(STDIN_FILENO, buffer, bytes);

    _exit(0);
}

int main() {
    signal(SIGINT, sigint_handler);
    signal(SIGALRM, alarm_handler);
    signal(SIGQUIT, sigquit_handler);
    alarm(1);

    while(1);

    return 0;
}