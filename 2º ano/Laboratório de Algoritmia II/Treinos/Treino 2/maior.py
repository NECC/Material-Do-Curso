'''

O objectivo deste problema é determinar o tamanho do maior continente de um planeta.
Considera-se que pertencem ao mesmo continente todos os países com ligação entre si por terra. 
Irá receber uma descrição de um planeta, que consiste numa lista de fronteiras, onde cada fronteira
é uma lista de países que são vizinhos entre si. 
A função deverá devolver o tamanho do maior continente.

'''

def maior(vizinhos):
    paises = [] # Lista de paises sem repetiçoes
    for f in vizinhos:
        for p in f:
            if p not in paises:
                paises.append(p)
            
    continentes = []
    
    for pais in paises:
        lista = []
        for x in continentes:
            if pais in x:
                lista = x
                break
        if lista == []:
            lista = [pais]
            continentes.append(lista)
            
        fronteiras = filter(lambda x: pais in x, vizinhos) # Lista de fronteiras que incluem certo pais
        for fronteira in fronteiras:
            for p in fronteira:
                if p != pais and p not in lista:
                    lista.append(p)
    
    return max(map(len, continentes)) if continentes != [] else 0

# Alternativa
def maior(vizinhos):
    continentes = []
    for k in vizinhos:
        continentes.append(set(k))
    for c1 in continentes:
        for c2 in continentes:
            if any(i in c1 for i in c2):
                c1.update(c2)
                
    lista = [list(k) for k in continentes]
    return max(map(len, lista)) if lista != [] else 0
