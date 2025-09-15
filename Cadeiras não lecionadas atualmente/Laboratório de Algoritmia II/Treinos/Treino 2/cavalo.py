'''

O objectivo deste problema é determinar quantos movimentos são necessários para 
movimentar um cavalo num tabuleiro de xadrez entre duas posições.
A função recebe dois pares de coordenadas, que identificam a origem e destino pretendido,
devendo devolver o número mínimo de saltos necessários para atingir o destino a partir da origem.
Assuma que o tabuleiro tem tamanho ilimitado.

'''
################################
#    Solução do David - 13%    #
################################

def saltos(o,d):
    orla = [(o, 0)]
    vis = set()
    
    for pos, mov in orla:
        if pos == d:
            return mov
        
        if pos not in vis:
            vis.add(pos)
        else:
            continue
        
        direcao = find_dir(pos, d)
        orla += gerar_movs(direcao, pos, mov)
    
    return 0

    
def gerar_movs(direcao, orig, m):
    movs = []
    
    (ox, oy) = orig
    
    x = direcao[0]
    y = direcao[1]
    
    movs.append(((ox+(1*x), oy+(2*y)), m+1))
    movs.append(((ox+(2*x), oy+(1*y)), m+1))
    
    if direcao[2] == 1:
        y = (-y)
    else:
        x = (-x)
    
    movs.append(((ox+(1*x), oy+(2*y)), m+1))
    movs.append(((ox+(2*x), oy+(1*y)), m+1))
    
    return movs
    
def find_dir(o,d):
    (ox, oy) = o
    (dx, dy) = d
    direcao = [0,0,0]
    
    direcao[0] = 1 if (dx > ox) else -1
    direcao[1] = 1 if (dy > oy) else -1
    direcao[2] = int(dx*dx < dy*dy)
    
    return direcao

##########################################
#      Minha Solução original - 10%      #
##########################################

def movimentos(x, y, m, movs):
    dx = [1,-1,1,-1,2,2,-2,-2]
    dy = [2,2,-2,-2,-1,1,-1,1]
    
    for i in range(8):
        newX = x + dx[i]
        newY = y + dy[i]
        
        movs.append( ((newX,newY), m+1) )
    
    return movs

def saltos(o,d):
    orla = [(o,0)]
    
    while orla:
        pos,mov = orla.pop(0)
        if pos == d:
            return mov
            
        movimentos(pos[0], pos[1], mov, orla)
    
    return 0
