import ply.yacc as yacc 
from sexp_lex import tokens, literals
from functools import reduce

# --- SExp grammar:
# p1: Sexp   --> Exp '.'
# p2: Exp    --> INT
# p3:          | '(' Funcao ')'
# p4: Funcao --> '+' Lista
# p5:          | ’*’ Lista
# p6: Lista  --> Lista Exp
# p7:          | 

def p_Sexp(p):
    "Sexp : Exp '.'"
    p[0] = p[1]
    print(f"Valor: {p[0]}")

def p_Exp_INT(p):
    "Exp : INT"
    p[0] = p[1]

def p_Exp_Funcao(p):
    "Exp : '(' Funcao ')'"
    p[0] = p[2]

def p_Funcao_add(p):
    "Funcao : '+' Lista"
    p[0] = sum(p[2])

def p_Funcao_mul(p):
    "Funcao : '*' Lista"
    p[0] = reduce(lambda x, y: x * y, p[2])

def p_Lista_lista(p):
    "Lista : Lista Exp"
    p[0] = p[1] + [p[2]]

def p_Lista_elem(p):
    "Lista : "
    p[0] = []

def p_error(p):
    print('Erro sintático: ', p)
    parser.success = False

# Build the parser
parser = yacc.yacc(debug=True)
