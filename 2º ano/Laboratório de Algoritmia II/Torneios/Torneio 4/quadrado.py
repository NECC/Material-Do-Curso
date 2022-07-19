"""

Implemente uma função que calcula um quadrado de letras minúsculas de
dimensão n por n, tal que as letras em cada linha e em cada coluna
sejam todas diferentes. O quadrado deve ser representado por uma string
com n linhas (separadas por '\n') cada uma com n caracteres.
Para um dado n devolva a menor dessas strings em ordem lexicográfica.

"""

import string

def valid(n, string, X):
    return True

def extensions(n, stri, x):
    linhas = "".join(stri).split('\n')
    lista = []
    if linhas != []:
        pos = len(linhas[-1])
        if pos == n:
            return ['\n']

    for k in string.ascii_lowercase[:n]:
        if linhas == [] or (k not in linhas[-1] and all(map(lambda linha: linha[pos] != k, linhas[:-1]))):
            lista.append(k)
    
    return lista

def search(n, string, x):
    if x == n:
        return valid(n, string, x)
        
    for k in extensions(n, string, x):
        string.append(k)
        if search( n, string, x + (k == '\n') ):
            return True
        string.pop()
        
    return False

def quadrado(n):
    print(n)
    if n == 0:
        return ""

    for k in string.ascii_lowercase:
        ls = [k]
        if search(n, ls, 0):
            return "".join(ls[:-1])
    
    return ""
