# listas_program_ri.py
# 2023-03-21 by jcr
# ----------------------
from listas_anasin_ri import rec_Parser

# Exemplo de uma travessia externa à classe: o maior da lista
def maxLista2(m, asa):
    if asa.type == 'vazia':
        res = m
    else:
        if m > int(asa.num):
            res = maxLista2(m, asa.lista)
        else:
            res = maxLista2(int(asa.num), asa.lista)
    return res

def maxLista(asa): 
    if asa.type == 'vazia':
        res = None
    else:
        res = maxLista2(int(asa.num), asa.lista)
    return res


linha = input("Introduza uma lista: ")
ast = rec_Parser(linha)
ast.pp()
print("\n----------------------\n")
ast.pprev()
print("\n", ast.count())
print("\n", ast.sum())
print("\nO Maior é: ", maxLista(ast))


