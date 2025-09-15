'''

O número de Erdos é uma homenagem ao matemático húngaro Paul Erdos,
que durante a sua vida escreveu cerca de 1500 artigos, grande parte deles em 
pareceria com outros autores. O número de Erdos de Paul Erdos é 0. 
Para qualquer outro autor, o seu número de Erdos é igual ao menor 
número de Erdos de todos os seus co-autores mais 1. Dado um dicionário que
associa artigos aos respectivos autores, implemente uma função que
calcula uma lista com os autores com número de Erdos menores que um determinado 
valor. A lista de resultado deve ser ordenada pelo número de Erdos, e, para
autores com o mesmo número, lexicograficamente.

'''

# O enunciado devia dizer menor ou igual a n ( <= n )
def erdos(artigos,n):
    numeros = {"Paul Erdos" : 0}
    pessoas = ["Paul Erdos"]
    
    for pessoa in pessoas:
        for artigo, autores in artigos.items():
            if pessoa not in autores:
                continue
            for aut in autores:
                if aut not in numeros and aut != pessoa:
                    numeros[aut] = numeros[pessoa] + 1
                    pessoas.append(aut)
        
    pessoas = list(filter(lambda x: numeros[x] <= n, pessoas))
    pessoas.sort(key=lambda x: (numeros[x], x))
    return pessoas