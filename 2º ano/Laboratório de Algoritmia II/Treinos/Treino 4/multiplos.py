'''

Implemente uma função que determina quantas permutações dos n primeiros digitos 
são múltiplas de um dado número d. Por exemplo se n for 3 temos as seguintes 
permutações: 123, 132, 213, 231, 312, 321. Se neste caso d for 3 então todas 
as 6 permutações são múltiplas.

multiplos(3,3)
6

multiplos(5,12)
24

'''

# 13%
def extensions(n, numeros):
    return [x for x in range(1,n+1) if x not in numeros]
    
def complete(n, numeros):
    return len(numeros) == n
    
def valid(n, numeros, d):
    return int("".join(map(str, numeros))) % d == 0
    
def search(n, numeros, d):
    if complete(n, numeros):
        return valid(n, numeros, d)
    
    p = 0
    for x in extensions(n, numeros):
        numeros.append(x)
        p += search(n, numeros, d)
        numeros.pop()
        
    return p

def multiplos(n,d):
    return search(n, [], d)

#########################################
#      Solução estúpida (funciona)      #
#########################################

import itertools

def multiplos(n,d):
    return len(list(filter(lambda x: x % d == 0, list(map(lambda x: int("".join(map(str,x))),itertools.permutations([x for x in range(1,n+1)]))))))
