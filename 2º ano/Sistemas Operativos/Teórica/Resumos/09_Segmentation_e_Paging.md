# Segmentation e Paging.

## Segmentation:

Segmentação é um esquema de gestão de memória que satisfaz a visão da memória do programdor.

 - Um espaço de endereços lógicos é uma coleção de segmentos.
 - A cada segmento é dada uma região contigua na memória (com o registo base e limit) que pode residir em qualquer local da memória física.

![imagem](https://user-images.githubusercontent.com/62023102/119264340-aa569e00-bbda-11eb-9c06-1c4bbe12740d.png)


Cada segmento tem um identificador e um tamanho.

Endereçps lógicos (dentro do segmento) existem na forma de tuplos:

```c 
<segment-number, offset-within-segment>
```

A tabela dos segmentos mapeia endereços lógicos de duas dimensões para endereços fisicos de uma dimensão. Cada entrada inclui:
- `Segment base` : Endereço físico inicial onde o segmento reside na memória.
- `Segment limit`: Tamanho do segmento.

![imagem](https://user-images.githubusercontent.com/62023102/119264521-78920700-bbdb-11eb-879f-8644794cd1eb.png)

## Arquitetura de Segmentation

A tabela de Segmentos encontra-se no PCB (Process Control Block). Esta tabela inclui também proteção de dados tais como:
- Validação de Bit (segmento ilegal/legal).
- Privilégios de Ler/escrever/executar/partilhar.

![imagem](https://user-images.githubusercontent.com/62023102/119266280-0a9d0e00-bbe2-11eb-8190-8d5231816d80.png)

# Gestão de Segmentos

Quando um novo processo é carragado em memória:
- Cria-se uma nova tabela de segmento e armazena-se no PCB de processos;
- Aloca-se espaço na memória fisica para todos os segmentos do processo.

Se não houver espaço em memória física:
- Compacta-se a memória (move-se segmentos, atualiza-se as bases) para tornar o espaço contíguo.
- Swap de um ou mais segmentos para fora do disco.

Para aumentar um segmento S:
- Se existe espaço livre em baixo do segmento, só é necessario atualizar o limit do segmento e usar esse espaço livre.
- Caso contrário, mover o segmento S para um espaço livre maior;
- Swap do segmento acima do S para o disco.

![imagem](https://user-images.githubusercontent.com/62023102/119266782-083bb380-bbe4-11eb-9586-3841fb1227fe.png)


# Paging

Tal como a Segmentation, `Paging` é outro esquema de gestão de memória que permite que o espaço do endereço físico de um processo não seja contíguo.

Comparado ao Segmentation, o `Paging`:
- Torna a alocação e o swapping mais fácil (não existem segmentos de tamanho variável);
- Evita fragmentação externa;
- Não é necessária compactação.

Devido a estas vantagens, Paging é usado de várias formas na maioria dos Sistemas Operativos, desde mainframes até aos telemóveis.

A ideia deste esquema é organizar a memória em blocos de tamanho fixo.
 - Dividir a memória lógica em blocos de tamanho fixo chamados `pages`.
 - Dividir a memória física (e a backing store) em blocos do mesmo tamanho chamados `frames`.

Para carregar um processo de N pages, é necessário encontrar N frames livres.
- As pages não têm de ser carregadas num conjunto contíguo de frames.
- É necessário acompanhar as frames livres.

## Modelo de Memória de Paging

Uma tabela de page acompanha todas as pages de um processo em particular.
 - Cada entrada contém o frame correspondente na memória física;
 - Traduz endereços lógicos em endereços físicos.

![imagem](https://user-images.githubusercontent.com/62023102/119267304-de838c00-bbe5-11eb-9b86-43f198d5360b.png)

## Esquema de tradução de endereços

Todos os endereços lógicos são divididos em 2 partes:

- `Page Number (p)` : índice na tabela de pages.
- `Page offset (d)` : deslocamento dentro da page.

O endereço base na tabela de pages combinado com o page offset definem o endereço físico de memória que é enviado para a unidade de memória.

Se o tamanho do espaço do endereço lógico é 2^m e o tamanho da page é 2^n bytes (m > n), então a high-order m-n bits do endereço lógico designa o `page number (p)`, e a lower-order de n bits indica a `page offset (d)`.

![imagem](https://user-images.githubusercontent.com/62023102/119267697-a1b89480-bbe7-11eb-8837-46eb53d09c74.png)


`Nota:` O hardware necessário para suportar paging é relativamente menor que o necessário para a segmentação.

## Implementação de Paging

O sistema operativo intervém 4 vezes na paginação:

1. `Criação do Processo`
 - Determinar o tamanho do programa;
 - Criação da tabela de páginas.

2. `Execução do Processo`
 - Re-inicializar a MMU para o novo processo;
 - Limpar a TLB (Translation lookaside buffer).

3.`Na Page Fault`
 - Determinar o endereço virtual causador da page fault;
 - Colocar a página em memória, se o endereço for legal.

4. `Fim da execução do processo`
 - Libertar a tabela de páginas e as páginas associadas.

## Paginação + Segmentação

É possivel combinar estes dois métodos em dois niveis de mapeamento:

- Processos são vistos como um conjunto de segmentos lógicos de tamanho variável
- Cada segmento é depois dividido em pages de tamanho fixo.

Os endereços lógicos consistem mais uma vez em tuplos:

```c
<segment-number, page_within_segment,offset_within_page>
```

### Implementação 

- Uma tabela de segmentos por processo e uma tabela de paginação por segmento.
- Evita fragmentação externa.

A partilha pode ser dada em ambos os níveis:
 - Partilhar um segmento completo por ter a mesma base em duas tabelas de segmento.
 - Partilhar uma frame por ter a mesma `frame reference` nas duas tabelas de paginação.
