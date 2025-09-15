# 30%

def dist(pac, N, M, mapa):
    queue = [(pac,0)]
    vis = []
    for pos, peso in queue:
        dx = [0,0,1,-1]
        dy = [-1,1,0,0]

        if mapa[pos[1]][pos[0]] == 'G':
            return peso
    
        for i in range(4):
            x = pos[0] + dx[i]
            y = pos[1] + dy[i]
            
            if 0 <= x < M and 0 <= y <= N and mapa[y][x] != '*' and (x,y) not in vis:
                queue.append( ((x,y), peso+1) )
                vis.append((x,y))
    
    return float("inf")

def pacman(mapa):
    pacX, pacY = findPacMan(mapa)
    N = len(mapa)
    M = len(mapa[0])
    result = (0,0,float("-inf")) # x,y,dist
    queue = []
    
    d = 0
    while 0 <= pacX < M and 0 <= pacY-d <= N and mapa[pacY-d][pacX] != '*':
        queue.append((pacX,pacY-d))
        d+=1
    d = 1
    while 0 <= pacX < M and 0 <= pacY+d <= N and mapa[pacY+d][pacX] != '*':
        queue.append((pacX,pacY+d))
        d+=1
    d = 1
    while 0 <= pacX+d < M and 0 <= pacY <= N and mapa[pacY][pacX+d] != '*':
        queue.append((pacX+d,pacY))
        d+=1
    d = 1
    while 0 <= pacX-d < M and 0 <= pacY <= N and mapa[pacY][pacX-d] != '*':
        queue.append((pacX-d,pacY))
        d+=1
    
    for pos in queue:
        distancia = dist(pos,N, M, mapa)
        if distancia > result[2]:
            result = (pos[0],pos[1],distancia)

    return result[0],result[1]

def findPacMan(mapa):
    x = -1
    y = -1
    
    for i in range(len(mapa)):
        for j in range(len(mapa[0])):
            if mapa[i][j] == 'P':
                x = j
                y = i
                break

    return x,y
