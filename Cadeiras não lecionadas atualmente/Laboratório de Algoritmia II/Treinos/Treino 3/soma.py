"""

Implemente uma função que calula qual a subsequência (contígua e não vazia) de 
uma sequência de inteiros (também não vazia) com a maior soma. A função deve 
devolver apenas o valor dessa maior soma.

Sugere-se que começe por implementar (usando recursividade) uma função que 
calcula o prefixo de uma sequência com a maior soma. Tendo essa função 
implementada, é relativamente adaptá-la para devolver também a maior soma de toda
a lista.

"""

# Algoritmo de Kadane (Não percebo a necessidade da sugestão do stor de usar uma função para os prefixos)
# Programação Dinâmica
def maxsoma(lista):
    maxSum = lista[0]
    cache = [maxSum]
    i = 1
    n = len(lista)
    
    for i in range(1,n):
        cache.append(max(cache[i-1] + lista[i], lista[i]))
        maxSum = max(maxSum, cache[i])
        
    return maxSum
