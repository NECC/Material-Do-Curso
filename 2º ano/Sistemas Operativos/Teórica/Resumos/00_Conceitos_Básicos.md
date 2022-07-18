# O que é um Sistema Operativo?

## Motivação:

- O hardware por si só não é fácil de usar, sendo necessário algum tipo de software.
- Diferentes programas, geralmente requerem operações comuns para operar os recursos de hardware.
- Uma boa ideia seria juntar num único programa as funções comuns para o controlo e alocação dos recursos de hardware.
- Este programa comum é conhecido como Sistema Operativo.

### Como podemos definir um Sistema Operativo ou parte dele?

- Não existe um definição universalmente aceite.
- Uma definição mais restrita seria "Aquele programa que corre o tempo todo num computador", tudo o resto ou é um programa de sistema ou uma aplicação.

#### Um Sistema Operativo é o que gere o hardware do Computador:

- Atua como intermediário entre o utilizador e o hardware.
- Fornece o básico para aplicações.
- Alguns sistemas operativos são projetados para tornar o uso do sistema conveniente, outros para tornar o uso do hardware mais eficiente e outros combinam os dois casos.

## O que devem fazer os Sistemas Operativos?
  
  - Um sistema operativo foi concebido para maximizar a utilização de recursos e para garantir que todo o tempo de CPU, memória e I/O são usados de forma eficiente e justa entre todos os utilizadores.
  
  - O Sistema Operativo é projetado, principalmente, para facilitar a utilização de um sistema, ou seja, contém um maior foco na performance do que na utilização de recursos.
  - Configurado para correr com a mínima, ou até mesmo nenhuma, intervenção do usuário.

### Um Sistema pode ser divido em 4 componentes principais:
  
  - `Hardware:` Os recursos básicos do sistema (CPU, memória, dispositivos I/O, ...);
  - `Sistema Operativo:` Controla e coordena o uso do hardware entre os diferentes programas e utilizadores;
  - `Programas:` Definem a maneira como os recursos do sistema são usados para resolver as necessidades do utilizador (processadores de palavras, browsers, bases de dados, jogos, compiladores);
  - `Utilizadores`.

## Principios de um Sistema Operativo:

### Sistema Operativo como um alocador de recursos/controlador:

  - Atua como um gestor de todos os recursos: Tempo de CPU, espaço em memória, dispositivos I/O.
  - Decide entre pedidos em conflito para um uso de recursos mais eficiente e justo.
  - Previne erros e utilização "imprópria" do computador.
  - Especialmente importante quando muitos utilizadores têm acesso aos mesmos recursos.
  
### Sistema Operativo como um facilitador:
  
  - Fornece serviços que todos precisam.
  - Torna a programação um processo mais fácil, rápido e menos propenso a erros.
  - Especialmente preocupado com a execução de vários programas.
  
### Muitos SO aplicam os princípios anteriores:
  - `Exemplo:` O gestor de ficheiros é necessário para todos os utilizadores (facilitador) e tem de ser eficiente e seguro (controlador).

## Principais Componentes.
  ### Os SO modernos, normalmente, têm como principais componentes os seguintes:
  
  - Gestor de Processos;
  - Gestor de Memória;
  - Gestor de Armazenamento;
  - Gestor de I/O (Input/Output);
    
## Gestor de Processos:
  ### Funções Principais:
    
   - Criar, suspender, resumir e terminar processos (Utilizador/Sistema);
   - Fornecer mecanismos para a comunicação de processos;
   - Fornecer mecanismos para a sincronização de processos;
   - Fornecer mecanismos para a resolução de problemas ligados ao bloqueio de processos;
    
## Gestor de Memória:
   ### Funções Principais:
   
   - Alocar e desalocar espaço na memória conforme for necessário;
   - Rastreio das partes de memória que estão atualmente a ser utilizadas e por quem.
   - Decidir que processos/dados mover para dentro/fora da memória e quando o fazer.

## Gestor de Armazenamento:
   ### Funções Principais:
   
   - Fornece uma visão uniforme (abstrata) e lógica da informação no armazenamento (visão em ficheiros e diretorias lógicas).
   - Apoia `primitivas` para criar, apagar e manipular ficheiros ou diretorias.
   - Apoia o controlo de acesso para determinar quem tem, ou não, acesso a um determinado ficheiro ou diretoria.
   - Mapeamento em suportes de armazenamento secundário.
   
## Gestor de I/O :
   ### Funções Principais:
   
   #### Esconder peculiaridades de dispositivos de hardware do utilizador:
   
   - Geralmente interface dispositivo/driver.
   - Drivers para dispostivos de hardware específicos.

  #### Responsável pela gestão de memória de I/O, incluindo:
  
  - Buffering - Armazenamento temporário de dados enquanto estão a ser transferidos.
  - Catching  - Armazenamento de partes de dados em armazenamento rápido para melhorar a performance.
  - Spooling  - Sobreposição de um output de um processo com o input de outros. 
  
## Serviços Comuns de um SO:

  ### SO fornecem um ambiente para a execução de programas oferecendo, para isso, serviços específicos para programas e para utilizadores
  ![imagem](https://user-images.githubusercontent.com/62023102/119206636-95bbbe00-ba93-11eb-96c6-3fe7e2ed6592.png)
  
  #### Os serviços fornecidos variam entre SO mas existem alguns comuns a todos:
  
  - `Interfaces de Utilizador`: Permitem o funcionamento e controlo eficazes do sistema.
  - `Execução de Programas`: Para carregar um programa em memória e corrê-lo.
  - `Operações de I/O`: Fornece um meio para as operações ligadas a I/O.
  - `Sistema de Ficheiros`: Permite uma manipulação eficaz de ficheiros e diretorias.
  - `Comunicações`: Permite a troca de informação entre processos no mesmo dispositivo ou entre dispositivos.
  - `Deteção de erros`: Para estar constantemente ciente de possíveis erros que podem ocorrer no CPU|Memória|I/O ou programas do utilizador de forma a tomar a ação adequada para assegurar uma computação correta e consistente.

#### Outros Serviços existentes não para proveito do utilizador mas do sistema em si:

-`Alocação de Recursos`: Quando múltiplos processos se encontram a correr de forma concorrente, os recursos disponíveis (CPU/Memória, Armazenamento de Ficheiros, ...) devem ser alocados de forma eficiente para cada um dos processos.

-`Accounting` : Para acompanhar a quantidade e os tipos de recursos utilizados por cada utilizador.

-`Proteção e Segurança`: Para evitar a interferência entre processos concorrentes ou com o próprio SO e proteger o sistema contra "outsiders".

# Multiprogramming
  - Um dos aspetos mais importantes de um SO é a capacidadede de ter múltiplos programas a correr simultaneamente.
  
  - Multiprogramming aumenta a utilização do CPU pela organização de processos para que o CPU possa sempre executar um processo.

## A ideia é a seguinte:

- O SO começa a executar processo a processo ordeiramente;
- Eventualmente, algum processo terá de esperar por alguma tarefa (por exemplo, uma operação I/O);
- Se não existisse multiprogramming, a CPU teria de ficar inativa enquanto esperava.
- Num sistema multiprogramming, o SO troca para outro processo. Quando um processo precisa de esperar por algo, a CPU volta a trocar para outro processo e assim sucessivamente. Eventualmente, o primeiro processo recebe as informação pelas quais se encontrava a aguardar e recupera a CPU.
- Assim sendo, desde que, pelo menos, um processo precise de ser executado a CPU nunca fica inativa.

# Multitasking
  - Multitasking é uma extensão logica de multiprogramming que aumenta o tempo de resposta na qual a CPU troca entre processos, permitindo ao utilizador interagir com o processo enquanto este se encontra a correr.

# Arranque do Sistema
 ## Bootstrap(Firmware):
 É carregado quando se liga ou é dado reboot ao sistema.
 - Inicializa todos os aspetos do sistema;
 - Carrega o Kernel do Sistema Operativo e começa a executá-lo;
 - Estando o Kernel carregado, o sistema pode começar a fornecer serviços ao utilizador.

Completada esta fase, o sistema está completamente iniciado e preparado para a ocorrência de qualquer evento.
# Proteção da CPU

Não podemos permitir que um programa fique "preso" ou falhe e nunca devolva o controlo do sistema ao utilizador. Para evitar isso podemos utilizar um `Timer`;

## Timer:

Pode ser configurado para interromper um processo depois de um certo período de tempo.
Se o timer interromper algum processo, o controlo é transferido de imediato para o SO sendo a interrupção tratada como um "fatal error".

# System Calls

As `System Calls` funcionam como uma interface para os serviços do SO.
São, na maior parte dos casos, acedidas através de uma API em vez de uma chamada direta ao sistema.

## Por que razão é melhor usar uma API ao invés de uma chamada direta ao sistema?
  
  - O mesmo programa deve compilar e correr num outro sistema que suporta essa API.
  - As System Calls podem ser mais detalhas e difícies de trabalhar quando comparadas às API disponiveis para o programador. 

## System Call -> Implementação
  
  Tipicamente, um número é associado a cada System Call, em seguida, esse número é mantido numa tabela indexada de acordo com os números atribuídos a cada System Call.
  
### Exemplos de Tipos de System Calls: 

![imagem](https://user-images.githubusercontent.com/62023102/119208669-2ba71700-ba9b-11eb-9649-5c4199b6b5aa.png)

#### Como podemos ver pela imagem, podem ser agrupadas em 6 categorias:
  - Controlo de Processos;
  - Manipulação de Ficheiros;
  - Manipulação de Dispositivos;
  - Manutenção de informação;
  - Comunicação (Pipes);
  - Proteção;



