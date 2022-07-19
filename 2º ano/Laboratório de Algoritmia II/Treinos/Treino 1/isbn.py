'''
Pretende-se que implemente uma função que detecte códigos ISBN inválidos. 
Um código ISBN é constituído por 13 digitos, sendo o último um digito de controlo.
Este digito de controlo é escolhido de tal forma que a soma de todos os digitos, 
cada um multiplicado por um peso que é alternadamente 1 ou 3, seja um múltiplo de 10.
A função recebe um dicionário que associa livros a ISBNs,
e deverá devolver a lista ordenada de todos os livros com ISBNs inválidos.
'''

def isbn(livros):
    result = []
    for nome in livros:
        isbn = livros[nome]
        peso = 1
        soma = 0
        for k in map(int,isbn):
            soma += k *peso
            peso = 3 if peso == 1 else 1
        if soma % 10 != 0:
            result.append(nome)
        
    result.sort()
    return result

# Versão mais bonita

def isbn(livros):
    result = []
    for nome in livros:
        isbn = livros[nome]
        pesoUm = sum(map(int,isbn[::2]))
        pesoTres = sum(map(lambda x: int(x)*3,isbn[1::2]))
        soma = pesoUm + pesoTres
        if soma % 10 != 0:
            result.append(nome)
        
    result.sort()
    return result

# PAHAHAHAHAHHAHAHA

def isbn(livros):
    result = list(filter(lambda nome: (sum(map(int,livros[nome][::2])) + sum(map(lambda x: int(x)*3,livros[nome][1::2]))) % 10 != 0, livros))
    result.sort()
    return result
