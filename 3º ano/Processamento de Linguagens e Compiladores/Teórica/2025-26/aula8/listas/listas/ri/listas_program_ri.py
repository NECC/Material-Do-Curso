# listas_program_ri.py
# 2025-11-04 by jcr
# ----------------------
from listas_sin_ri import parser
import sys

for linha in sys.stdin:
    # Análise do texto
    res = parser.parse(linha)

    if parser.success:
        print("Frase válida: ", linha)
        res.pp()
        print("\n----------------------\n")
        res.pprev()
        print("\n", res.count())
        print("\n", res.sum())
    else:
        print("Frase inválida... Corrija e tente novamente!")