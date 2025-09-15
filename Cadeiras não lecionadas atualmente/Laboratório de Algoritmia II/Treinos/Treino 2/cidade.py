'''

Podemos usar um (multi) grafo para representar um mapa de uma cidade: 
cada nó representa um cruzamento e cada aresta uma rua.
Pretende-se que implemente uma função que calcula o tamanho de uma cidade, 
sendo esse tamanho a distância entre os seus cruzamentos mais afastados.
A entrada consistirá numa lista de nomes de ruas (podendo assumir que os 
nomes de ruas são únicos). Os identificadores dos cruzamentos correspondem a 
letras do alfabeto, e cada rua começa (e acaba) no cruzamento 
identificado pelo primeiro (e último) caracter do respectivo nome.


> ruas = ["raio","central","liberdade","chaos","saovictor","saovicente","saodomingos","souto","capelistas","anjo","taxa"]
> 25


> ruas = ["ab","bc","bd","cd"]
> 4

'''
def caminhos(ruas, origem):
    res = {origem:0}
    orla = [(origem,0)]
    
    while orla:
        dest, tam = orla.pop(0)
        for rua in ruas:
            if dest in rua:
                if dest == rua[0]:
                    prox = rua[1]
                else:
                    prox = rua[0]
                novaDist = rua[2] + tam
                
                if prox not in res:
                    res[prox] = novaDist
                    orla.append( (prox, novaDist) )
                elif res[prox] > novaDist:
                    res[prox] = novaDist
                    orla.append( (prox, novaDist) )
    
    return res

def fixRuas(ruas):
    final = []
    for rua in ruas:
        final.append( (rua[0], rua[-1], len(rua)) )
    return final

def tamanho(ruas):
    ruas = fixRuas(ruas)
    final = {}
    vertices = set(list(map(lambda x: x[0], ruas)) + list(map(lambda x: x[1], ruas)))
    m = -1
    
    for x in vertices:
        final[x] = caminhos(ruas, x)
        for _,y in final[x].items():
            m = max(y,m)
    
    return m

####################################################################################
#         Solução alternativa usando o algoritmo Floyd-Wharshall fornecido         #
####################################################################################

def fw(adj):
    dist = {}
    
    for o in adj:
        dist[o] = {}
        for d in adj:
            if o == d:
                dist[o][d] = 0
            elif d in adj[o]:
                dist[o][d] = adj[d][o]
            else:
                dist[o][d] = float("inf")
    for k in adj:
        for o in adj:
            for d in adj:
                if dist[o][k] + dist[k][d] < dist[o][d]:
                    dist[o][d] = dist[o][k] + dist[k][d] 

    return dist

def fixRuas(ruas):
    adj = {}
    
    for rua in ruas:
        a = rua[0]
        b = rua[-1]
        n = len(rua)
        if a not in adj:
            adj[a] = {}
        if b not in adj:
            adj[b] = {}
        if b not in adj[a]:
            adj[a][b] = float("inf")
        if a not in adj[b]:
            adj[b][a] = float("inf")
        adj[a][b] = min(n, adj[a][b])
        adj[b][a] = min(n, adj[b][a])
    return adj

def tamanho(ruas):
    ruas = fixRuas(ruas)
    dists = fw(ruas)
    m = -1
    
    for k in dists:
        for j in dists[k]:
            x = dists[k][j]
            if x > m:
                m = x
    
    return m
