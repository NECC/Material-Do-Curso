import ply.lex as lex
import sys

tokens=(
    'TURMA',
    'ID',
    'ALUNO',
    'DP',
    'NOTAS',
    'PF',
    'VIRG',
    'NUM'
    )

t_DP=r':'
t_PF=r'\.'
t_VIRG=r','

def t_TURMA(t):
    r'(?i:TURMA)'
    return t

def t_ALUNO(t):
    r'(?i:ALUNO)'
    return t

def t_NOTAS (t):
    r'(?i:NOTAS)'
    return t

def t_ID(t):
    r'\w+'
    return t

def t_NUM(t):
    r'\d+'
    t.value=int(t.value)
    return t

t_ignore=' \r\n\t'

def t_error(t):
    print("Illegal character '%s'" % t.value[0])
    t.lexer.skip(0)

lexer=lex.lex()

for linha in sys.stdin:
    lexer.input(linha)
    tok = lexer.token()
    while tok:
        print(tok)
        tok = lexer.token()


