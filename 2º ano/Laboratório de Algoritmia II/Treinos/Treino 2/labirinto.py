'''

Implemente uma função que calcula um dos caminhos mais curtos para atravessar
um labirinto. O mapa do labirinto é quadrado e representado por uma lista 
de strings, onde um ' ' representa um espaço vazio e um '#' um obstáculo.
O ponto de entrada é o canto superior esquerdo e o ponto de saída o canto
inferior direito. A função deve devolver uma string com as instruções para
atravesar o labirinto. As instruções podem ser 'N','S','E','O'.

'''

def lados(pos, n, mapa):
    lista = []
    
    if pos[0] > 0 and mapa[pos[1]][pos[0]-1] == ' ' and (pos[2] == "" or pos[2][-1] != 'E'):
        lista.append( (pos[0]-1, pos[1], pos[2] + "O") )
    
    if pos[0] < n-1 and mapa[pos[1]][pos[0]+1] == ' ' and (pos[2] == "" or pos[2][-1] != 'O'):
        lista.append( (pos[0]+1, pos[1], pos[2] + "E") )
        
    if pos[1] > 0 and mapa[pos[1]-1][pos[0]] == ' ' and (pos[2] == "" or pos[2][-1] != 'S'):
        lista.append( (pos[0], pos[1]-1, pos[2] + "N") )
    
    if pos[1] < n-1 and mapa[pos[1]+1][pos[0]] == ' ' and (pos[2] == "" or pos[2][-1] != 'N'):
        lista.append( (pos[0], pos[1]+1, pos[2] + "S") )
    
    return lista

def caminho(mapa):
    n = len(mapa)
    orla = [(0,0, "")]
    
    for pos in orla:
        if pos[0] == n-1 and pos[1] == n-1:
            return pos[2]
            
        orla += lados(pos, n, mapa)
    
    return orla

# Função lados alternativa
def lados(pos, n, mapa):
    lista = []
    dx = [-1 , 1 , 0 , 0 ]
    dy = [ 0 , 0 ,-1 , 1 ]
    lt = ["O","E","N","S"]
    bl = ['E','O','S','N']
    
    for k in range(4):
        newX = pos[0] + dx[k]
        newY = pos[1] + dy[k]
        l = lt[k]
        blacklisted = bl[k]
        
        if n > newX >= 0 and n > newY >= 0 and mapa[newY][newX] == ' ':
            if pos[2] == "":
                lista.append( (newX, newY, pos[2] + l) )
            elif pos[2][-1] != blacklisted:
                lista.append( (newX, newY, pos[2] + l) )
    
    return lista
