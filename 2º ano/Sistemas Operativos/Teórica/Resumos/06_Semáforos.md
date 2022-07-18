# Semáforos

## Conceito:

Um semáforo é uma ferramenta de sincronização usada para controlar o acesso a um dado recurso constituído por um número finito de instâncias.

### Semáforos são como inteiros, *só que*:
- Não é possível ler ou escrever valores, exceto para defini-lo inicialmente;
- Não utiliza valores negativos (quando um semáforo atinge o 0 todas as instâncias estão a ser usadas, signifcando que todos os processos que desejam usar o recurso ficam bloqueados até que o valor apresentado no semáforo seja maior que 0).

#### Existem 2 tipos de semáforos:

- `Counting semaphore` -> Pode variar sobre um domínio sem restrições.
- `Binary semaphore` -> Que só pode variar entre 0 e 1.

## Operações com Semáforos:

Semáforos são acedidos atráves de duas operações atómicas padrão:
- `Wait()` -> Espera que o semáforo se torne positivo e depois decrementa-o por 1.
- `Signal()` -> Operação que incrementa o semáforo por 1.

```c
wait(semaphore S){
  while ( S == 0); //busy waiting
  S--;
  }
  
  signal(semaphore S){
    S++;
   }
```

# Implementação de Semáforos

A implementação deve garantir que não são executados ao mesmo tempo 2 ``wait()`` e/ou ``signal()``.
  - Operações de ``wait()`` simultâneas não podem descer para valores abaixo de zero.
  - É possível perder um incremento do ``signal()`` se a operação de espera acontecer simultaneamente.

Novamente, existem duas maneiras diferentes para minimizar o tempo de espera.
- Em uniprocessadores através de disabling interrupts.
- Em multiprocessadores através de disabling interrupts e instruções atómicas.

## Implementação de um Semáforo em um uniprocessador

```c
typedef struct {
  int value; // valor do semáforo
  PCB *queue; // queue associada de processos em espera
 } semaphore;
 
 init_semaphore(semaphore S){
    S.value = 0;
    S.queue = EMPTY;
   }
   
   wait(semaphore S){
     // desabilita as interrupções
     if(S.value == 0){
        // evita esperas ativas
        add_to_queue(current PCB, S.queue);
        suspend();
        // o kernel reabilita as interrupções antes de recomeçar aqui
       } 
       else {
         S.value--;
       // habilita as interrupções
      }
    }
    
    signal(semaphore S){
    // desabilita as interrupções
    if(S.queue != Empty){
      // mantém o valor do semáforo e "acorda" um processo em espera
      PCB = remove_from_queue(S.queue);
      add_to_queue(PCB, ready queue);
     }
     else {
      S.value++;
     }
     // habilita as interrupções
    }
```
    
## Implementação de um Semáforo em um multiprocessador

 ```c
 typedef struct{
    boolean guard; // para garantir a atomicidade
    int value;     // valor do semáforo
    PCB *queue;    // queue associada de processos em espera
   } semaphore;

  init_semaphore(semaphore S){
    S.guard = false;
    S.value = 0;
    S.queue = Empty;
   }
   
   wait(semaphore S){
    // desabilita as interrupções
    while (test_and_set(&S.guard)); // tempo de espera ativa curto
    if (S.value == 0){
      add_to_queue(current PCB, S.queue);
      S.guard = false;
      suspend();
      // o kernel reabilita as interrupções antes de recomeçar aqui
     } 
     else {
          S.value--;
          S.guard = false;
         // habilita as interrupções
      }
   }
   
   signal(semaphore S){
      //disable interrupts;
      while(test_and_set(&S.guard)); // tempo de espera ativa curto
      if(S.queue != Empty){
        // mantém o valor do semáforo e "acorda" um processo em espera
        PCB = remove_from_queue(S.queue);
        add_to_queue(PCB, read queue);
       }
       else{
        S.value ++;
       }
       S.guard = false;
      // habilita as interrupções
     }
 ```