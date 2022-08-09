import re

def busca(ER):
  fraseFonte = input(">> ")
  while fraseFonte != "":
    y = re.search(ER, fraseFonte)
    if(y): 
      print("Em \'", y.string, "\' foi encontrado: ", y.group())   
      #print("Em \'", y.string, "\' foi encontrado: ", y.group(1))
    else:
      print("Não encontrado")
    fraseFonte = input(">> ")

# 1. 
#print("Linhas que contém algures a palavra 'padrão'")
#busca(r'RRRR')

# 2. 
#print("Linhas que começam por 'PRH' ou 'JCR' ")
#busca(r'RRRR')

# 3. 
#print("Linhas que começam por um Número")
#busca(r'RRRR')

# 4. 
#print("Linhas que terminam com 'PMoura'")
#busca(r'RRRR')

# 5. 
#print("Linhas que terminam com: uma Letra (maíscula ou minúscula), ou com um ponto de interrogação, ou ponto final")
#busca(r'RRRR')

# 6. 
#print("Linhas que só contém digitos, hífens ou pontos")
#busca(r'RRRR')

# 7. 
#print("Linhas que começam por um ou mais Separadores de palavras (white spaces)")
#busca(r'RRRR')

# 8.
#print("Linhas que contém um número de telefone português (9 digitos)"))
#busca(r'RRRR')
##8a. permita que comece pelo indicativo do país

# 9. 
print("Linhas que contém uma STRING não nula entre aspas")
## 9a. repita o exercício anterior permitindo Strings vazias
#busca(r'\".*\"')
## 9.b repita o exercício anterior escrevendo apenas o texto entre aspas
busca(r'\"([^"]*)\"')

# 10. A phone number. This is three digits followed by a dash followed by four digits. 
# 11. This time your phone number should not have an area code - only the three digit, dash, four digit local phone number. (You can assume that your phone number is preceded by a whitespace character.)
# 12. Last, allow your phone number to be seven consecutive digits as well as the three digit dash four digit type.
