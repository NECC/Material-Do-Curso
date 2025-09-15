'''

Implemente uma função que calcula a tabela classificativa de um campeonato de
futebol. A função recebe uma lista de resultados de jogos (tuplo com os nomes das
equipas e os respectivos golos) e deve devolver a tabela classificativa (lista com 
as equipas e respectivos pontos), ordenada decrescentemente pelos pontos. Em
caso de empate neste critério, deve ser usada a diferença entre o número total
de golos marcados e sofridos para desempatar, e, se persistir o empate, o nome
da equipa.

'''

def tabela(jogos):
    golos = {} #  {Nome da Equipa: Diferença de Golos}
    pontos = {} # {Nome da Equipa: Ponto}
    for e1,g1,e2,g2 in jogos:
        if e1 not in golos:
            golos[e1] = 0
            pontos[e1] = 0
        if e2 not in golos:
            golos[e2] = 0
            pontos[e2] = 0
        golos[e1] += (g1-g2)
        golos[e2] += (g2-g1)
        if g1 > g2:
            pontos[e1] += 3
        elif g2 > g1:
            pontos[e2] += 3
        else:
            pontos[e1] += 1
            pontos[e2] += 1
            
    jogos = list(pontos.keys())
    jogos.sort(key=lambda x: (-pontos[x],-golos[x],x))
    return [(x,pontos[x]) for x in jogos]

# Same shit, less code

def tabela(jogos):
    golos = {} #  {Nome da Equipa: Diferença de Golos}
    pontos = {} # {Nome da Equipa: Ponto}
    for e1,g1,e2,g2 in jogos:
        if e1 not in golos:
            golos[e1] = 0
            pontos[e1] = 0
        if e2 not in golos:
            golos[e2] = 0
            pontos[e2] = 0
        golos[e1] += (g1-g2)
        golos[e2] += (g2-g1)
        pontos[e1] += (g1 > g2)*3 + (g1 == g2)
        pontos[e2] += (g2 > g1)*3 + (g1 == g2)
            
    jogos = list(pontos.keys())
    jogos.sort(key=lambda x: (-pontos[x],-golos[x],x))
    return [(x,pontos[x]) for x in jogos]
