"""

Dadas duas strings de igual tamanho s1 e s2 a distância entre elas d(s1,s2) 
pode ser determinada pelo número de substituições de caracteres necessárias 
para transformar uma na outra (ou seja, o número de caracteres diferentes 
na mesma posição). Por exemplo d("cama","maca") == 2. 

Implemente uma função que, dado um conjunto de strings s1, ..., sn de igual 
tamanho (apenas com letras minúsculas), determine uma nova string s desse 
tamanho que seja o "centro" desse conjunto, isto é, tal que d(s,si) <= k 
para todo 1 <= i <= n e tal que k seja o menor possível. Se existir mais do 
que uma string nessas condições devolva a menor em ordem lexicográfica.

"""

import string
    
def valid(strings, n, ls, i, K, dists):
    return all(map(lambda x: x <= K, dists.values()))

def search(strings, n, ls, i, K, dists):
    if i == n:
        return valid(strings, n, ls, i, K, dists)
    if any(map(lambda x: dists[x] - (n-i) > K, strings)):
        return False
        
    for k in string.ascii_lowercase:
        ls.append(k)
        newDists = {}
        
        cond = False
        for st in strings:
            newDists[st] = dists[st] - (st[i] == k)
            if newDists[st]-(n-(i+1)) > K:
                cond = True
                break
        if cond:
            ls.pop()
            continue

        if search(strings, n, ls, i+1, K, newDists):
            return True
                
        ls.pop()
        
    return False

def centro(strings):
    print(strings)
    
    if strings == []:
        return ""
        
    n = len(strings[0])
    try:
        k = 0
        while True:
            ls = []
            dists = {}
            for x in strings:
                dists[x] = n
            if search(strings, n, ls, 0, k, dists):
                return "".join(ls)
            k+=1
    except Exception as e:
        return e
