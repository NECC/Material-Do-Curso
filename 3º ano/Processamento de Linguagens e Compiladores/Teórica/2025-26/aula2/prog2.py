import re
texto = "Olá, isto é uma string de teste."

lista = re.split(r' |,|\.', texto)
print(lista)