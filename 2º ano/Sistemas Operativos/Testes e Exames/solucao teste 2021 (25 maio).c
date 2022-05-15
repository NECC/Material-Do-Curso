#include <unistd.h>
#include <sys/types.h>
#include <fcntl.h>
#include <stdio.h>

/*
1. Uma interrupção permite interromper programas, mesmo que estejam num ciclo infinito.Estas podem ser proveniente do hardware ou do software. 
O hardware pode desencadear uma interrupçao a qualquer momento enviando um sinal ao CPU, normalmente pelo bus do sistema. O software pode desencadear
uma interrupção executando uma operação especial chamada sistem call. As interrupções que são geradas pelos dispositivos de hardware têm como
propósito sinalizar o facto de necessitarem de "atenção" do SO. Podem terem recebido dados ou apenas terem completado uma tarefa pedida pelo SO.
As interrupções de software são geradas por programas quando pretendem pedir uma chamada ao sistema para ser executada pelo SO. Podem também serem
causadas por erros dos programas em execução, como a divisão por zero, as interrupções chamadas de traps. Já uma desafectação forçada acontece quando 
o CPU é retirado de um prcoesso cuja fatia de tempo terminou ou se apareceu outro com maior prioridade.

2. O fenómeno de thrashing ocorre quando um processo está ocupado a trocar pages in e out e demora mais tempo na troca do que a executar.
*/

//Grupo 2
int vacinados(int idade,char* regiao[]){
    char reg[8];
    int pipe_fd[2];
    if(pipe(pipe_fd)<0){
        perror("pipe");
        return -1;
    }
    if(fork()==0){
        close(pipe_fd[0]);
        dup2(pipe_fd[1],1);
        close(pipe_fd[1]);
        execlp("grep","grep",idade,NULL); //falta a parte da região
        _exit(1);
    }
    if(fork()==0){
        dup2(pipe_fd[0],0);
        close(pipe_fd[0]);
        close(pipe_fd[1]);
        execlp("wc","wc","-l",NULL); 
        _exit(1);
    }
    return 0;
}

bool vacinado( char*cidadao){
    char reg[8];//guarda os ficheiros com as regiões
    int status, i;
    int p[8];

    for(i=0;i<9;i++){
        if(fork ==0){
            p[i]=getpid();
            int x= execlp("grep", "grep",cidadao,reg[i],NULL);
            _exit(x);
        }
    }
    int status;
    for(int j=0;j<9;j++){
        wait(&status);
        if(WEXITSTATUS(status)==0 && WIFEXITED(status)==1) kill(p[j],SIGKILL);
    }
    return status;
}