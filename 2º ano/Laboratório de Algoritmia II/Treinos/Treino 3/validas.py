"""

Um exemplo de um problema que pode ser resolvido de forma eficiente com 
programação dinâmica consiste em determinar, dada uma sequência arbitrária de 
números não negativos, se existe uma sub-sequência (não necessariamente contígua) 
cuja soma é um determinado valor. Implemente uma função que dado um valor e uma
listas de listas de números não negativos, devolva a lista com as listas com uma
sub-sequência cuja soma é o valor dado.

"""

def temSoma(soma, lista):
    print(lista)
    n = len(lista)
    cache = [[False for x in range(soma+1)] for x in range(n+1)]
    
    for i in range(n+1):
        cache[i][0] = True
    
    for i in range(1, n+1):
        for s in range(1, soma+1):
            if s < lista[i-1]:
                cache[i][s] = cache[i-1][s]
            else:
                cache[i][s] = cache[i-1][s] 
                if not cache[i][s]:
                    cache[i][s] = cache[i-1][s-lista[i-1]]
                    if cache[i][s]:
                        cache[i][s] = cache[i][s-lista[i-1]]

    return cache[n][soma]

def validas(soma,listas):
    return list(filter(lambda x: temSoma(soma, x), listas))
