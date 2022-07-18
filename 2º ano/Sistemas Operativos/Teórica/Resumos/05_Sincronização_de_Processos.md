# Sincronização de Processos

Os processos cooperativos são uns dos quais podem afetar ou podem ser afetados por outros processos a correr ao mesmo tempo no sistema.

 - Estes processos podem partilhar diretamente um endereço lógico ou serem autorizados a partilhar dados atráves de ficheiros ou mensagens.

O acesso concorrente a dados partilhados pode resultar em inconsistência de dados.

- Um processo pode ser interrompido em qualquer ponto, ficando parcialmente completo.
- A manutenção da consistência dos dados requer mecanismos para assegurar a execução ordenada dos processos de cooperação.

## Regiões Críticas e Race Conditions

Uma região critica é um pedaço do código que acede a um recurso partilhado.

- Alterar códigos de variáveis comuns, atualizar uma tabela, escrever um ficheiro.

Quando um processo está a executar numa região crítica, nenhum outro processo pode estar a executar nessa mesma região, isto é, dois processos não podem estar a executar na mesma região critica ao mesmo tempo.
- Isto requer que os processos sejam sincronizados de alguma maneira.

Uma *race condition* ocorre quando vários processos têm permissão para aceder e manipular um recurso partilhado e o resultado depende da ordem em que o acesso ocorre, o que, na maior parte das vezes, leva a um resultado surpreendente e indesejável.

## Problema da Secção Crítica

O objetivo do problema da secção crítica é desenhar um protocolo que os processos possam usar para cooperar:

- Os processos devem pedir permissão para entrar na secção crítica, a *entry section*.
- A região critica deve ser seguida pela *exit section* ou por uma *remainder section* (secção não crítica).

![imagem](https://user-images.githubusercontent.com/62023102/119234360-6bb2dc00-bb25-11eb-8542-2e05cb5b8222.png)

Uma solução para este problema tem de satisfazer 3 requisitos:

 - `Exclusão mútua` - Se um processo estiver a ser executado numa secção crítica, então nenhum outro processo pode ser executado na mesma secção.
 
 - `Progresso` - Se nenhum processo for executado numa secção crítica, então apenas os processos que não estão a executar numa secção restante podem participar na decisão de qual entrará na secção crítica em seguida, e esta decisão não pode ser adiada infinitamente.
 
 - `Espera limitada`- Deve existir um limite no número de vezes que outros processos são autorizados a entrar nas suas secções críticas depois de um processo ter feito um pedido para introduzir a sua secção crítica e antes que esse pedido seja concedido.

No Capítulo [Semáforos](./06_Semáforos.md) podemos ver uma técnica usada para resovler este problema.
