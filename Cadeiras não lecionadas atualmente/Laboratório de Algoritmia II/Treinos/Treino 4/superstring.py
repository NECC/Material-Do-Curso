'''

Implemente um função que calcula a menor string que contém todas as palavras 
recebidas na lista de input. Assuma que todas as palavras são disjuntas entre si, 
ou seja, nunca haverá inputs onde uma das palavras está contida noutra.

'''

from functools import reduce

def extensions(strings, N, k, ls):
    return [x for x in strings if x not in ls]

def search(strings, N, k, ls, resList, concatList):
    string = makeWord(ls, concatList)
    if len(string) == k:
        if any(map(lambda x: x not in ls, strings)):
            return False
        else:
            resList.append(string)
            return True
    elif len(string) > k:
        return False

    for x in extensions(strings, N, k, ls):
        ls.append(x)
        if search(strings, N, k, ls, resList, concatList):
            return True
        ls.pop()

    return False

def superstring(strings):
    res = "".join(strings)
    concatList = {}
    contidas = False
    for p in strings:
        for b in strings:
            if p != b:
                if p not in concatList:
                    concatList[p] = {}
                concatList[p][b] = concat(p,b)
                if concatList[p][b] != len(p):
                    contidas = True
    if not contidas:
        return res
    resList = [res]
    N = len(res)

    for k in range(1,N):
        if search(strings, N, k, [], resList, concatList):
            return resList[-1]

    return resList[-1]

def makeWord(ls, concatList):
    i = 0
    N = len(ls)
    if N == 0:
        return ""
    final = ""
    while i < N-1:
        pal = ls[i]
        nextPal = ls[i+1]
        final += pal[:concatList[pal][nextPal]]
        i+=1
    return final + ls[i]

def concat(a, b):
    Na = len(a)
    Nb = len(b)
    k = 0
    x = Na

    for i in range(Na):
        k = i
        for j in range(Nb):
            if k == Na:
                break
            elif a[k] == b[j]:
                k+=1
            else:
                break
        if k == Na:
            x = i
            break
    return x
