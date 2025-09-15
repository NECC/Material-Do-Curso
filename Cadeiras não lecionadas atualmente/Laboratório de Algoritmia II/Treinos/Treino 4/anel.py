'''

Um anel de tamanho n (um número par) consiste numa permutação do números de 1 
até n em que a soma de quaisquer dois números adjacentes é um número primo
(considera-se que o primeiro elemento da sequência é adjacente do último).
Implemente uma função que calcule um destes aneis de tamanho n.

'''

# 13%
def complete(n, ls):
    return len(ls) == n
    
def extensions(n,ls):
    x = ls[-1]
    y = ls[0]
    if len(ls) == n-1:
        return [i for i in range(1,n+1) if i not in ls and isPrime(x+i) and isPrime(y+i)]
    else:
        return [i for i in range(1,n+1) if i not in ls and isPrime(x+i)]

def search(n,ls):
    if complete(n,ls):
        return True
    for x in extensions(n,ls):
        ls.append(x)
        if search(n,ls):
            return True
        ls.pop()
    return False

def anel(n):
    for x in range(1,n+1):
        c = [x]
        if search(n,c):
            return c
        
def isPrime(x):
    for p in range(2,x):
        if x % p == 0:
            return False
    return True
