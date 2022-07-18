# Ficheiros

Em Unix, tudo são ficheiros, logo a gestão deles é do mais importante do SO, sendo por isso, a primeira primitiva ensinada nas aulas práticas (Guião 1).

## Descritor de Ficheiro

- Representação abstrata de um ficheiro utilizada para operar sobre o mesmo.
- Faz parte da interface POSIX.
- Representado por um inteiro não negativo.
- Pode também servir para representar outros recursos de I/O como pipes, sockets, dispositivos de E/S (p.e. teclado).

### Descritores standard

Os descritores standard são os seguintes:

- 0 -> Standard input -> ``STDIN_FILENO`` em ``<unistd.h>`` -> ``stdin`` em ``<stdio.h>``
- 1 -> Standard output -> ``STDOUT_FILENO`` em ``<unistd.h>`` -> ``stdout`` em ``<stdio.h>``
- 2 -> Standard error -> ``STDERR_FILENO`` em ``<unistd.h>`` -> ``stderr`` em ``<stdio.h>``

**NB**: Estes descritores podem ser redefinidos (Guião 4).

## Estruturas Kernel

### Tabela de Processo (TP)

- Uma tabela por processo.
- Guarda descritores de ficheiros abertos.
- Pode-se usar o comando ``ulimit -n`` em UNIX para saber quantos ficheiros podemos ter abertos.

### Tabela de Ficheiros (TF)

- Tabela partilhada pelo Sistema Operativo.
- Guarda o modo de abertura e a posição de leitura/escrita de cada descritor.

### V-node

- Abstração de um objeto Kernel que respeita a interface de ficheiro UNIX.
- Permite representar ficheiros, diretorias, FIFOs, domain sockets, etc...
- Guarda informação do tipo de objeto, apontadores para as funções sobre o mesmo e para o respetivo i-node.

### I-node

- Guarda metadados/atributos dos ficheiros (p.e. nome do ficheiro, tamanho, ...).
- Guarda localização dos dados no recurso físico de armazenamento.

**NB**: Em Linux, os i-nodes servem também como v-nodes, não havendo uma implementação explícita para os v-nodes.

### Notas:

- Entradas na tabela de ficheiros do sistema podem partilhar i-nodes.
- Descritores de processos distintos (p.e. via ``fork()``) podem partilhar entradas na tabela de ficheiros de sistema.
- Descritores do mesmo processo (p.e. via ``dup()``) podem partilhar entradas na tabela de ficheiros de sistema.


## API

### Open
```c
int open(const char* path, int oflag [, mode]);
```

- Inicializa um descritor para um determinado ficheiro;
- ``path`` -> caminho do ficheiro.
- ``oflag`` -> modo de abertura (``O_RDONLY``, ``O_WRONLY``...).
- ``mode`` -> permissões de acesso para ``O_CREAT``.

#### Valor de Retorno:

- ``>= 0``: um descritor de ficheiro que pode mais tarde ser passado a várias funções para interagir com o ficheiro aberto
- ``= -1``: indica que ocorreu algum erro

#### Flags:

- ``O_RDONLY`` - Abrir apenas para leitura.
- ``O_WRONLY`` - Abrir apenas para escrita.
- ``O_RDWR`` - Abrir para leitura e escrita.

Indicam o modo de abertura do ficheiro e não podem ser misturadas umas com as outras.

As outras flags que podem ser passadas indicam opções:

- ``O_CREAT`` - Cria o ficheiro se ele não existir.
- ``O_APPEND`` - Começa a escrever no fim do ficheiro em vez de no início.
- ``O_TRUNC`` - Apaga todo o conteúdo do ficheiro.

#### Permissões de acesso

Permite especificar as permissões com que o ficheiro deve ser criado, este é o número octal que pode ser passado para o ``chmod`` para especificar as novas permissões do ficheiro.

**NB**: 

- Em C um octal é começado por um 0. [Modos de abertura](https://chmodcommand.com/chmod-0640/)
- Se não forem especificadas permissões aquando da criação do ficheiro, as permissões com que ele é criado também não são especificadas, podendo ser qualquer coisa.

### Read

```c
ssize_t read(int fildes, void *buf, size_t nbyte)
```

- ``fildes`` - Descritor de ficheiro de onde ler.
- ``buf`` - Buffer/array para onde o conteúdo é lido.
- ``nbyte`` - Quantos bytes devem ser lidos no máximo para dentro do buffer.

#### Valor de Retorno:

- ``> 0`` - Indica quantos bytes foram lidos.
- ``= 0`` - Indica que o ficheiro terminou.
- ``= -1`` - Indica que ocorreu algum erro.

### Write:

```c
ssize_t write(int fildes, const void *buf, size_t nbyte);
```

- ``fildes`` - Descritor de ficheiro para onde escrever.
- ``buf`` - Buffer/array onde ir buscar os dados que devem ser escritos.
- ``count`` - Quantos bytes do ``buf`` devem ser escritos.

#### Valor de Retorno:

- ``>= 0`` - Indica quantos bytes foram escritos.
- ``= -1`` - Indica que ocorreu algum erro.

### Close:

```c
int close(int fd);
```

- ``fildes`` - Descritor de ficheiro a fechar

#### Valor de Retorno:

- ``0`` - Se foi fechado com sucesso.
- ``-1`` - Se ocorreu algum erro.

#### Razões para o fazer:

- *Flushing*. Não é garantido que mal um ``write()`` seja executado que o texto seja escrito disco. Ao fechar o ficheiro temos essa garantia.
- Cada processo tem um máximo de descritores de ficheiro que pode ter abertos ao mesmo tempo.

## Posição (offset)

- A cada operação de leitura/escrita efetuada sobre o mesmo descritor, a posição a ler/escrever é atualizada consoante o número de bytes efetivamente lidos/escritos.

## Performance

As *System Calls* ``read`` e ``write`` são das mais lentas e mais utilizadas, pelo que, é necessário ter o cuidado de tentar reduzir o número de vezes que são chamadas.

