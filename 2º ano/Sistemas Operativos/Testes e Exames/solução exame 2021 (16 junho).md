# Exame 2021-july-16

Proposed resolution (uncorrected).

Assessment: [teste](2021-06-16-exame.pdf)

by [Alef Keuffer](https://github.com/Alef-Keuffer)

## PI

<!-- ### PI 1

Um processo bloqueado não está consumindo ciclos de cpu (compare com uma espera ativa), logo são importantes para não desperdiçar recursos do sistema. Um exemplo de um processo em estado bloqueado é quando um em um programa na linguagem c fazemos `read(fd,...)` e `fd` é um file descriptor de um pipe sem dados. -->

### PI 2

While LRU can provide near-optimal performance in theory (almost as good as adaptive replacement cache), it is rather expensive to implement in practice (necessita registar acessos, aproximações ao LRU são usadas).

Windows uses LRU-approximation clock algorithm.

__More in depth:__

LRU's weakness is that its performance tends to degenerate under many quite common reference patterns. For example, if there are N pages in the LRU pool, an application executing a loop over array of N + 1 pages will cause a page fault on each and every access. As loops over large arrays are common, much effort has been put into modifying LRU to work better in such situations. Many of the proposed LRU modifications try to detect looping reference patterns and to switch into suitable replacement algorithm, like Most Recently Used (MRU).

## PII

```c
size_t peakCut(char *argv[]) {
    int fd[2][2];
    pipe(fd[0]);

    if (!fork()) {
        close(fd[0][READ_END]);
        dup2(fd[0][WRITE_END],STDOUT_FILENO);
        close(fd[0][WRITE_END]);
        char path[BUFSIZ];
        pid_t pid;
        if (!(pid = fork()))
            execlp(argv[1],argv[1],&argv[2],NULL);
        snprintf(path,BUFSIZ,"/proc/%ld/memstats",(long)pid);
        execlp("grep","grep","VmPeak",path,NULL);
    }
    close(fd[0][WRITE_END]);
    pipe(fd[1]);
    if (!fork()) {
        dup2(fd[0][READ_END],STDIN_FILENO);
        close(fd[0][READ_END]);
        dup2(fd[1][WRITE_END],STDOUT_FILENO);
        close(fd[1][WRITE_END]);
        execlp("cut","cut","-d\" \"","-f4",NULL);
    }
    close(fd[0][READ_END]);
    close(fd[1][WRITE_END]);
    while (wait(NULL) > 0);
    char buf[BUFSIZ];
    read(fd[1][READ_END],buf,BUFSIZ);
    close(fd[1][READ_END]);
    return atoi(buf);
}

int main(int argc, char *argv[]) {
    size_t mems[10];
    for (int i = 0; i < 10; ++i)
        mems[i] = peakCut(argv);

    size_t total = 0,
           min = mems[0]
           max = mems[0];
    for (int i = 0; i < 10; ++i) {
        total += mems[i];
        min = mems[i] < min ? mems[i] : min;
        max = mems[i] > min ? mems[i] : max;
    }
    size_t ave = total/10;

    char *buf[BUFSIZ];
    int nbytes = snprintf(buf,BUFSIZ,"memoria: %d %d %d\n",min,ave,max);
    write(STDOUT_FILENO,buf,nbytes);
    return 0;
}
```

## PIII

```c
pid_t rpids[100] = {0};
pid_t fpids[100] = {0};
volatile sig_atomic_t crondas = 0;
volatile sig_atomic_t interrupted = 0;
volatile sig_atomic_t timeout = 0;

void hand_int(int signum) {interrupted = 1;}

void hand_alarm(int signum) {
    int crondas_ = 0;
    for (int j = 0; j < 100; ++j) {
        if (fpids[j] != 0)
            ++crondas_;
        if (rpids[j] != 0)
            kill(rpids[j],SIGKILL);
    }
    crondas = crondas_;
    timeout = 1;
}

int main(int argc, char *argv[]) {
    int nrondas = atoi(argv[1]);
    signal(SIGINT,hand_int);
    signal(SIGALRM,hand_alarm);
    for (int i = 0; i < nrondas; ++i) {
        for (int j = 0; j < 100; ++j)
            if (!(rpids[j]=fork()))
                execlp("cmd","cmd",NULL);
        alarm(20);
        pid_t pid;
        while ((pid = wait(NULL)) > 0) {
            for (int j = 0; j < 100; ++j)
                if (rpids[j] == pid) {
                    rpids[j] = 0;
                    fpids[j] = pid;
                }
        }
        if (!timeout)
            pause();
        timeout = 0;
        memset(fpids,0,100);
        memset(rpids,0,100);
        char buf[BUFSIZ];
        int nbytes = snprintf(buf,BUFSIZ,"%d\n",crondas);
        write(STDOUT_FILENO,buf,nbytes);
        if (interrupted)
            break;
    }
    return 0;
}
```
