# Escalonamento de Processos 

## Motivação 

O objetivo de multiprogramming é ter processos a correr o tempo todo, o que maximiza a utilização do CPU.
- Quando um processo tem de esperar, o sistema operativo retira esse processo do CPU e dá-lhe outro processo.

Uma função fundamental de um sistema operativo, sendo também a função básica do multiprogramming, é o `Escalonamento de Processos`.
- Ao escalonar eficientemente o CPU entre vários processos, o sistema operativo pode cobrir mais tarefas e tornar o sistema mais produtivo.

# CPU-I/O Burst Cycle

A execução de um processo pode parecer um ciclo de execução do CPU e tempos de espera e I/O.
![imagem](https://user-images.githubusercontent.com/62023102/119228002-afe3b380-bb08-11eb-8cfc-0d6bff072d0a.png)


# Decisões de Escalonamento:

Decisões de Escalonamento pode ocorrer quando um processo:
 1. Troca do estado de running para o estado de waiting (como resultado de um I/O request);
 2. Troca do estado de waiting para o estado de ready (como resultado de um I/O completion);
 3. Troca do estado de running para o estado de ready (como o resultado de um interrupt);
 4. Simplesmente termina.

O escalonamento escolhe entre todos os processos na Lista de Ready e aloca o CPU para um deles.
 - Quando uma decisão de escalonamento ocorre tendo em conta o ponto 1 e 4 dizemos que o escalonamento é nonpreemptive (ou coperativo);
 - De outra forma, o escalonamento é preemptive.

Escalonamento do tipo preemptive requer hardware especial como, por exemplo, um timer.

# Escalonamento Preemptive

O escalonamento preemptive pode resultar em condições de corrida (isto é, o output depende da sequência de execução de outros eventos incontroláveis).

  - Enquanto que um processo está a atualizar dados, o mesmo é temporariamente interrompido para que um segundo processo possa ocorrer. O segundo processo pode tentar ler os mesmos dados, que podem estar num estado inconsistente.

  - O processo de uma system call pode involver a mudança de alguns dados importantes ao nível do kernel. Se o processo for temporariamente interrompido (preempted) no meio destas mudanças e o kernel precisar de ler ou modificar a mesma estrutura, dá-se um CAOS. 

Uma vez que interrupções podem ocorrer a qualquer momento, essas secções de código devem ser protegidas de acessos concorrentes por vários processos para que essas interrupções sejam desativadas ao entrar nessas secções e apenas reativadas à saida.

# Critérios de Escalonamento

Foram surgeridos vários critérios para comparar algoritmos de escalonamento entre os quais se destacam:

- `Utilização do CPU` -> Manter o CPU o mais ocupado possível;
- `Throughput` -> Número de processos que completa a execução por unidade de tempo;
- `TurnAround/Completion Time` -> Quantidade de tempo necessário para executar um processo (intervalo de tempo desde a submissão e o tempo de conclusão);
- `Tempo de espera` -> Quantidade de tempo que o processo tem de esperar na queue de Ready;
- `Tempo de resposta` -> Quantidade de tempo que demora desde de que o pedido é submetido até à primeira resposta (no output) ser produzida.

Critérios de otimização:
  - Maximizar a utilização do CPU e do Throughput;
  - Minimizar o tempo de execução, o tempo de espera e o tempo de resposta.

# Algoritmo First-Come First-Served (FCFS)

O processo que pede o CPU primeiro é o primeiro a ter o CPU alocado.
  - Fácil de gerir com uma FIFO queue.
  - Quando um processo entra na queue de Ready é ligado ao fim da queue.
  - Quando o CPU estiver livre, é alocado para o primeiro processo da queue de Ready (o processo é removido da queue).

FCFS é nonpreemptive, uma vez que o CPU foi alocado a um processo, esse processo controla o CPU até que o mesmo termine ou necessite de I/O.

 - A média de `turnarround` e tempo de espera é muitas vezes bastante longa.
 - Problemático para os sistemas de partilha de tempo, onde é importante que cada utilizador obtenha uma parte do CPU em intervalos regulares (seria um inferno permitir que um processo mantivesse o CPU por um período prolongado).

## Exemplo:

![imagem](https://user-images.githubusercontent.com/62023102/119229054-f851a000-bb0d-11eb-9481-10a263c9b2fd.png)

![imagem](https://user-images.githubusercontent.com/62023102/119229067-07385280-bb0e-11eb-94de-e0ccea78f288.png)

FCFS -> Média do tempo de espera.

 - (0 + 24 + 27) / 3 = 17 

![imagem](https://user-images.githubusercontent.com/62023102/119229112-46ff3a00-bb0e-11eb-92d7-9913e9870153.png)

FCFS -> Média do tempo de espera 

 - (0 + 3 + 6) / 3 = 3 

# Algoritmo Round Robin (RR) 

Parecido com o FCFS mas com preemption, sendo desenhado para sistemas com partilha de tempo:
- Cada processo ganha um quantum ou uma "fatia" de tempo (pequena unidade de tempo do CPU);
- O temporizador (timer) interrompe cada quantum para agendar o próximo processo, o processo atual é antecipado e adicionado ao final da ready queue (sistema circular);

Se o tempo quantum for Q e houverem N processos na queue de Ready, então cada processo recebe 1/N do tempo do CPU em pedaços de no máximo Q (nenhum processo espera mais do que (N-1) * Q unidades de tempo).

 - Se o Q é grande -> FCFS;
 - Se o Q for pequeno -> O overhead de mudanças de contexto pode ser muito alto degradando os níveis de utilização do CPU.

## Round Robin (RR) com Q = 4 ;

![imagem](https://user-images.githubusercontent.com/62023102/119230533-83ce2f80-bb14-11eb-824f-e7e8b609d69d.png)

RR -> Tempo Médio de Espera

- (6 + 4 + 7) / 3 = 17/3 = 5.66

# Shortest-Job-First(SJF)

Associa cada processo com o tamanho do seu próximo CPU burst e usa estes tamanhos para agendar o processo com o burst mais curto de CPU.

- Se o próximo CPU Burst de dois processos for igual, usa-se o FCFS para quebrar o empate.

SJF é ideal porque dá sempre o tempo mínimo de espera médio para um determinado conjuntos de processos

- Mover o processo mais curto para antes de um longo diminui o tempo de espera do processo mais curto no entanto aumenta o tempo de espera do processo mais longo.
- A dificuldade é saber o tamanho do próximo CPU burst.

![imagem](https://user-images.githubusercontent.com/62023102/119230928-4b2f5580-bb16-11eb-8723-d9b94aebe892.png)

SJF -> Tempo médio de espera

- (0 + 3 + 9 + 16) / 4 = 28 / 4 = 7 

FCFS -> Tempo médio de espera

- (0 + 6 + 14 + 21) / 4 = 41/4 = 10.25

# Escalonamento Prioritário

É associado um número prioritário a cada processo e o CPU é alocado para o processo com a maior prioridade.

- Processos de igual prioridade são escalonados pela ordem de FCFS.
- SJF pode ser visto como um algoritmo de prioridade.

Escalonamento prioritário pode ser:
 - Preemptive, antecipa o CPU se a prioridade de um processo recém chegado é maior que a prioridade do processo atualmente a correr.
 - Non-Preemptive, permite ao processo atual acabar o seu CPU burst.

Principal Problema -> Blocking indefinido ou Starvation.
 - Processos de baixa prioridade podem nunca ser executados e esperar infinitamente.
 - A solução mais comum é o envelhecimento (aging), aumentando a prioridade dos processos pouco a pouco até que acabam por ser executados e terminar.

![imagem](https://user-images.githubusercontent.com/62023102/119231888-e1fe1100-bb1a-11eb-9fa9-f359b0c1cb82.png)

# Multilevel Queue (MLQ)

Divide a read queue em partições gerando várias queues.

- Os processos são permanentemente atribuídos a uma queue, geralmente baseado em alguma propriedade do processo, como tamanho em memória ou prioridade do processo. 

- Cada queue tem o seu próprio algoritmo de escalonamento.

- Cada queue tem prioridade absoluta sobre a queue abaixo dela.

- Cada queue tem um certa quantidade de tempo de CPU que depois é divido entre os processos

![imagem](https://user-images.githubusercontent.com/62023102/119232299-9f3d3880-bb1c-11eb-8f93-543de02476ed.png)
