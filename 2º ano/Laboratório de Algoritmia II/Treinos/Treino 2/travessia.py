'''

Implemente uma função que calcula o menor custo de atravessar uma região de
Norte para Sul. O mapa da região é rectangular, dado por uma lista de strings,
onde cada digito representa a altura de cada ponto. Só é possível efectuar 
movimentos na horizontal ou na vertical, e só é possível passar de um ponto
para outro se a diferença de alturas for inferior ou igual a 2, sendo o custo 
desse movimento 1 mais a diferença de alturas. O ponto de partida (na linha
mais a Norte) e o ponto de chegada (na linha mais a Sul) não estão fixados à
partida, devendo a função devolver a coordenada horizontal do melhor
ponto para iniciar a travessia e o respectivo custo. No caso de haver dois pontos
com igual custo, deve devolver a coordenada mais a Oeste.

         MMMM
mapa = ["4563", N
        "9254", N
        "7234", N
        "3231", N
        "3881"] N

travessia(mapa) > (2,10)

         MMMMM
mapa = ["90999", N
        "00000", N
        "92909", N
        "94909"] N
                    
travessia(mapa) > (1,5)

'''

def movimentos(mapa, y, x, N, M, mov, inicio):
    lista = []
    
    dx = [0,-1,1, 0]
    dy = [1, 0,0,-1]
    
    for i in range(4):
        newX = x + dx[i]
        newY = y + dy[i]
        if newX < M and newY < N and newX >= 0 and newY >= 0:
            dif = abs(int(mapa[y][x]) - int(mapa[newY][newX]))
            if dif <= 2:
                lista.append( (newY, newX, mov + 1 + dif, inicio) )
    
    return lista

def travessia(mapa):
    N = len(mapa)
    M = len(mapa[0])
    vis = {}
    orla = []
    for k in range(M):
        orla.append( (0,k,0,k) )
        vis[k] = set()
    result = []
    short = (0, N*M)
    
    for y,x,m,inicio in orla:
        if (x,y) in vis[inicio]:
            continue
        
        vis[inicio].add( (x,y) )
        if y == N-1 and m < short[1]:
            short = (inicio, m)
            
        orla += movimentos(mapa, y, x, N, M, m, inicio)
        
    return short

##########################################################################################
# Exemplo alternativo usando o algoritmo de dijkstra (em teoria deve ser mais eficiente) #
#                         Função movimentos mantém-se igual                              #
##########################################################################################
    
def insert(orla, p): # insert ordenado -> Mete elemento com menor peso (e mais a esquerda) no fim
    y,x,m,inicio = p
    i = 0
    added = False
    
    while i < len(orla) and not added:
        if m > orla[i][2]:
            added = True
            orla.insert(i,p)
        elif m == orla[i][2] and inicio > orla[i][3]:
            added = True
            orla.insert(i,p)
        i+=1
    if not added:
        orla.append(p)
    

def travessia(mapa):
    N = len(mapa)
    M = len(mapa[0])
    vis = {}
    orla = []
    for k in range(M):
        orla.append( (0,k,0,k) )
        vis[k] = set()
    result = []
    short = (0, N*M)
    
    while orla:
        y,x,m,inicio = orla.pop()
        if (x,y) in vis[inicio]:
            continue
        
        vis[inicio].add( (x,y) )
        if y == N-1 and m < short[1]:
            return (inicio, m)
            
        lista = movimentos(mapa, y, x, N, M, m, inicio)
        
        for x in lista:
            insert(orla, x)
        
    return short
