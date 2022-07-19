"""

Dada uma calculadora que apenas tem disponível um conjunto fixo de operações e 
cujo valor inicial é zero, implemente uma função que determina qual o número 
mínimo de operações necessárias para atingir um determinado resultado. 
Assuma que tal é sempre possível. 
As operações disponíveis são representadas por uma sequência de strings, 
onde cada string pode ser um dos caracteres '+', '-', '*' ou '/' 
seguido de um número inteiro positivo (o segundo operando) 
ou um único digito, que representa a operação de acrescentar um digito ao 
número actualmente na calculadora. 
Por exemplo, a string "/3" representa a operação de divisão inteira por 3 e 
a string "4" a operação de acrescentar o digito 4 ao número actualmente 
na calculadora (por exemplo, se o número actual é 3 ficará com o número 34).

"""

# 100%
def search(ops, res, k, n, i):
    if k == i:
        return res == n
        
    for what in ops:
        cI = n
        if '+' in what:
            what = what.split('+')
            cI += int(what[1])
        elif '-' in what:
            what = what.split('-')
            cI -= int(what[1])
        elif '/' in what:
            what = what.split('/')
            cI //= int(what[1])
        elif '*' in what:
            what = what.split('*')
            cI *= int(what[1])
        else:
            cI = int(str(cI) + str(what))
        if search(ops, res, k, cI, i+1):
            return True

    return False

def calculadora(ops,res):
    print(ops, res)
    k = 0
    while True:
        if search(ops,res,k, 0, 0):
            return k
        k+=1
    return -1
