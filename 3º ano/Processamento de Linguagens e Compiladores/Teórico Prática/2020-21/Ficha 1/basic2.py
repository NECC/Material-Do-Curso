import re
# output only the lines with the following characteristics:
# 1. that contains the word hello anywhere on the line

print("1b. Linhas que encontram várias ocorrências da palavra: hello")

inputFromUser = input(">> ")
while inputFromUser != "":
  y = re.findall(r'(?i:hello)', inputFromUser)
  if(y): 
    print(inputFromUser)
    print("Encontradas ", len(y), " ocorrencias: ")
    print(y)   
  else:
    print("hello não encontrado")
  inputFromUser = input(">> ")
