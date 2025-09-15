'''
Neste problema prentede-se que implemente uma função que calcula o rectângulo onde se movimenta um robot.

Inicialmente o robot encontra-se na posição (0,0) virado para cima e irá receber uma sequência de comandos numa string.
Existem quatro tipos de comandos que o robot reconhece:
  'A' - avançar na direcção para o qual está virado
  'E' - virar-se 90º para a esquerda
  'D' - virar-se 90º para a direita 
  'H' - parar e regressar à posição inicial virado para cima
  
Quando o robot recebe o comando 'H' devem ser guardadas as 4 coordenadas (minímo no eixo dos X, mínimo no eixo dos Y, máximo no eixo dos X, máximo no eixo dos Y) que definem o rectângulo 
onde se movimentou desde o início da sequência de comandos ou desde o último comando 'H'.

A função deve retornar a lista de todas os rectangulos (tuplos com 4 inteiros)

     0
     |
 3 - C - 1
     |
     2

'''

def robot(comandos):
    result = []
    comandosCorrigidos = comandos.split('H')
    if comandos == "":
        comandosCorrigidos = [""]
    elif comandos[-1] == 'H':
        comandosCorrigidos.pop()
    for lista in comandosCorrigidos:
        retangulo = [0,0,0,0] # (Min x, Min y, Max x, Max y)
        posicao = [0,0] # (x,y)
        direcao = 0
        for k in lista:
            if k == 'E':
                direcao = (direcao - 1) % 4
            elif k == 'D':
                direcao = (direcao + 1) % 4
            elif direcao == 0:
                posicao[1] += 1
            elif direcao == 1:
                posicao[0] += 1
            elif direcao == 2:
                posicao[1] -= 1
            elif direcao == 3:
                posicao[0] -= 1
            retangulo = [min(retangulo[0],posicao[0]),min(retangulo[1],posicao[1]),max(retangulo[2],posicao[0]),max(retangulo[3],posicao[1])]
        result.append(tuple(retangulo))
    return result

  # Sem usar split (fica menos confuso ya)
  
  def robot(comandos):
    andar = {0:(1,1), 1:(0,1), 2:(1,-1), 3:(0,-1)}
    result = []
    retangulo = [0,0,0,0] # min x, min y, max x, max y
    posicao = [0,0] # x,y
    direcao = 0
    for character in comandos:
        if character == 'E':
            direcao = (direcao - 1) % 4
        elif character == 'D':
            direcao = (direcao + 1) % 4
        elif character == 'A':
            mov = andar[direcao]
            posicao[mov[0]] += mov[1]
            retangulo = [min(retangulo[0],posicao[0]),min(retangulo[1],posicao[1]),max(retangulo[2],posicao[0]),max(retangulo[3],posicao[1])]
        else:
            result.append(tuple(retangulo))
            retangulo = [0,0,0,0]
            posicao = [0,0]
            direcao = 0
    return result
