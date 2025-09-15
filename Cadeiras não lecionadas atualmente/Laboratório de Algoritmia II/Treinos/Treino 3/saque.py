"""

Um fugitivo pretende atravessar um campo  no mínimo tempo possível (desde o 
canto superior esquerdo até ao canto inferior direito). Para tal só se poderá 
deslocar para a direita ou para baixo. No entanto, enquanto atravessa o campo 
pretende saquear ao máximo os bens deixados por fugitivos anteriores. Neste 
problema pretende-se que implemente uma função para determinar qual o máximo 
valor que o fugitivo consegue saquear enquanto atravessa o campo. 
A função recebe o mapa rectangular defindo com uma lista de strings. Nestas
strings o caracter '.' representa um espaço vazio, o caracter '#' representa 
um muro que não pode ser atravessado, e os digitos sinalizam posições onde há 
bens abandonados, sendo o valor dos mesmos igual ao digito.
Deverá devolver o valor máximo que o fugitivo consegue saquear enquanto 
atravessa o campo deslocando-se apenas para a direita e para baixo. Assuma que 
é sempre possível atravessar o campo dessa forma.

"""

# Programação Dinâmica
def saque(mapa):
    n = len(mapa)
    m = len(mapa[0])
    cache = [[0 for x in range(m + 1)] for x in range(n + 1)]
    
    for y in range(n + 1):
        for x in range(m + 1):
            if x == 0 or y == 0:
                cache[y][x] = 0
            elif mapa[y-1][x-1] == '#':
                cache[y][x] = -1
            elif mapa[y-1][x-1] != '.':
                cache[y][x] = int(mapa[y-1][x-1]) + max(cache[y-1][x], cache[y-1][x-1], cache[y][x-1])
            else:
                cache[y][x] = max(cache[y-1][x], cache[y-1][x-1], cache[y][x-1])
            
    return cache[n][m]
