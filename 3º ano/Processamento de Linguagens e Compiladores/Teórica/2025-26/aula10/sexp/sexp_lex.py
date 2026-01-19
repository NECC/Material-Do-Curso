import ply.lex as lex

literals = ['(',')','*','+', '.']
tokens = ['INT']
    
def t_INT(t):
    r'\d+'
    t.value = int(t.value)
    return t

t_ignore = " \t\n"

def t_error(t):
    print('Caráter ilegal: ', t.value[0])
    t.lexer.skip(1)

lexer = lex.lex()