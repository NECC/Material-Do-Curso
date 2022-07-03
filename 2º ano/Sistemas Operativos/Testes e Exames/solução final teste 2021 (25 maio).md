# Teste 2021-May-25

Proposed resolution (uncorrected).

Assessment: [Teste](2021-05-25-teste.pdf)

by [Alef Keuffer](https://github.com/Alef-Keuffer)

## PII

### PII 1

1. cliente fala com servidor por pipes com nome
2. cliente manda linhas de texto
3. formato mensagem: `⟨nif⟩⟨idade⟩⟨regiao⟩`

Multiple clients may connect to the server, they just need to write their message to `SERVER` fifo, the message must end with `\n` and not with `\0`.

```c
const char *SERVER = "SERVER";
unlink(SERVER);
mkfifo(SERVER,0666);
int SERVER = open(SEVER,O_RDONLY);
while (1) {
    int nbytes = read(SERVER,buf,BUFSIZ);
    assert(nbytes < BUFSIZ);
    buf[nbytes] = 0;
    char **p = &buf;
    for (entry = parse_entry(p); p != NULL; entry = parse_entry(p)) {
        int fd = open(p[0], O_CREAT | O_WRONLY, 0666);
        lseek(fd,0,SEEK_END);
        for (int i = 0; i < 3; ++i) {
            int n = strlen(p[i]);
            write(fd,p[i],n);
            if (i==2)
                write(fd,"\n",1);
        }
        close(fd);
    }
}
close(SERVER);
unlink(SERVER);
```

### PII 2

```c
const int READ_END = 0;
const int WRITE_END = 1;
int fd[2][2];

for (int i = 0; i < 2; ++i) {
    pipe(fd[i]);
    if (fork()) {
        close(fd[i][READ_END])
        continue;
    }
}

if (!fork()) {
    close(fd[READ_END]);
    dup2(fd[WRITE_END],STDOUT_FILENO);
    close(fd[WRITE_END]);
    char idadeStr[10];
    snprintf(idadeStr,10,"\" %d \"",idade);
    execlp("grep","grep",idadeStr,regiao,(char*)NULL);
}
close(fd[WRITE_END]);
char buf[BUFSIZ];
int nbytes = read(fd[READ_END],buf,BUFSIZ);
close(fd[READ_END]);

pipe(fd);
write(fd[WRITE_END],buf,nbytes);
if (!fork()) {
    dup2(fd[READ_END],STDIN_FILENO);
    close(fd[READ_END]);
    dup2(fd[WRITE_END],STDOUT_FILENO);
    close(fd[WRITE_END]);
    execlp("wc","wc","-l",(char*)NULL);
}
close(fd[WRITE_END]);
nbytes = read(fd[READ_END],buf,BUFSIZ);
close(fd[READ_END]);
return atoi(buf);
```

Solution not piping one program to another:

```c
const int READ_END = 0;
const int WRITE_END = 1;
int fd[2];
pipe(fd);

if (!fork()) {
    close(fd[READ_END]);
    dup2(fd[WRITE_END],STDOUT_FILENO);
    close(fd[WRITE_END]);
    char idadeStr[10];
    snprintf(idadeStr,10,"\" %d \"",idade);
    execlp("grep","grep",idadeStr,regiao,(char*)NULL);
}
close(fd[WRITE_END]);
char buf[BUFSIZ];
int nbytes = read(fd[READ_END],buf,BUFSIZ);
close(fd[READ_END]);

pipe(fd);
write(fd[WRITE_END],buf,nbytes);
if (!fork()) {
    dup2(fd[READ_END],STDIN_FILENO);
    close(fd[READ_END]);
    dup2(fd[WRITE_END],STDOUT_FILENO);
    close(fd[WRITE_END]);
    execlp("wc","wc","-l",(char*)NULL);
}
close(fd[WRITE_END]);
nbytes = read(fd[READ_END],buf,BUFSIZ);
close(fd[READ_END]);
return atoi(buf);
```

### PII 3

Possible interpretation, fixed

```c
int in(int q, int n, int v[n]) {
    for (int i = 0; i < n; ++i)
        if (q == v[i])
            return 1;
    return 0;
}

bool vacinado (char *cidadao, int nficheiros, char *ficheiros[nficheiros]) {
    int nchildren = nficheiros;
    pid_t pids[nchildren];
    for (int i = 0; i < nchildren; ++i) {
        if ((pids[i] = fork())) continue;
        execlp("grep","grep",cidadao,ficheiros[i]);
    }
    pid_t fpid[nchildren]; //finished pids
    int status;
    bool hasBeenVaccinated = false;
    for (int j = 0; (fpid[j] = wait(&status)) > 0, ++j) {
        if (WIFEXITED(status) && !WEXITSTATUS(status)) {
            hasBeenVaccinated = true;
            for (int i = 0; i < nchildren; ++i)
                if (!in(pids[i],nchildren,fpid))
                    kill(pids[i],SIGKILL);
        }
    }
    return hasBeenVaccinated;
}
```