"""

Neste problema pretende-se calcular a distância mais curta entre cidades
num mapa. O mapa consiste numa matriz (definida como uma lista de listas) onde
uma letra representa uma cidade e um número uma estrada de largura igual a esse
número. A função a implementar, para além do mapa, da cidade origem, e da
cidade destino, recebe também a largura do veículo em que se pretende
fazer a viagem. Assuma que as cidades dadas existem no mapa, que o mapa está
bem formado, que os carros apenas se deslocam na horizontal e na vertical, e
que numa cidade consegue circular um carro de qualquer largura.

A função deve devolver -1 se não existir caminho entre as duas cidades.
Deve devolver -2 se existir caminho, mas não usando um carro da largura dada.
Noutro caso deve devolver o tamanho do caminho mais curto entre as duas cidades.

'   C43'
'   2 3'
'A33B45'
'5  5  '
'4255  '

"""

def existeCaminho(ori, des, largura, mapa, N, M):
    queue = [(ori[0], ori[1], 0)]
    vis = [ori]
    for x,y,t in queue:
        if (x,y) == des:
            return t
        dx = [-1, 1, 0, 0]
        dy = [ 0, 0,-1, 1]
        for d in range(4):
            newX = x+dx[d]
            newY = y+dy[d]
            if 0 <= newX < N and 0 <= newY < M:
                if (newX, newY) in vis:
                    continue
                if mapa[newY][newX].isalpha():
                    vis.append((newX, newY))
                    queue.append((newX, newY, t+1))
                if mapa[newY][newX].isdigit() and int(mapa[newY][newX]) >= largura:
                    vis.append((newX, newY))
                    queue.append((newX, newY, t+1))
    return -1

def encontraCidades(mapa, N, M):
    lista = []
    for y in range(M):
        for x in range(N):
            if mapa[y][x].isalpha():
                lista.append((x,y))
    return lista

def findCidade(cid, mapa, cidades):
    for x,y in cidades:
        if mapa[y][x] == cid:
            return (x,y)

# Isto está só estúpido, estes loops desnecessários meu deus
def distancia(mapa,tamanho,origem,destino):
    print(mapa)
    existe = -1
    M = len(mapa)
    N = len(mapa[0])
    cidades = encontraCidades(mapa, N, M)
    
    o = findCidade(origem, mapa, cidades)
    d = findCidade(destino, mapa, cidades)
    
    tamanhos = [{} for x in range(tamanho+1)]
    for t in range(tamanho+1):
        tam = tamanhos[t]
        for x in cidades:
            for y in cidades:
                if x == y:
                    continue
                if x not in tam:
                    tam[x] = {}
                if y not in tam:
                    tam[y] = {}
                if x not in tam[y]:
                    tam[y][x] = existeCaminho(x,y,t, mapa, N, M)
                    tam[x][y] = tam[y][x]
                    if x in [o,d] and y in [o,d] and tam[y][x] != -1:
                        existe = -2
                        if tamanho == t:
                            return tam[y][x]
    return existe
