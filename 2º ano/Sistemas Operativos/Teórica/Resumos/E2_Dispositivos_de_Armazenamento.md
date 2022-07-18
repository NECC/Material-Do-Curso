# Dispositivos de Armazenamento

## Transferência de Dados 

Um unidade de disco é anexada a um computador através de um conjunto de fios chamados de I/O bus
  - EIDE, ATA, SATA, USB, SCSI, etc...

As transferências de dados são levadas a cabo por hardware especial conhecido por controladores. 
- O `host controller` é o controlador na extremidade do computador do bus.
- O `disk controller`é o controlador incorporado em cada disco.

Para realizar um operação de I/O no disco:

- O sistema operativo começa por colocar um comando no host controller;
- O host controller em seguida envia esse comando para o disk controller;
- O disk controller opera o hardware do HDD/SSD para realizar o comando;
- A transferência de dados no HDD/SSD acontece entre a superfície do disco e uma cache incorporada no disk controller;
- A transferência de dados para o host ocorre entre a cache e o host controller.

## Tempos de Latência:

Qualquer operação de I/O é um processo de 5 fases:

- `Queuing time` -> Tempo para o driver do dispostivo processar o pedido.
- `Controller time`-> Tempo para o disk controller levar a cabo o pedido.
- `Seek time`-> Tempo para mover o braço do disco para o cilindro desejado (HDD).
- `Rotational latency`-> Tempo para o setor desejado rodar debaixo da cabeça do disco.
- `Transfer time`-> Tempo para transferir os dados desejados entre a drive e o computador.

Latência do Disco -> dada pela soma de todos os tempos acima. Corresponde ao tempo total entre um pedido e a disponibilização do seu resultado

![imagem](https://user-images.githubusercontent.com/62023102/119241973-2f49a500-bb52-11eb-95da-0822498fba19.png)

## Agendamento do Disco (HDD):

Um pedido I/O especifica várias informações:
  - O tipo de operação (input ou output);
  - Os endereços de disco e de memória para trasnferência;
  - O número de setores a ser transferidos.

O sistema operativo mantém uma fila de pedidos pendentes por disco:
- Quando um pedido é completado, o sistema operativo escolhe qual o próximo pedido a atender.

Como é que o sistema operativo programa a manutenção dos pedidos do disco?
  - Existem imensos algoritmos de otimização.
  - Os algoritmos de otimização apenas fazem sentido quando as queues existem, de outra forma um pedido pendente pode ser executado imediatamente.

## Agendamento do Disco (SSD)

Algoritmos de agendamento de discos concentram-se principalmente em minimizar a quantidade de movimentos da cabeça (ver constituição do HDD na imagem em cima), no entanto os discos SSD não contêm esse mecanismo. 
 - Muitos dos schedulers de SSDs ordenam usando o método de FCFS.
