"""

Implemente uma função que, dada uma frase cujos espaços foram retirados, 
tenta recuperar a dita frase. Para além da frase (sem espaços nem pontuação), 
a função recebe uma lista de palavras válidas a considerar na reconstrução 
da dita frase. Deverá devolver a maior frase que pode construir inserindo
espaços na string de entrada e usando apenas as palavras que foram indicadas 
como válidas. Por maior entende-se a que recupera o maior prefixo da string
de entrada. Só serão usados testes em que a maior frase é única.


"""

# Programação Dinâmica - 10%
def espaca(frase,palavras):
    n = len(frase)
    cache = ["" for x in range(n+1)]
    
    for x in range(n):
        for y in range(x+1, n+1):
            pal = frase[x:y]
            if pal in palavras:
                ant = cache[x]
                if x != 0 and not ant:
                    continue
                if not cache[y]:
                    cache[y] = ant + " "*(ant != "") + pal

    return cache[n]
