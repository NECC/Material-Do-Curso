import sys
from listas_analex import lexer

for linha in sys.stdin:
    lexer.input(linha)
    for tok in lexer:
        print(tok)