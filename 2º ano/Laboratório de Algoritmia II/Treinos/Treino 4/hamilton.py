'''

Um ciclo Hamiltoniano num grafo não orientado é um caminho no grafo que passa
uma e uma só vez por cada nó e termina no nó onde começou.

Implemente uma função que calcula o menor (em ordem lexicográfica) ciclo 
Hamiltoniano de um grafo, caso exista. Se não existir deve devolver None.

arestas = [(0,1),(1,2),(0,3),(1,3),(1,4),(2,4),(3,4)]
[0,1,2,4,3]

arestas = [(0,1),(1,2),(0,3),(1,3),(1,4),(2,4)]
None

'''

# 13%
def existeAresta(arestas, a, b):
    return any(map(lambda tup: a in tup and b in tup, arestas))

def extensions(N, vertices, arestas, ls):
    return [x for x in vertices if x not in ls and existeAresta(arestas, ls[-1], x)]

def valid(N, vertices, arestas, ls):
    return existeAresta(arestas, ls[0], ls[-1])

def search(N, verts, arestas, ls, num):
    if num == N:
        return valid(N, verts, arestas, ls)
    
    for x in extensions(N, verts, arestas, ls):
        ls.append(x)
        if search(N, verts, arestas, ls, num+1):
            return True
        ls.pop()
        
    return False

def hamilton(arestas):
    verts = set([x for tup in arestas for x in tup])
    n = len(verts)
    
    for x in verts:
        ls = [x]
        if search(n, verts, arestas, ls, 1):
            return ls

    return None
