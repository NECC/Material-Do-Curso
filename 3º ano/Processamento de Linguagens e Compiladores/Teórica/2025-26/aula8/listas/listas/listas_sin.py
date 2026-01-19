import ply.yacc as yacc
from listas_analex import tokens, literals

# Production rules
def p_gramatica(p):
    """
    Lista : '[' ']'
          | '[' Conteudo ']'

    Conteudo : NUM 
             | Conteudo ',' NUM
    """

def p_error(p):
    print('Erro sintático: ', p)
    parser.success = False

# Build the parser
parser = yacc.yacc()

# Adicionar estado ao parser
parser.success = True
