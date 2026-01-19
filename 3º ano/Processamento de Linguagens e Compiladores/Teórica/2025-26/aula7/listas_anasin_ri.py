# listas_anasin_ri.py
# 2023-03-21 by jcr
# ----------------------
from listas_analex import lexer
from listas_ast import Lista, Vazia

prox_simb = ('Erro', '', 0, 0)

def parserError(simb):
    print("Erro sintático, token inesperado: ", simb)

def rec_term(simb):
    global prox_simb
    if prox_simb.type == simb:
        prox_simb = lexer.token()
    else:
        parserError(prox_simb)
        prox_simb = ('erro', '', 0, 0)

# P4: Conteudo --> num 
# P5:            | num ',' Conteudo
# É preciso alterar para:
# P4: Conteudo --> num Cont2
# P5: Cont2    --> 
# P6: Cont2    --> ',' Conteudo

def rec_Cont2():
    global prox_simb
    if prox_simb.type == 'VIRG':
        print("Derivando por P6: Cont2    --> ',' Conteudo")
        rec_term('VIRG')
        res = rec_Conteudo()
        print("Reconheci P6: Cont2    --> ',' Conteudo")
    elif prox_simb.type == 'PF':
        print("Derivando por P5: Cont2 -->")
        res = Vazia('vazia')
        print("Reconheci P5: Cont2 -->")
    else:
        parserError(prox_simb)
        res = Vazia('vazia')
    return res

def rec_Conteudo():
    global prox_simb
    print("Derivando por P4: Conteudo --> num Cont2")
    num = prox_simb.value
    rec_term('NUM')
    cont2 = rec_Cont2()
    print("Reconheci P4: Conteudo --> num Cont2")
    return Lista('lista', num, cont2)

def rec_LCont():
    global prox_simb
    if prox_simb.type == 'PF':
        print("Derivando por P2: LCont --> ']'")
        rec_term('PF')
        print("Reconheci P2: LCont --> ']'")
        res = Vazia('vazia')
    elif prox_simb.type == 'NUM':
        print("Derivando por P3: LCont --> Conteudo ']'")
        res = rec_Conteudo()
        rec_term('PF')
        print("Reconheci P3: LCont --> Conteudo ']'")
    else:
        parserError(prox_simb)
        res = Vazia('vazia')
    return res

# P1: Lista --> '[' LCont
# P2: LCont --> ']' 
# P3:         | Conteudo ']'
def rec_Lista():
    global prox_simb
    rec_term('PA') 
    return rec_LCont()


def rec_Parser(data):
    global prox_simb
    lexer.input(data)
    prox_simb = lexer.token()
    return rec_Lista()
    