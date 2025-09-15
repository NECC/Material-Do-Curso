"""
Um hacker teve acesso a um log de transações com cartões de
crédito. O log é uma lista de tuplos, cada um com os dados de uma transação,
nomedamente o cartão que foi usado, podendo alguns dos números estar
ocultados com um *, e o email do dono do cartão.

Pretende-se que implemente uma função que ajude o hacker a 
reconstruir os cartões de crédito, combinando os números que estão
visíveis em diferentes transações. Caso haja uma contradição nos números 
visíveis deve ser dada prioridade à transção mais recente, i.é, a que
aparece mais tarde no log.

A função deve devolver uma lista de tuplos, cada um com um cartão e um email,
dando prioridade aos cartões com mais digitos descobertos e, em caso de igualdade
neste critério, aos emails menores (em ordem lexicográfica).

Input:
        [('****1234********', 'maria@mail.pt'), ('0000************', 'ze@gmail.com'), ('****1111****3333', 'ze@gmail.com')]
"""

def hacker(log):
    result = []
    for pessoa in log:
        cartao = pessoa[0]
        cartaoFinal = cartao
        email = pessoa[1]
        for novaPessoa in result:
            novoEmail = novaPessoa[1]
            if novoEmail == email:
                cartaoFinal = ""
                novoCartao = novaPessoa[0]
                result.remove(novaPessoa)
                for pos in range(len(cartao)):
                    if cartao[pos] != '*':
                        cartaoFinal += cartao[pos]
                    else:
                        cartaoFinal += novoCartao[pos]
                break
        result.append((cartaoFinal,email))
        
        
    result.sort(key=lambda x: (-len(list(filter(lambda k: k != '*', x[0]))),x[1]))
    return result

# Solução não cancerosa

def hacker(log):
    mails = {}
    for cartao,email in log:
        if email not in mails:
            mails[email] = cartao
        else:
            cartaoAntigo = mails[email]
            cartaoNovo = ""
            for i in range(len(cartaoAntigo)):
                if cartao[i] != '*':
                    cartaoNovo += cartao[i]
                else:
                    cartaoNovo += cartaoAntigo[i]
            mails[email] = cartaoNovo
        
    result = [(mails[x],x) for x in mails]
    result.sort(key=lambda x: (-len(list(filter(lambda k: k != '*', x[0]))),x[1]))
    return result
