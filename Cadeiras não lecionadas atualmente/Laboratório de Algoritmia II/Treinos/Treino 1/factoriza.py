'''
Defina uma função que recebe um número positivo
e produz a soma dos seus factores primos distintos.
'''

def factoriza(n):
    soma = 0
    for k in range(2,n):
        if n == 1:
            break
        if n % k == 0:
            soma += k
        while n % k == 0:
            n/=k
    return soma

# Para baixo disto não funciona porque faz um loop demasiado grande

def isPrime(x):
    r = True
    for k in range(2,x//2+1):
        if x % k == 0:
            r = False
            break
    return r
    
def factoriza(n):
    primos = [x for x in range(2,n+1) if isPrime(x)]
    result = 0
    for k in primos:
        if (n % k == 0):
            result += k

    return result

# It's Big Brain Time

def factoriza(n):
    primos = [x for x in range(2,n+1) if all([x % k != 0 for k in range(2,x//2+1)])]
    result = 0
    for k in primos:
        if (n % k == 0):
            result += k

    return result

# Even Bigger Brain Time

def factoriza(n):
    result = sum(filter(lambda i: n % i == 0, [x for x in range(2,n+1) if all([x % k != 0 for k in range(2,x//2+1)])]))
    return result
