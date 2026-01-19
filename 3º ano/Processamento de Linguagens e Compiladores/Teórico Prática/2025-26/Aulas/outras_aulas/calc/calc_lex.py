import ply.lex as lex

literals = ("*", "/", "+", "-", "(", ")", "!", "?", "=", "#")
tokens = ("NUM", "VAR")

t_VAR = r"[a-zA-Z]+"

def t_NUM(t):
    r"\d+(\.\d+)?"
    t.value = float(t.value)
    return t

def t_error(t):
    print("Invalid character:", t)
    lexer.skip(1)

t_ignore = " \n\t"

lexer = lex.lex()
