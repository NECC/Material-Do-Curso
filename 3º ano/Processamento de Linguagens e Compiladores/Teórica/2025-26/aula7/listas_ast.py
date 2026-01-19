# listas_ast.py
# 2023-03-21 by jcr
# ----------------------
# P1: Lista -->  num Conteudo
# P2:         |   
# -------------------------------         
class Lista:
    def __init__(self, type, num, lista):
        self.type = type
        self.num = num
        self.lista = lista

    def pp(self):
        print('(', end="")
        print(self.num, " ", end="")
        self.lista.pp()
        print(')', end="") 

    def pprev(self):
        print('(', end="")
        self.lista.pprev()
        print(self.num, " ", end="")
        print(')', end="")

    def count(self):
        return 1 + self.lista.count()
    
    def sum(self):
        return int(self.num) + self.lista.sum()
         
class Vazia:
    def __init__(self, type):
        self.type = type

    def pp(self):
        print('()', end="")
    
    def pprev(self):
        print('()', end="")

    def count(self):
        return 0
    
    def sum(self):
        return 0


    
