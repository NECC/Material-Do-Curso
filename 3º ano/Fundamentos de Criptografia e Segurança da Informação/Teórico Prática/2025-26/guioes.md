# Guiões das aulas práticas


## Semanas:

 - [Semana 1](S01.md) - Instalação
 - [Semana 2](S02.md) - Cifras Clássicas
 <!--
 - [Semana 3](S03.md) - Cifras Simétricas
 - [Semana 4](S04.md) - Cifra Autenticada
 - [Semana 5](S05.md) - Animação de Modelos de Segurança
 - [Semana 6](S06.md) - Non-interactive Diffie-Hellman
 - [Semana 7](S07.md) - Assinaturas Digitais
 - [Semana 8](S08.md) - Utilização de Certificados
 - [Semana 9](S09.md) - Algoritmo de Shor (pré/pós-processamento clássico)
 - [Semana 10](S10.md) - Algoritmo de Shor (QPF)
 - [Semana 11](S11.md) - Algoritmo Brassard–Høyer–Tapp (BHT)
 - [Semana 7](S07.md) - Assinaturas Digitais e Certificados
 - [Semana 8](S08.md) - Canal TLS
 - [Semana 9](S09.md) - Assinaturas Pós-Quânticas
 - [Semana 10](S10.md) - Algoritmo de Shor (pré/pós-processamento clássico)
 - [Semana 11](S11.md) - Algoritmo de Shor (QPF)
-->

 ---

 ## Instruções para a resolução dos guiões


Os guiões apresentam uma parte descritiva que contextualizam os problemas, e dois tipos de "questão" que devem ser resolvidos pelo grupo de trabalho:

 - **QUESTÃO: Qx** -- questão que deverá ser respondida no ficheiro `Readme.md` referente ao guião(ver abaixo);
 - **PROG: `xxx.py`** -- programa que deve realizar a funcionalidade especificada no guião.

A resolução do guião da `Semana X` deve ser submetida na directoria `Guioes/SX` (em que `X` denota o número da semana), e deve incluir pelo menos:

 1. O Ficheiro `Readme.md`, com a seguinte estrutura:
    - A primeira secção do documento deverá ser dedicado à resposta de questões colocadas no guião. 
    - Uma segunda secção dedicada ao relatório propriamente dito, contendo informação que entendam pertinente sobre a realização do guião (ausências a assinalar; justificação das opções tomadas; instruções de uso; dificuldades encontradas; etc.)
    Assim, a estrutura de um ficheiro `Readme.md` de resposta a um guião será algo como:
    ```Markdown
    # Respostas das Questões
    ## Q1
    Resposta a Q1
    ## Q2
    Resposta a Q2
    ...
    # Relatório do Guião da Semana X
    ... (informação sobre a realização do guião) ...
    ```
 2. Ficheiros com código fonte dos programas solicitados no guião.
    As *scripts* devem poder ser invocadas na linha de comando, de acordo com o descrito nos guiões. Para isso sugere-se que adoptem como *template* das *scripts* algo semelhante a:
    ```Python
    import sys
    # defs auxiliares...
    def main(inp):
        """ função que executa a funcionalidade pretendida... """
        print("Argumentos da linha de comando: ", inp)
    if __name__ == "__main__": # ...se for chamada na linha de comando...
        main(sys.argv)
    ```
 4. Outros ficheiros de suporte (e.g. ficheiros de teste, etc.)

A linguagem de programação assumida nos guiões é o *Python*, mas admite-se que os programas pedidos sejam realizados noutras linguagens. Nesse caso, devem ajustar os nomes dos ficheiros em conformidade.

Dado que parte da avaliação será automatizada, é **muito importante** que se cumpra de forma estrita as indicações do guião, nomeadamente no que respeita:
 - ao nome do programa;
 - os argumentos de "linha de comando" (nome; ordem; significado)
 - formatos dos dados de entrada/saída

---

## ORGANIZAÇÃO DO REPOSITÓRIO

### Arrumação do repositório

Por forma a permitir um acesso ao repositório mais efectivo, devem proceder à seguinte organização de directorias:

```
+-- Readme.md: ficheiro contendo: (i) composição do grupo (número, nome e login github de cada
|              membro); (ii) aspectos que entenderem relevante salientar (e.g. dar nota de
|              algum guião que tenha ficado por realizar ou incompleto; um ou outro guião
|              que tenha sido realizado apenas por um dos membros do grupo; etc.)
+-- Guioes
|        |
|        +-- S02
|        |    +-- Readme.md: resposta às questões colocadas e
|        |    |              notas sobre a realização (justificação das opções
|        |    |              tomadas; instruções de uso; dificuldades encontradas; etc.)
|        |    +-- ...
|        |
|        +-- S03
|        |   ...
...      ...
|
+-- Projs
|       |
|       +-- A88888: projecto individual do aluno ...
|       ...
|
...
```


---
