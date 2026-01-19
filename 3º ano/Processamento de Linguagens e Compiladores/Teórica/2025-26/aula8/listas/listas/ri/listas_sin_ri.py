import ply.yacc as yacc
from listas_analex import tokens, literals
from listas_ast import Lista, Vazia

# Production rules
def p_listaVazia(p):
    "Lista : '[' ']'"
    p[0] = Vazia('vazia')

def p_lista(p):
    "Lista : '[' Conteudo ']'"
    p[0] = p[2]

def p_conteudoNum(p):
    "Conteudo : NUM" 
    p[0] = Lista('lista', p[1], Vazia('vazia'))

def p_conteudo(p):
    "Conteudo : Conteudo ',' NUM"
    p[0] = Lista('lista', p[3], p[1])

def p_error(p):
    print('Erro sintático: ', p)
    parser.success = False

# Build the parser
parser = yacc.yacc()

# Adicionar estado ao parser
parser.success = True
