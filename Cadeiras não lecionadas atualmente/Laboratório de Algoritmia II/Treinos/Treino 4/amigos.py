'''

Implemente uma função que descubra o maior conjunto de pessoas que se conhece
mutuamente. A função recebe receber uma sequências de pares de pessoas que se
conhecem e deverá devolver o tamanho do maior conjunto de pessoas em que todos
conhecem todos os outros.

'''

def existeAresta(adj, a, b, amigos):
    return amigos[a] in adj[amigos[b]]

def extensions(n, ls, amigos, adj, k, total):
    return [x for x in range(k, total) if total - x + k >= n and all(map(lambda y: y != x and existeAresta(adj, x, y, amigos), ls[1:]))]

def search(n, ls, adj, amigos, k, total):
    if n == k:
        return True

    for x in extensions(n, ls, amigos, adj, k, total):
        ls.append(x)
        if search(n, ls, adj, amigos, k+1, total):
            return True
        ls.pop()

    return False

def amigos(conhecidos):
    amigos = list(set([a for tup in conhecidos for a in tup]))
    adj = {}

    if len(conhecidos) == 0:
        return 0

    for x in amigos:
        adj[x] = set()
    for tup in conhecidos:
        adj[tup[0]].add(tup[1])
        adj[tup[1]].add(tup[0])

    for n in range(len(amigos),2, -1):
        ls = [-1]
        if search(n, ls, adj, amigos, 0, len(amigos)):
            return n
    return 2
