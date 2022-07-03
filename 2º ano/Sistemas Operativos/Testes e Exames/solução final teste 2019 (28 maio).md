# Teste 2021-May-25

Proposed resolution (uncorrected).

Assessment: [Teste](2019-05-28-teste.pdf)

by [Alef Keuffer](https://github.com/Alef-Keuffer)

## PII

```c
int main(int argc, char *argv[]){
    const char *pattern = argv[1];
    const int p[2];
    pipe(p);
    const int PARENT_READ = p[READ_END];
    const int PARENT_WRITE = p[WRITE_END];
    const int fd[8][2];
    const char buf[BUFSIZ];
    const char inp[BUFSIZ];
    const int nbytes = read(STDIN_FILENO,inp,BUFSIZ);
    int bytesLeft = nbytes;
    const int bsize = (nbytes/(128*8) + 1) * 128;


    for (int i = 0; i < 8; ++i) {
        pipe(fd[i]);
        if (fork()) {
            close(fd[i][READ_END]);
            if (bytesLeft > bsize)
                write(fd[i][WRITE_END],inp,bsize);
            else
                write(fd[i][WRITE_END],inp,bytesLeft);
            bytesLeft -= bsize;
            close(fd[i][WRITE_END]);
            continue;
        }
        close(PARENT_READ);
        close(fd[i][WRITE_END]);
        dup2(fd[i][READ_END],STDIN_FILENO);
        close(fd[i][READ_END]);

        dup2(PARENT_WRITE,STDOUT_FILENO);
        execlp("patgrep","patgrep",pattern,(char*)NULL);
    }
    close(PARENT_WRITE);
    while (wait() > 0);
    int n = read(PARENT_READ,buf,BUFSIZ);
    int q = snprintf(buf,n,"%d\n",n);
    write(STDOUT_FILENO,buf,q);
    close(PARENT_READ);
}
```
