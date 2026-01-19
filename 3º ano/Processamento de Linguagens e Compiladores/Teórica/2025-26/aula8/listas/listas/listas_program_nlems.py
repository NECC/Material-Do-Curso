# listas_program.py
# 2025-11-04 by jcr
# ----------------------
from listas_sin_as_nelems import parser
import sys

for linha in sys.stdin:
    # Análise do texto
    res = parser.parse(linha)

    if parser.success:
        print("Frase válida: ", linha)
        print(f"Número de elementos na lista: {res}")
    else:
        print("Frase inválida... Corrija e tente novamente!")