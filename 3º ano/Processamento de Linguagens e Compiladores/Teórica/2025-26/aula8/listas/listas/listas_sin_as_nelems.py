import ply.yacc as yacc
from listas_analex import tokens, literals

# Production rules
def p_listaVazia(p):
    "Lista : '[' ']'"
    p[0] = 0

def p_lista(p):
    "Lista : '[' Conteudo ']'"
    p[0] = p[2]

def p_conteudoNum(p):
    "Conteudo : NUM" 
    p[0] = 1

def p_conteudo(p):
    "Conteudo : Conteudo ',' NUM"
    p[0] = p[1] + 1

def p_error(p):
    print('Erro sintático: ', p)
    parser.success = False

# Build the parser
parser = yacc.yacc()

# Adicionar estado ao parser
parser.success = True
