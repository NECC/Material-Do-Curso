"""

Implemente uma função que determina qual a probabilidade de um robot regressar 
ao ponto de partida num determinado número de passos. Sempre que o robot dá um 
passo tem uma determinada probabilidade de seguir para cima ('U'), baixo ('D'), 
esquerda ('L') ou direita ('R'). A função recebe o número de passos que o 
robot vai dar e um dicionário com probabilidades de se movimentar em cada uma
das direcções (as chaves são os caracteres indicados entre parêntesis).
O resultado deve ser devolvido com a precisao de 2 casas decimais.

"""
########################################
#      Programação Dinâmica - 11%      #
########################################
def probabilidade(passos,probabilidade):
    probs = {}
    
    # Movimentos possíveis vêm em pares (cima/baixo e esquerda/direita) 
    # porque tem de voltar sempre ao início
    if passos % 2 != 0:
        return 0.0
    
    limInf = -passos//3-2
    limSup = passos//3+2

    for x in range(limInf, limSup):
        for y in range(limInf, limSup):
            probs[0,x,y] = 0.0
    
    probs[0,0,0] = 1.0
    lado = ['L', 'R', 'U', 'D']
    dx = [-1,1,0, 0]
    dy = [ 0,0,1,-1]

    for p in range(1, passos+1):
        for x in range(limInf, limSup):
            for y in range(limInf, limSup):
                probs[p,x,y] = 0.0
                for k in range(4):
                    X = x + dx[k]
                    Y = y + dy[k]
                    if limInf <= X < limSup and limInf <= Y < limSup:
                        antiga = probabilidade[lado[k]]*probs[p-1,X,Y]
                        probs[p,x,y] += antiga
    
    return round(probs[passos,0,0],2)

########################################
#          Memoization - 11%           #
########################################
def aux(p, x, y, probs, cache):
    if p == 0:
        if (x,y) == (0,0):
            return 1
        else:
            return 0
    if (p,x,y) in cache:
        return cache[(p,x,y)]
    a = probs['U'] * aux(p-1, x+1, y, probs, cache)
    b = probs['D'] * aux(p-1, x-1, y, probs, cache)
    c = probs['L'] * aux(p-1, x, y-1, probs, cache)
    d = probs['R'] * aux(p-1, x, y+1, probs, cache)
    cache[(p,x,y)] = a+b+c+d
    return cache[(p,x,y)]

def probabilidade(passos,probs):
    return round(aux(passos, 0, 0, probs, {}),2) if passos % 2 == 0 else 0.0
