'''

Implemente uma função que calcula o preço mais barato para fazer uma viagem de
autocarro entre duas cidades. A função recebe (para além das duas cidades) uma
lista de rotas de autocarro, onde cada rota é uma sequência de cidades por onde
passa o autocarro, intercalada com o custo para viajar entre cada par de cidades.
Assuma que cada rota funciona nos dois sentidos.

"Fuck grafos, all my homies hate grafos"
'''

def fixRotas(rotas):
    lista = []
    
    for rota in rotas:
        posOrigem = 0
        posDestino = 2
        posPreco = 1
        while posDestino + 1 <= len(rota):
            lista.append([rota[posOrigem],rota[posPreco],rota[posDestino]])
            posOrigem = posDestino
            posDestino += 2
            posPreco += 2
    
    return lista

def viagem(rotas,o,d):
    rotas = fixRotas(rotas)

    caminhos = {o:0} # { destino:preco }
    orla = [(o,0)] # [ (destino, preco) ]
    
    for cid, preco in orla:
        proximos = filter(lambda x: cid in x, rotas)
        for prox in proximos:
            if prox[0] == cid:
                proximoDestino = prox[2]
            else:
                proximoDestino = prox[0]
            novoPreco = preco + prox[1]
                
            if proximoDestino not in caminhos:
                caminhos[proximoDestino] = novoPreco
                orla.append((proximoDestino,novoPreco))
            elif novoPreco < caminhos[proximoDestino]:
                caminhos[proximoDestino] = novoPreco
                orla.append((proximoDestino,novoPreco))

    return caminhos[d]
