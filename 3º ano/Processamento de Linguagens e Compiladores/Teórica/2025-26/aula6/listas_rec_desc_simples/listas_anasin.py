# listas_anasin.py
# 2023-03-21 by jcr
# ----------------------
from listas_analex import lexer

prox_simb = ('Erro', '', 0, 0)

def parserError(simb):
    print("Erro sintático, token inesperado: ", simb)

def rec_term(simb):
    global prox_simb
    if prox_simb.type == simb:
        prox_simb = lexer.token()
    else:
        parserError(prox_simb)

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
        rec_Conteudo()
        print("Reconheci P6: Cont2    --> ',' Conteudo")
    elif prox_simb.type == 'PF':
        print("Derivando por P5: Cont2 -->")
        print("Reconheci P5: Cont2 -->")
    else:
        parserError(prox_simb)

def rec_Conteudo():
    print("Derivando por P4: Conteudo --> num Cont2")
    rec_term('NUM')
    rec_Cont2()
    print("Reconheci P4: Conteudo --> num Cont2")

def rec_LCont():
    global prox_simb
    if prox_simb.type == 'PF':
        print("Derivando por P2: LCont --> ']'")
        rec_term('PF')
        print("Reconheci P2: LCont --> ']'")
    elif prox_simb.type == 'NUM':
        print("Derivando por P3: LCont --> Conteudo ']'")
        rec_Conteudo()
        rec_term('PF')
        print("Reconheci P3: LCont --> Conteudo ']'")
    else:
        parserError(prox_simb)

# P1: Lista --> '[' LCont
# P2: LCont --> ']' 
# P3:         | Conteudo ']'
def rec_Lista():
    global prox_simb
    print("Derivando por P1: Lista --> '[' LCont")
    rec_term('PA')
    rec_LCont()
    print("Reconheci P1: Lista --> '[' LCont")


def rec_Parser(data):
    global prox_simb
    lexer.input(data)
    prox_simb = lexer.token()
    rec_Lista()
    print("That's all folks!")