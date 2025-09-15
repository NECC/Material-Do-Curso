'''
Neste problem pretende-se que defina uma função que, dada uma string com palavras, 
devolva uma lista com as palavras nela contidas ordenada por ordem de frequência,
da mais alta para a mais baixa. Palavras com a mesma frequência devem ser listadas 
por ordem alfabética.
'''

def frequencia(texto):
    palavras = texto.split()
    dicionario = {}
    
    for pal in palavras:
        if pal not in dicionario:
            dicionario[pal] = 0
        dicionario[pal] -= 1
    
    palavras = set(palavras)
    palavras = list(palavras)
    palavras.sort(key=lambda x: (dicionario[x],x))
    return palavras
