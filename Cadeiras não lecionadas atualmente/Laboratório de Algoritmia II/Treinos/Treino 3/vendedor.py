"""

Um vendedor ambulante tem que decidir que produtos levará na sua próxima viagem.
Infelizmente, tem um limite de peso que pode transportar e, tendo isso em atenção, 
tem que escolher a melhor combinação de produtos a transportar dentro desse limite 
que lhe permitirá ter a máxima receita.

Implemente uma função que, dado o limite de peso que o vendedor pode transportar, 
e uma lista de produtos entre os quais ele pode escolher (assuma que tem à sua 
disposição um stock ilimitado de cada produto), devolve o valor de receita máximo
que poderá obter se vender todos os produtos que escolher transportar, e a lista
de produtos que deverá levar para obter essa receita (incluindo repetições, 
caso se justifique), ordenada alfabeticamente.

Cada produto consiste num triplo com o nome, o valor, e o peso.

Caso haja 2 produtos com a mesma rentabilidade por peso deverá dar prioridade 
aos produtos que aparecem primeiro na lista de entrada.

"""

# Programação Dinâmica
def vendedor(capacidade,produtos):
    n = len(produtos)
    cache = [[(0,[]) for x in range(capacidade + 1)] for y in range(n + 1)]
    
    for i in range(n + 1):
        for peso in range(capacidade + 1):
            if i == 0 or peso == 0:
                cache[i][peso] = 0,[]
            elif peso < produtos[i-1][2]:
                cache[i][peso] = cache[i-1][peso]
            else:
                a = cache[i-1][peso]
                b = cache[i][peso-produtos[i-1][2]]
                c = cache[i-1][peso-produtos[i-1][2]]
                b = b[0] + produtos[i-1][1], b[1] + [produtos[i-1][0]]
                c = c[0] + produtos[i-1][1], c[1] + [produtos[i-1][0]]
                
                cache[i][peso] = max(a,b,c,key = lambda x: x[0])
    
    cache[n][capacidade][1].sort()
    return cache[n][capacidade]

# Memoization - 11.25%
def vendedor(capacidade,produtos):
    cache = {}
    result = aux(capacidade, produtos, cache)
    result[1].sort()
    return result

def aux(capacidade, produtos, cache):
    if capacidade not in cache:
        if capacidade == 0 or produtos == []:
            cache[capacidade] = 0,[]
        elif capacidade < produtos[0][2]:
            cache[capacidade] = aux(capacidade, produtos[1:], cache)
        else:
            b = aux(capacidade - produtos[0][2], produtos, cache)
            c = aux(capacidade - produtos[0][2], produtos[1:], cache)
            a = aux(capacidade, produtos[1:], cache)
            b = b[0] + produtos[0][1], b[1] + [produtos[0][0]]
            c = c[0] + produtos[0][1], c[1] + [produtos[0][0]]
    
            cache[capacidade] = max(b, c, a, key=lambda x: x[0])
    return cache[capacidade]

# Recursiva - 9%
def vendedor(capacidade,produtos):
    result = aux(capacidade, produtos)
    result[1].sort()
    return result
    
def aux(capacidade, produtos):
    if capacidade == 0 or produtos == []:
        return 0,[]
    if capacidade < produtos[0][2]:
        return aux(capacidade, produtos[1:])
        
    a = aux(capacidade, produtos[1:])
    b = aux(capacidade - produtos[0][2], produtos)
    c = aux(capacidade - produtos[0][2], produtos[1:])
    b = b[0] + produtos[0][1], b[1] + [produtos[0][0]]
    c = c[0] + produtos[0][1], c[1] + [produtos[0][0]]
    
    return max(c, b, a, key=lambda x: x[0])
