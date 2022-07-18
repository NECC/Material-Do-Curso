# Thread

## Conceito:

Até agora vimos que que um processo é um programa em execução com um único fio (thread) de execução, o que significa que só pode executar uma tarefa de cada vez.

Sistemas operativos mais modernos extenderam o conceito de processo de modo a permitir que o mesmo tenha acesso a múltiplas threads de execução e assim executar mais do que uma tarefa de cada vez.

- A maioria das aplicações modernas pode ser vista como um conjunto de múltiplas tarefas.
- O processamento de tarefas independentes ou eventos assíncronos podem ser intercalados atribuindo uma thread separada para lidar com cada tarefa ou evento.

## Processos singulares e em multithreading

`Single-threaded` é a abordagem tradicional de uma única thread de execução por processo, em que o conceito de thread não é reconhecido.

`Multithreading` refere-se à habilidade de um sistema operativo suportar múltiplos caminhos simultâneos de execução dentro de um único processo.

![imagem](https://user-images.githubusercontent.com/62023102/119239960-ab3cf080-bb44-11eb-87be-c00bd8956637.png)

## Principais Benefícios:

Existem 4 benefícios na programação multithreaded:

1. `Performance` -> Em geral, é significativamente mais demorado criar e gerir processos do que threads, a criação de threads é mais barata do que a criação de processos e trocar entre threads tem um overhead mais baixo do que trocar entre contextos.

2. `Partilha de Recursos` -> Threads partilham memória por default e os recursos do processo a que pertencem, enquanto vários processos têm de usar mecanismos complexos do sistema operativo para partilhar memória ou outros recursos.

3. `Resposta` -> O multithread de uma aplicação interativa pode permitir que um programa continue a funcionar mesmo que parte dele esteja bloqueada ou esteja a realizar uma operação longa, isto torna-se especialmente importante para as interfaces do utilizador.

4.`Paralelismo` -> Um processo em single-threaded pode correr em apenas um core, independentemente de quantos estejam disponíveis. Em multithreading, as threads podem estar a funcionar em paralelo em diferentes processadores/núcleos de processamento.

## Estados de uma thread

Assim como os processos, os estados-chave para as threads são:

- `Running` -> Instruções estão a ser executadas.
- `Waiting/Blocked` -> A thread está à espera que algum evento ocorra.
- `Ready` -> A thread está à espera de ser atribuída a um processador.

Existem 4 operações básicas que podem alterar o estado de uma thread:

- `Spawn`-> Quando uma nova thread é gerada (A thread é fornecida com o seu próprio contexto e espaço na stack e é colocada na ready queue).
- `Block` -> Quando uma thread precisa de esperar por algum evento que vai ocorrer (a thread guarda o seu contexto de registo e os stack pointers).
- `Unblock`-> Quando o evento pela qual a thread estava a aguardar ocorre (a thread é movida para a ready queue).
- `Finish`-> Quando a trade completa a execução (os registos de contexto e o espaço na stack são libertados).
