# listas_program.py
# 2025-11-04 by jcr
# ----------------------
from listas_sin_as import parser
import sys

for linha in sys.stdin:
    # Análise do texto
    parser.parse(linha)

    if parser.success:
        print("Frase válida: ", linha)
    else:
        print("Frase inválida... Corrija e tente novamente!")