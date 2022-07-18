# Pipes

## Contexto:
Pipes foram uns dos primeiros mecanismos de IPC e fornecem uma das formas mais simples para a comunicação entre processos.

Pipes permitem a comunicação num estilo standard (Producer - Consumer):

 - O producer escreve para uma ponta do pipe (the write-end);
 - O consumer lê pela outra ponta do pipe (the read-end);

Os pipes são unidirecionais, apenas permitem comunicação em um sentido.

### NB:
 Se for necessária comunicação nos dois sentidos, devem ser usados dois pipes, onde cada pipe envia dados em direções diferentes.
 
 Pipes podem ser construídos no `terminal` usando o caractere `|`:
  - ``ls | sort``
  - ``cat fich.txt | grep xpto``

# Pipes - UNIX

Em sistemas Unix, os pipes são criados pela System Call ``pipe()``;
  ```c
  int pipe(int fd[2]);
  ```
A System Call ``pipe()`` cria um novo pipe e inicia fd[2] com os seguintes descritores:
 - fd[0] é o read-end do pipe.
 - fd[1] é o write-end do pipe.

Em Unix os pipes são tratados como um tipo de ficheiro especial, o que permite o acesso aos mesmos usando as comuns System Calls ``read()`` e ``write()``;

![Imagem1](https://user-images.githubusercontent.com/62023102/119226666-33e66d00-bb02-11eb-8d81-6de704d5044c.png)

# Forking de um Pipe

Um pipe não pode ser acedido fora do processo que o criou.

 - Tipicamente, um processo pai cria um pipe e usa-o para comunicar com o processo filho que é criado via ``fork()``;
 - Como o pipe é considerado um tipo de ficheiro especial, o processo filho herda o pipe do processo pai.

![imagem](https://user-images.githubusercontent.com/62023102/119226751-a9523d80-bb02-11eb-9924-58f592eea9f2.png)

# Pipe de Pai para Filho

Depois de um fork, podemos decidir a direção do fluxo dos dados dentro do pipe.

 - Num pipe de Pai-Filho, o progenitor fecha a extremidade de leitura (read-end) do pipe fd[0] e o filho fecha a extremidade de escrita (write-end) fd[1].

 - A Leitura a partir de um pipe aberto (i.e pelo menos um dos processos tem fd[1] aberto) bloqueia-o enquanto este se encontra vazio.

![imagem](https://user-images.githubusercontent.com/62023102/119226933-7b212d80-bb03-11eb-8590-cd7e1e216fe7.png)


# Comunicação por Pipes - UNIX

```c
#define BUFFER_SIZE 25
#define READ_END 0
#define WRITE_END 1

int main(void){
  char write_msg[BUFFER_SIZE] = "Folks";
  char read_msg[BUFFER_SIZE];
  int fd[2];
  pid_t pid;
  
  /* Criação do pipe */
  if(pipe(fd) == -1){
    perror("Creating pipe");
    return 1;
  }
  
  /* Fork do processo filho */
  pid = fork();
  
  if (pid < 0){ /* Ocorreu um erro */
    perror("Creating child");
    return 1;
   }
   
   if (pid > 0) { 
   /* Processo pai */
   /* Fecho do fim inutilizado do pipe */
   close(fd[READ_END]);
   
   /* Escrita no pipe */
   write(fd[WRITE_END]), write_msg , strlen(write_msg)+1);
   
   /* Fecho do final escrito do pipe */
   close(fd[WRITE_END]);
  }
  else{
   /* Processo filho */
   /* Fecho do fim inutilizado do pipe */
   close(fd[WRITE_END]);
   
   /* Leitura do pipe */
   read(fd[READ_END], read_msg, BUFFER_SIZE);
   
   /* Fecho do final escrito do pipe */
   close(fd[READ_END]);
  }

  return 0;
 }

