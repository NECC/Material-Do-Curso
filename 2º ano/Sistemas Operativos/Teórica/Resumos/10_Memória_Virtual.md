# Memória Virtual:
## Background 

O código precisa de estar em memória para executar, mas raramente se usa um programa inteiro.

- Código para lidar com situações fora do comum é raramente executado.
- Estruturas de dados grandes costumam alocar mais memória do que a que realmente precisam.
- Mesmo que todo o programa seja usado, não é todo necessário ao mesmo tempo.

**Memória Virtual** é uma técnica que permite a execução de processos que não estão totalmente em memória.

 - Resume a memória principal num extremamente grande e uniforme array de armazenamento.
 - Liberta os programadores de preocupações como as limitações da armazenamento em memória.

Executar um processo que não se encontra totalmente em memória tem beneficios para o utilizador e para o Sistema Operativo:
- Permite um menor uso da memória;
- Permite a criação mais eficiente de projetos;
- Menor uso de operações de I/O necessárias para o load ou swaps de processos para a memória;
- Mais programas podem correr de forma concorrente;
- O espaço dos endereços lógicos pode ser mais largo que o espaço dos endereços físicos.

### De memória virtual para memória física

![imagem](https://user-images.githubusercontent.com/62023102/119268848-ab90c680-bbec-11eb-83ff-cad4d82fc9d3.png)

## Demand Pagin 

Esta parte não foi referida nas aulas teóricas, mas pode ser complementar e necessária.

`90-10 rule`: Os programas gastam 90% do seu tempo em 10% do seu código

`Demand Pagin` é uma técnica que carrega uma page em memória apenas quando esta é necessária.

- Evita o uso desnecessário de I/O;
- Menos uso de mémoria e menos uso de I/O;
- Resposta mais rápida;
- Páginas que nunca são acedidas nunca são carregadas na memória física (normalmente essas páginas residem em memória secundária).

## Espaço de endereços virtuais de um processo

Tem a ver com a visão lógica (virtual) de como um processo é guardado em memória.

Tipicamente, um processo começa num determinado endereço lógico (p.e. endereço 0) e existe em memória contígua até ao endereço lógico mais alto permitido.

## Page Fault

`Page fault` ocorre quando o hardware de paging acede a uma página marcada como inválida.
  - Na tradução do endereço pela tabela de pages, o paging hardware irá notar que um bit inválido foi colocado, causando uma trap (exception/fault) no sistema operativo.

O procedimento para resolver uma page fault é simples:

1. Verificar o PCB para determinar se a referência era um acesso legal ou ilegal à memória (se ilegal terminar o processo).

2. Encontrar uma frame livre e moverer a página em falta para essa frame (o carregamento é feito da backing store).

3. Dar reset à tabela de pages para indicar que a página está agora em memória.

4. Repetir a instrução que causou o page fault.

![imagem](https://user-images.githubusercontent.com/62023102/119269439-9e290b80-bbef-11eb-8498-c642c0268da8.png)

## O que acontece se não existir nenhuma frame livre?

Poderá dar-se o caso de não existir nenhuma frame livre para carregar a página pretendida, nesse caso:
  - O sistema operativo poderia dar swap out a um processo, libertando todos as frames que esse processo ocupava.
  - A solução mais comum é `page replacement` (encontra alguma página que não está a ser usada e liberta-a).

`Page replacement` completa a separação entre memória lógica e memória física
- Uma grande memória virtual pode ser fornecida numa memória física mais pequena.
- A mesma página pode ser levada para a memória várias vezes.

Queremos um algoritmo de page replacement que resulte no menor número possível de page faults.

### Como funciona o algoritmo de Page Replacement:

1. Seleciona a página "vítima";
2. Escreve essa página em disco;
3. Traz a página desejada para um novo espaço livre;
4. Atualiza a tabela de páginas.

`Nota`: A transfêrencia de duas páginas é necessária (uma fora || uma dentro)

## FIFO Page Replacement (First-In First-Out)

É um exemplo de um algoritmo de Page Replacement.
A página que vai ser substituída é a mais antiga.

A FIFO queue é usada para seguir a idade das páginas:
- Quando uma página é trazida da memória é inserida na cauda da lista.
- E a página que se encontra na cabeça da lista é a próxima a ser substituida.

![imagem](https://user-images.githubusercontent.com/62023102/119269898-eea16880-bbf1-11eb-9ad7-c4fd0a746484.png)

## LRU Page Replacement (Least Recently Used)

A página que vai ser substituída é aquela que não é utilizada à um maior período de tempo.

- LRU associa a cada página o tempo do seu último uso.
- Geralmente é um bom algoritmo (melhor que o FIFO).

[HOW TO IMPLEMENT LRU PAGE REPLACEMENT ALGORITHM](https://www.geeksforgeeks.org/program-for-least-recently-used-lru-page-replacement-algorithm/)


## Second Chance Page Replacement

Substitui uma página antiga, no entanto, não necessariamente a mais antiga.
 - É semelhante ao FIFO mas usa um bit de referência.

Quando verifica a página na cabeça da lista, também verifica o bit de referência.
  - Se o bit for 0 -> substitui a página
  - Se o bit for 1 -> limpa o bit e move a página para a cauda (é dada uma segunda chance à página)

A página que teve a sorte de ganhar uma segunda chance agora só será substitutida quando todas as páginas à sua frente na queue forem susbtituidas ou lhes for dada também uma segunda chance.
- Se uma página é usada frequentemente, o seu bit de referência é sempre colocado a 1 e essa página nunca será substituída.

Problema: Mover páginas para a cauda da queue é uma operação complexa.

### Exemplo:
![imagem](https://user-images.githubusercontent.com/62023102/119270251-b0a54400-bbf3-11eb-8e89-18cff9634c8a.png)



## Clock Page Replacement

É uma implementação mais eficiente do algoritmo anterior, as páginas são organizadas numa queue circular e existe um apontador que indica qual a próxima página a ser verificada.

Quando é necessário escolher a página que vai ser trocada, o apontador avança até encontrar a página que tem o bit de referência a 0.
 - À medida que avança vai apagando os bits das outras páginas
 - Assim que a página for encontrada, ela é substituida e a nova página é inserida na queue circular na posição que a outra página deixou livre.

### Encontrará sempre uma página ou vamos ter um loop infinit?

- No pior caso, quando todos os bits estão definidos, o ponteiro passa por toda a fila, é dada a cada página uma segunda chance e, em seguida, susbtitui a página inicial. 


### Exemplo:

![imagem](https://user-images.githubusercontent.com/62023102/119270491-c9fac000-bbf4-11eb-985f-ece38e606b47.png)

## NRU Page Replacement (Not Recently Used)

Deixa em memória as páginas que foram usadas recentemente.

Considera-se um bit de acesso (A) e um bit de escrita (W) (definidos quando a página é modificada ou escrita) tornam-se possiveis as seguintes classes (A , W):
1. Class 0 = (0, 0) não foi recentemente usada nem modificada - Melhor escolha para substituir
2. Class 1 = (0, 1) não foi recentemente usada mas foi modificada - A página teria de ser escrita para o disco antes de ser substituída.
3. Class 2 = (1, 0) recentemente usada mas não modificada - Provavelmente será usada novamente dentro de pouco tempo
4. Class 3 = (1, 1) recentemente usada e modifica - Provavelemnte vai ser usada novamente dentro de pouco tempo e ainda seria necessário escrever a página novamente no disco antes de a susbtituir.

A configuração dos bits normalmente é feita pelo hardware.

[How to implement a NRU Algotithm](https://www.geeksforgeeks.org/not-recently-used-nru-page-replacement-algorithm/)

### Algoritmos Diferentes

![imagem](https://user-images.githubusercontent.com/62023102/119270823-8a34d800-bbf6-11eb-81a9-3b003479e4ab.png)

## Alocação de Frames

### Como alocar uma quantidade fixa de memória física entre processos?

- Não podemos alocar mais do que o número total de frames avaliáveis.
- Devemos alocar um número mínimo de frames para manter justo o rácio de page-faults.

`Equal Allocation` -> Alocar uma parte igual para todos os processos:
 - Se existem 100 frames e 2 processos -> 50/50;

`Proportional Allocation` -> Alocar proporcionalmente ao tamanho dos processos:
- Se existem 100 frames e 2 processos, um dos processos tem 20 pages e outro 180 pages -> são dados 10 frames ao primeiro (20/200 x 100) e 90 frames ao segundo (180/200 x 100).

`Priority allocation`-> Usa-se alocação proporcional, mas, em vez de termos em conta o tamanho do processo, temos em conta a sua prioridade.

-  No caso de page-fault, escolhemos um frame desse processo ou a frame de um um processo de lower priority.

## Global Vs Local Replacement

`Global Replacement` -> Permite a um processo selecionar uma frame de todo o conjunto de frames, mesmo aquelas que estão atualmente alocadas a outro processo. (Um processo pode "roubar" uma frame de outro).
 - O tempo de execução do processo pode variar muito, uma vez que o seu comportamento de paginação depende dos outros processos a executar em simultâneo.
 - Resulta numa maior produção do sistema, logo é mais comum.

`Local Replacement`-> Cada processo seleciona apenas do seu próprio conjunto alocado de frames
- Performance mais consistente por processo.
- Pode sobrecarregar a mémoria, mas não permite o uso das pages menos usadas por outros processos

## Thrashing

Thrashing ocorre quando um processo está ocupado a trocar pages in e out e demora mais tempo nessa troca do que a executar.

Se um processo não tem frames suficientes a sua taxa de page-fault é bastante alta.
- Page fault para obter a page que precisa.
- Substitui frames existentes.
- Uma vez que todas as suas páginas estão em uso ativo, rapidamente deve precisar de trazer de volta a página que foi substituída.
- Como consequência, entra-se novamente num estado de page fault (repetidamente) substituindo páginas que vai precisar de ir buscar imediatamente.

Isto leva a uma utlização baixa do CPU.

- O sistema operativo passa maior parte do tempo a fazer swapping para o disco.

Muitas operações de swap acabam por danificar o disco, sendo por isso, recomendados os backups.
