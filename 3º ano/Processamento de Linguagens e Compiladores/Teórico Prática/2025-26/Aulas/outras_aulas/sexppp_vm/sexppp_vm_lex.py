import ply.lex as lex

literals = ("*", "/", "+", "-", "(", ")", "=", ">", "<")
tokens = ("NUM", "VAR", "WRITE", "READ", "IF", "WHILE")

def t_WRITE(t):
    r"write"
    return t

def t_READ(t):
    r"read"
    return t

def t_IF(t):
    r"if"
    return t

def t_WHILE(t):
    r"while"
    return t

def t_VAR(t):
    r"[a-z]"
    return t

def t_NUM(t):
    r"\d+"
    t.value = int(t.value)
    return t

def t_error(t):
    print("Invalid character:", t)
    lexer.skip(1)

t_ignore = " \n\t"

lexer = lex.lex()