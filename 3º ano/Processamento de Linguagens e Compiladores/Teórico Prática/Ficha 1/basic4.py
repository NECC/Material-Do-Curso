import re
# output every line after substituting very occorrence of HELLO by *YEP*
#     and count the replacements

print("substituição de hello na linha")

inputFromUser = input(">> ")

while inputFromUser != "":
  (new_text, ocor) = re.subn(r'(?i:hello)', '*YEP*', inputFromUser) 
  if(ocor): 
    print("Sucesso, padrão encontrado ", ocor, " vezes e SUSBTITUIDO:")
    print(new_text) 
  else:
    print("hello não encontrado")
  inputFromUser = input(">> ")

  
  
