"""

Implemente uma função que dada uma sequência de inteiros, determinar o 
comprimento da maior sub-sequência (não necessariamente contígua) que se 
encontra ordenada de forma crescente.

Sugere-se que comece por implementar uma função auxiliar recursiva que determina 
o comprimento da maior sub-sequência crescente que inclui o primeiro elemento
da sequência, sendo o resultado pretendido o máximo obtido aplicando esta
função a todos os sufixos da sequência de entrada.´

"""

# Programação Dinâmica - 13%
def crescente(lista):
    n = len(lista)
    if n == 0:
        return 0
    cache = [1 for x in range(n+1)]
    cache[0] = 0
    maxSub = 1

    for x in range(2, n+1):
        for y in range(x-1, 0, -1):
            if lista[x-1] >= lista[y-1]:
                cache[x] = max(cache[x], cache[y] + 1)
        
        maxSub = max(maxSub, cache[x])
    
    return maxSub
