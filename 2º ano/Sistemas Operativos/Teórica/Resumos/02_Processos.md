# Processos

## Conceito:

Um Processo é considerado uma unidade de trabalho na maioria dos sistemas e pode ser considerado como um programa em execução.

Um processo necessita de recursos para concretizar as suas tarefas, entre os quais:

- Tempo de CPU;
- Memória;
- Ficheiros;
- Dispositivos de I/O;
- ...

Recursos podem ser alocados para um processo no momento em que este é criado ou enquanto este está a executar.

### Um processo tem múltiplas partes:

- `Secção de Texto` -> Contém o código do programa;
- `Secção de Dados` -> Contém as variáveis globais;
- `Heap` -> Contém memória alocada dinamicamente durante o runtime do processo;
- `Stack`-> Contém dados temporários (parâmetros de funções, endereços de retorno e variáveis locais).

## Programas vs Processos:

### Programa:

Uma entidade passiva (chamada maior parte das vezes de executável) que contém uma lista bem definida de instruções.

### Processo:

Uma entidade ativa correspondente a uma sequência de execução de um programa.

Um programa torna-se um processo quando está carregado na memória.
 - Um programa pode ser um conjunto de vários processos.
 - Dois processos associados com o mesmo programa são considerados duas sequências de execução separadas.

#### Exemplo:

Se o mesmo utilizador abrir várias cópias do programa Firefox:
 - Cada cópia é considerada um processo diferente e embora o código seja equivalente, os dados, a heap e a stack podem variar.

## Estados de um Processo:

À medida que um processo executa, vai mudando o seu estado de acordo com a atividade atual.

Um processo pode ser encontrado num dos seguintes estados:

- `New` -> O processo está a ser criado.
- `Running` -> Instruções estão a ser executadas.
- `Waiting/Blocked` -> O processo está à espera que algo ocorra.
- `Ready` -> O processo está à espera de ser atribuído a um processador.
- `Terminated` -> O processo terminou a sua execução.

É importante perceber que muitos processos podem estar no estado Ready ou Waiting, no entanto, apenas 1 processo pode estar a correr em cada core de cada vez.

![imagem](https://user-images.githubusercontent.com/62023102/119210666-631ac100-baa5-11eb-9adc-37d15dd5f8b5.png)

# Criação de Processos

Durante a sua execução, um processo pode criar vários novos processos.
 - Chama-se ao processo criador "processo pai" e aos processos criados "processos filhos".
 - Cada novo processo originado pelo pai pode criar outros novos processos sendo criada uma "árvore de processos".

A maioria dos SO identifica os processos de acordo com um único `process identifier` (pid), que tipicamente é representado por um inteiro.

- O pid fornece um único valor por cada processo no sistema e pode ser usado como um índice para aceder a vários atributos de um processo.

# Alternativas da criação de Pai/Filho

 ## Partilha de recursos:
 Existem 3 casos possíveis no que toca à partilha de recursos
  - Processos pais e filhos partilham todos os recursos;
  - Processos filhos partilham um subconjunto de recursos dos pais;
  - Processos pais e filhos não partilham qualquer recurso.

## Execução:
Existem 2 casos:
 - Pais e filhos executam de forma concorrente.
 - Pais esperam até que um ou todos filhos acabem de executar.

## Espaço de Endereço:
 - Pais e filhos são duplicados (o filho começa com o programa/dados do processo pai (herança)).
 - O processo filho contém um novo programa carregado dentro dele.

# Quanto "custa" criar um processo?
   Copiar o estado de I/O dos pais (Dispositvos alocados, lista de ficheiros abertos, etc...)
   - Custo médio.
   
   Configurar novas tabelas de memória para o espaço de endereço.
   - Custo elevado.

   Copiar dados do processo pai
   - Originalmente, com um custo muito elevado
   - O custo diminui com a utilização do copy-on-write

# Criação de Processos - Unix/Linux

Em sistemas Unix/Linux, é possivel criar novos processos através da System Call `fork()`;
- O novo processo (filho) consiste numa cópia do endereço do processo original (pai);
- O valor de retorno do `fork()` é zero para o filho e o process identifier (pid) do filho é retornado para o pai;
- Ambos os processos (pai e filho) continuam a execução concorrente das instruções depois do `fork()`;
- Este mecanismo permite ao processo pai comunicar de forma mais fácil com o processo filho.

```c
// código do processo pai antes do fork()
if ((pid = fork()) < 0) {
... // fork falhou
else if (pid == 0){
... // código que o processo filho deve executar
else{
... // código que o processo pai deve executar
}
```

Normalmente depois de um `fork()`, um dos dois processos (pai ou filho) utiliza a System Call `exec()`
 - ```c execl("/bin/ls","ls", NULL); \\ execução do comando ls (fins explicativos)```

## Exec():

Esta System Call substitui o espaço de memória do processo -> texto, dados, heap, stack -> com um novo programa vindo do disco começando a executar este novo programa na sua main, destruindo a imagem anterior do processo. 
 - Desta maneira, pais e filhos são capazes de seguir caminhos diferentes.

# Fim de um processo

Um processo termina a sua execução quando explicitamente o mesmo utliza a System Call `exit()` ou quando executa a última instrução (neste segundo caso, a chamada do `exit()` está implícita pelo uso de ``return`` na main()).

 - Todos os recursos dos processos -> incluindo memória virtual/física, ficheiros abertos e I/O buffers -> são desalocados pelo SO.

Um valor de estado `exit()` (normalmente um inteiro) é disponibilizado ao processo pai atráves de outra System Call -> `wait()`; 

## Um processo pode terminar a sua execução atráves do seu processo pai.
Quando é que isso acontece?
 - O processo filho excedeu o número de recursos alocados.
 - A tarefa atribuída ao processo filho não é mais necessária.
 - Se o processo pai está a dar ``exit()`` o sistema operativo não permite que o processo filho continue a sua execução sem o processo pai (cascading termination).

Se um processo terminou e nenhum processo pai se encontra à espera, esse processo entra num estado conhecido como estado zombie (Zombie Process).
 - Apenas quando o pai chama ``wait()``, o pid do processo zombie e a sua entrada na tabela são lançados.

Se um processo pai terminar antes do seu processo filho, então todos os processos filhos ficam conhecidos como processos órfãos (orphan processes).

 - Nos sistemas Unix os processos órfãos são abordados atribuindo o processo ``init`` como o novo progenitor desses processos.
 - O processo ``init`` periodicamente usa ``wait()``, permitindo a libertação do pid e da entrada na tabela do processo órfão.

Em sistemas Unix, podemos terminar um processo usando a invocação da System Call ``exit()``, fornecendo um status como parâmetro.
 - ``exit(status);``

Para esperar pelo fim do processo filho e obter o exit status, podemos utilizar a System Call ``wait(),`` que também retorna o pid do processo que termina para que o pai seja capaz de dizer qual dos seus filhos é que já terminou a sua execução

  - ``pid = wait(&status)``

![imagem](https://user-images.githubusercontent.com/62023102/119225352-2d082c00-bafb-11eb-8003-9fe458ae8a85.png)

## Forking do comando 'ls' - Unix

```c 
int main(){

 pid_t pid;

 /* criação do processo filho */
 pid = fork();
 
 if(pid < 0) {  /* Ocorreu um erro */
   perror("Fork");
   return 1;
 }
 else if (pid == 0){
      /* Código a ser executado pelo processo filho */
      execlp("/bin/ls", "ls", NULL);
 }
 else { /* Processo pai */
   /* O pai irá esperar pelo processo filho antes de iniciar a sua execução */
   wait(NULL);
   fprintf(stderr, "Fork completed");
 }
 
  return 0;
}
```

# Comunicação entre Processos

Os processos dentro de um sistema podem ser independentes ou cooperar:
 - `Processos Independentes`: Não podem afetar nem ser afetados por outras execuções.
 - `Processos Colaborativos`: Podem ser afetados por outras execuções.

## Principais razões para os processos de cooperação:
 - `Partilha de Informação` -> Acesso concorrente ao mesmo pedaço de informação;
 - `Modularidade`-> Quebrar o cálculo em tarefas mais pequenas que fazem mais sentido;
 - `Speedup` -> Executar tarefas mais pequenas concorrentes de forma paralela.

Para trocarem dados e informação, processos de cooperação precisam de suportar mecanismos de IPC (interprocess communication). Existem dois modelos fundamentais:

 - Troca de mensagens (Message passing) -> Comunicação via enviar/receber mensagens; 
 - Memória Partilhada (Shared Memory) -> A comunicação ocorre simplesmente por ler/escrever para a memória partilhada.

#### NB: 
  Memória Partilha pode levar a problemas de sincronização complexos. No entanto é mais eficiente comparativamente à troca de mensagens.

![imagem](https://user-images.githubusercontent.com/62023102/119226075-6b074f00-baff-11eb-8315-18e178b498e2.png)

