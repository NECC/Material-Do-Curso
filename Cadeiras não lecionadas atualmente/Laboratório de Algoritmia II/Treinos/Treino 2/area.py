'''

Implemente uma função que calcula a área de um mapa que é acessível por
um robot a partir de um determinado ponto.
O mapa é quadrado e representado por uma lista de strings, onde um '.' representa
um espaço vazio e um '*' um obstáculo.
O ponto inicial consistirá nas coordenadas horizontal e vertical, medidas a 
partir do canto superior esquerdo.
O robot só consegue movimentar-se na horizontal ou na vertical. 

'''
def visitaveis(pos, visitado, mapa, n):
    orla = []
    # Cima
    for i in range(pos[1]-1, -1, -1):
        if mapa[i][pos[0]] != '.':
            break
        elif not visitado[i][pos[0]]:
            orla.append((pos[0],i))
            
    # Baixo
    for i in range(pos[1]+1, n):
        if mapa[i][pos[0]] != '.':
            break
        elif not visitado[i][pos[0]]:
            orla.append((pos[0],i))
            
    # Esquerda
    for i in range(pos[0]-1, -1, -1):
        if mapa[pos[1]][i] != '.':
            break
        elif not visitado[pos[1]][i]:
            orla.append((i,pos[1]))
            
    # Direita
    for i in range(pos[0]+1, n):
        if mapa[pos[1]][i] != '.':
            break
        elif not visitado[pos[1]][i]:
            orla.append((i,pos[1]))
            
    return orla

def area(p,mapa):
    n = len(mapa)
    visitado = [[False]*n for _ in range(n)]
    acessivel = 0
    orla = [p]
    
    for pos in orla:
        if not visitado[pos[1]][pos[0]]:
            acessivel += 1
        
        visitado[pos[1]][pos[0]] = True
        
        orla += visitaveis(pos, visitado, mapa,n)
    
    
    return acessivel

# Alternativa
def area(p,mapa):
    queue = [p]
    N = len(mapa)
    area = 0

    for posicao in queue:
        area += 1
        dx = [1,-1,0,0]
        dy = [0,0,1,-1]

        for i in range(4):
            x = posicao[0] + dx[i]
            y = posicao[1] + dy[i]
        
            if 0 <= x < N and 0 <= y < N and mapa[y][x] == '.' and (x,y) not in queue:
                queue.append((x,y))

    return area
