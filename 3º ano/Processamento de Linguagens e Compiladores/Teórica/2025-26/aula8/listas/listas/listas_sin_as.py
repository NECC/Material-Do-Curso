import ply.yacc as yacc
from listas_analex import tokens, literals

# Production rules
def p_listaVazia(p):
    "Lista : '[' ']'"

def p_lista(p):
    "Lista : '[' Conteudo ']'"

def p_conteudoNum(p):
    "Conteudo : NUM" 

def p_conteudo(p):
    "Conteudo : Conteudo ',' NUM"

def p_error(p):
    print('Erro sintático: ', p)
    parser.success = False

# Build the parser
parser = yacc.yacc()

# Adicionar estado ao parser
parser.success = True
