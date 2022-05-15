#include <unistd.h>
#include <sys/types.h>
#include <fcntl.h>
/*
1.É semelhante ao first come first served mas é preemptive (desafectaçao forçada-> Os processos podem ser retirados do CPU com interrupçoes,
ao fim de um time slice ou se aparecer algum processo com mais prioridade). Neste caso, a ready queque é tratada como uma fila circular, FIFO.
O cpu anda à volta desta fila e ao longo de cada time slice aloca um novo processo. 
Os novos processos sao adicionados à cauda da lista. Se o processo acabar antes deste time slice, o processo liberta o CPU e este processo é 
retirado da lista. Se o processo nao acabar dentro deste time slice, é lançada ao sistema uma interrupçao e é executada uma troca de contexto e
este processo é colocado na cauda da lista. É muito utilizado devido à sua facil implementaçao. 
Melhorias: Dar prioridade a processos I/O e implementar a tatica do aging (à medida que o tempo passa a prioridade aumenta) 

2.Quando temos tabelas de páginas em memória e os registos que guardam a posição e o tamanho da tabela, para cada acesso a um endereço lógico 
implica 2 acessos à memória, um para aceder à tabela de páginas e outro para aceder à posição mapeada. Para resolver este problema, utiliza-se 
cache de mapeamento com memória associativa, ou seja, o translation look-aside buffer(TLB). Este buffer, que dado uma chave(nª de página) devolve 
o valor associado, neste caso o nª de frames. Se a chave existir, é um mecanismo caro, uma vez que apenas guarda algumas associações. No entanto, 
quando o número de página está na cache de TLB, o mapeamento é imediato. Caso contrário, temos que aceder à tabela de páginas e colocar a associação
no TLB, se este estiver cheio é rejeitada outra associação, segundo uma política. O TLB tem um grande impacto na paginação, uma vez que dimunui o 
tempo e não é necessário estar sempre a aceder à tabela de páginas. Temos ainda que o tempo que demora o CPU a aceder ao TLB é menor que o tempo de
aceder à memória principal.Assim sendo, podemos dizer que o TLB é mais rápido e mais pequeno que a memória principal mas maior e mais barato que o 
registo.  O TLB contém apenas as entradas das páginas que são mais acedidas pelo CPU.
*/ 

//Grupo 2
int main(int argc,char* argv[]){
    int file = open(argv[0],O_RDONLY);
    int fd[2];
    if(pipe(fd)<0){
        perror("pipe");
        return -1;
    }
    int count = 0, status; 
    while(read(file,fd[1],10)){ 
        if (count>=10){
            wait(&status); 
            count--;
        }
      count ++; 
      if(fork()==0){
         close(fd[1]);
         char *numero = strkok(fd[0]," ");
         dup2(fd[0],0);       
         close(fd[0]);
         execl("./mail","mail","-s","Sistemas_Operativos",strcat(numero,"@alunos.uminho.pt"),NULL);
         _exit(0);
       }
    }
    close(fd[1]);
    return 0;
}

//Grupo 3 
int main(int args, char *argv[]){
    int fd[2];
    if(pipe(fd)<0){
         perror("pipe");
        return -1;
    }
    char *buffer;
    for (int i=0;i<=8;i++){
        if (fork()==0){
            close(fd[0]);
            dup2(fd[1],1);
            execl("./patgrep","patgrep",argv[1],NULL);
        }
    }
    int status;
    for(int i = 0;i<=8;i++){
        wait(&status);
    }
    close(fd[1]);
    printf("%d\n",strlen(fd[0]));
    close(fd[0]);
    return 0;
}