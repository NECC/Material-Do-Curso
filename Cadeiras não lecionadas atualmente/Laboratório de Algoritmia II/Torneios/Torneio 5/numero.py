"""

Implemente uma função que dados 0 < n <= 9 e k >= 0 devolva o menor número 
com exactamente duas ocorrências de todos os digitos entre 1 e n,
estando essas duas ocorrências de p à distância p+k uma da outra.

"""
    
def distCerta(n,k,ls,i,oc,x):
    if len(oc[x]) == 0:
        return True
    if len(oc[x]) >= 2:
        return False
        
    return abs(oc[x][0] - i) == x+k

def valid(n,k,ls,i, oc):
    return True
    
def extensions(n,k,ls,i, oc):
    return [x for x in range(1,n+1) if distCerta(n,k,ls,i,oc,x)]
    
def search(n, k, ls, i, oc):
    if i == n*2:
        return valid(n,k,ls,i, oc)
        
    for x in extensions(n,k,ls,i, oc):
        ls.append(x)
        oc[x].append(i)
        if search(n,k,ls,i+1, oc):
            return True
        oc[x].pop()
        ls.pop()
    return False

def numero(n,k):
    ls = []
    oc = {}
    for x in range(1,n+1):
        oc[x] = []
    if search(n,k,ls,0, oc):
        return int("".join(map(str, ls)))
