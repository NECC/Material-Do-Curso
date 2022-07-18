# Gestão de Memória

## Background:

A memória (ou memória principal) consiste num grande array de bytes cada um com o seu próprio endereço.
 - A unidade de memória vê apenas um fluxo de endereços de memória e não sabe como são gerados ou para que servem.

Memória e Registos são o único tipo de armazenamento a que o CPU pode aceder diretamente.

- Os programas devem ser trazidos do disco para a memória para ser corridos.
- O CPU, em seguida, recolhe as instruções da memória de acordo com o counter do programa.
- Estas instruções podem causar carregamento/armazenamento adicional de/para endereços de memória específicos.

## Hardware Básico:

A maioria dos CPUs consegue descodificar as instruções e realizar operações simples em registos à taxa de uma ou mais operações por clock cycle.

A memória é acedida pelo memory bus o que pode levar alguns clock cycles do CPU.

A cache encontra-se entre a memória e os registos do CPU. Permite aumentar a velocidade de acesso à memória. 

## Espaço de Memória

`Uniprogramming`: 
- As aplicações correm sempre no mesmo local na memória física;
- As aplicações podem aceder a qualquer endereço físico;
- Não é necessária a proteção da memória uma vez que apenas é executada um aplicação de cada vez.

`Multiprogramming`:
- As aplicações podem correr em diferentes localizações na memória fisica;
- As aplicações não podem aceder a todos os endereções físicos (memória normalmente dividida em duas zonas: 
 (i) sistema operativo, geralmente em memória baixa juntamente com o vetor de interrupt; 
 (ii) processos de utilizador, geralmente em alta memória);

 - A proteção de memória é necessária para prevenir o overlap de endereços entre processos.
 
 ## Proteção de Memória
 
 A proteção de memória é necessária para garantir um funcionamento correto.
  - Proteger os processos do sistema operativo do acesso por processos do utilizador;
  - Proteger processos do utilizador uns dos outros.
 
 A proteção de memória deve ser fornecida pelo hardware.
 - Normalmente, o Sistema Operativo não intervém entre o CPU e os seus acessos à memória devido à consequente penalização de desempenho.

Precisamos de garantir que cada processo tem um espaço separado em memória.
  - Separar o espaço de memória por processo protege os processos uns dos outros e é fundamental para ter múltiplos processos carregados em memória para execução simultânea.
  - Para separar o espaço em memória, precisamos da capacidade de determinar o leque de endereços legais a que o processo pode aceder.

## Registos de base e limites
 
 Um par de registos define o espaço de endereço de um processo:
 - O registo base contém o menor endereço legal da memória fisica.
 - O registo limit especifica o tamanho.
 
 Os utilizadores não têm permissão para alterar os registos base/limite.
 
 Sem esta proteção, qualquer bug poderia levar ao crash de outros programas ou até mesmo do sistema operativo.
 
![imagem](https://user-images.githubusercontent.com/62023102/119243191-789ef200-bb5c-11eb-913f-f349e9e43554.png)


# Espaço de endereçamento lógico vs Espaço de endereçamento físico

O conceito de um espaço de endereço lógico que está ligado a um espaço de endereço físico separado é fulcral para uma gestão adequada de memória.

- `Logical Address`: Endereço gerado pelo CPU;
- `Physical Address`: Endereço visto pela unidade de memória;
 
O conjunto de todos os endereços lógicos gerados por um programa é o espaço de endereço lógico. O conjunto de todos os endereços físicos correspondentes a cada um dos endereços lógicos é o espaço de endereços físicos.

No tempo de compilação e de load, o "esquema" de ligação de endereços gera os mesmos endereços lógicos e físicos.

No tempo de execução, o "esquema" de ligação de endereços gera um endereço lógico e físico diferentes.

# Unidade de Gestão de Memória (MMU - Memory Management Unit)

O dispositivo de hardware que no tempo de execução mapeia endereços lógicos para físicos é chamado de MMU.

- Existem diferentes métodos para completar tal mapeamento.

# Swapping 

## O que acontece se nem todos os processos tiverem espaço na memória?
  - Usa-se uma forma extrema de context switch onde alguns processos em memória são temporariamente trocados da memória para uma backing store.
  - Torna possível que o espaço total de endereços fisicos de todos os processos possa exceder a verdadeira memória física do sistema.

`Backing store` -> Geralmente um disco rápido e grande o suficiente para acomodar cópias de todas as imagens de memória para todos os utilizadores.

- A read queue mantém os processos ready-to-run dos quais têm imagens de mémoria na backing store.

`Dispatcher`-> Verifica se um processo está agendado em memória para executar.
  - Se não estiver e se não houver memória livre nessa região, o dispatcher troca o processo atual em memória pelo processo desejado.
  - O tempo do Context-switch num sistema de swapping é bastante elevado.

 Maior parte do tempo de swap é na verdade tempo de transferência (temos de trocar em ambos out e in)
 - O tempo total de transferência é diretamente proporcional à quantidade de memória trocada.

![imagem](https://user-images.githubusercontent.com/62023102/119259021-22fe3000-bbc4-11eb-8b1c-e88ecd719ed9.png)

### Um processo trocado para a backing store precisa de ser colocado no mesmo endereço fisico de onde foi retirado?

- Não, caso tenha sido usada alocação dinâmica para mudar o relocation register.

### Pode um processo que está à espera de uma operação de I/O ser swapped out?

 - Pode, se usarmos double buffering e a opereção de I/O for executada dentro de buffers do kernel (transferências entre buffers do kernel e buffers de memória de processo, só ocorrem quando o processo é trocado back in.)

## Alocação contígua de memória

Alocação contígua de memória é um método inicial em que cada processo está contido numa única secção contígua de memória.

Um esquema simples é dividir a memória em varías partições de tamanho fixo.
 - Cada partição contém exatamente 1 processo.
 - O grau de multiprogramação está ligado pelo número de partições

A geralização é o esquema de partição variável

-  Cada partição contém na mesma um único processo mas o tamanho da partição é exatamente aquele que o processo precisa.
-  O Kernel mantém uma tabela que indica que partes da memória estão ocupadas e que partes estão disponíveis (memory holes).

## Esquema de Partições de Variáveis

![imagem](https://user-images.githubusercontent.com/62023102/119263057-6b721980-bbd5-11eb-91b9-61bec1995950.png)


# Fragmentação interna

Fragementação interna existe quando a memória alocada a um processo é ligeiramente maior do que memória solicitada.
 - A diferença de tamanhos está relacionada com memória que não é usada que é interna à partição.

É o resultado de tentar evitar o overhead quando se mantém o rasto de pequenos buracos na memória.
  `Exemplo:`
   - Consideremos que temos um buraco na memória para 1000 bytes e o processo que está a pedir essa parte da memória necessita apenas de 998 bytes, cria-se um buraco pequeno que apenas tem espaço para 2 bytes -> é melhor ignorar esse pequeno buraco do que lidar com ele.
   - Um aproximação geral para evitar pequenos espaços na memória é separar a memória fisica em blocos de tamanho fixo e alocar unidades de memória baseado no tamanho de cada bloco.

# Fragmentação Externa

Fragementação externa acontece quando existe espaço suficiente na memória para satisfazer o pedido de alocação, no entanto, o espaço disponível não é contíguo.
  - O armazenamento está fragmentado num número grande de buracos pequenos.
  - No pior caso, podemos ter um espaço de dois em dois processos em toda a memória.
  
Uma possivel solução seria "misturar" (shuffle) a memória para compactar toda a que está livre num único espaço.

- Só é possivel com alocação dinâmica, feita em tempo de execução.
- Pode ser muito dispendioso.

Outra solução possivel seria usar esquemas de alocação de memória não contíguos.
 -`Segmentation` e `Paging` são dois esquemas possíveis.
 
 ## O que é que o programador vê da memória?
 
 A memória é vista como uma coleção de unidades lógicas separadas e de tamanho variável sem nenhuma ordem necessária entre elas.
  1. Programa main
  2. Procedimentos/Funções
  3. Objetos/Métodos
  4. Variáveis locais e globais
  5. Stack
  6. Tabela de Símbolos
  7. Arrays

![imagem](https://user-images.githubusercontent.com/62023102/119263882-cce7b780-bbd8-11eb-8764-35358562fbf5.png)



