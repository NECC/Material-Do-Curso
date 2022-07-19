"""

Um ladrão assalta uma casa e, dado que tem uma capacidade de carga limitada, 
tem que decidir que objectos vai levar por forma a maximizar o potencial lucro. 

Implemente uma função que ajude o ladrão a decidir o que levar.
A função recebe a capacidade de carga do ladrão (em Kg) seguida de uma lista 
dos objectos existentes na casa, sendo cada um um triplo com o nome, o valor de 
venda no mercado negro, e o seu peso. Deve devolver o máximo lucro que o ladrão
poderá  obter para a capacidade de carga especificada.
    
"""

# Recursiva
def ladrao(capacidade,objectos):
    if capacidade == 0 or objectos == []:
        return 0
    if objectos[-1][2] > capacidade:
        return ladrao(capacidade, objectos[:-1])
    a = objectos[-1][1] + ladrao(capacidade - objectos[-1][2], objectos[:-1])
    b = ladrao(capacidade, objectos[:-1])
    return max(a, b)

# Programação Dinâmica
def ladrao(capacidade, objetos):
    n = len(objetos)
    cache = [[0 for x in range(capacidade + 1)] for y in range(n + 1)]
    
    for i in range(n + 1):
        for peso in range(capacidade + 1):
            if i == 0 or peso == 0:
                cache[i][peso] = 0
            elif objetos[i-1][2] > peso:
                cache[i][peso] = cache[i-1][peso]
            else:
                cache[i][peso] = max( objetos[i-1][1] + cache[i-1][peso - objetos[i-1][2]] , cache[i-1][peso])

    return cache[n][peso]
