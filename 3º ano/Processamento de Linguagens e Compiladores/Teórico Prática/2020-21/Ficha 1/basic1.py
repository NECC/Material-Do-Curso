import re
# output only the lines with the following characteristics:
# 1. that contains the word hello anywhere on the line

print("1. Linhas que contêm a palavra: hello")
inputFromUser = input(">> ")
while inputFromUser != "":
  y = re.search(r'hello', inputFromUser)
  if(y): 
    #print(y)
    print("Encontrada: ", y.group(), " em: ", y.string) 
    (ini,fim)=y.span()
    comp = fim-ini
    print("na posição ", y.span()," com carateres ",comp)  
  else:
    print("hello não encontrado")
  inputFromUser = input(">> ")
