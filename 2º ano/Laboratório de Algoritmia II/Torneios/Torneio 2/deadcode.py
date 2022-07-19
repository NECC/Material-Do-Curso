#50%

def limpaEspacos(string):
    i = 0
    final = ""
    while i < len(string):
        if string[i] != ' ':
            final += string[i]
        i+=1
    return final

def local(prog,pos,queue,total):
    lista = prog[pos].split(',')
    lista[0] = lista[0][5:]
    lista = list(map(limpaEspacos, lista))
    for elem in lista:
        if elem != ' ' and int(elem) > 0 and int(elem) not in queue and int(elem) < total and pos != int(elem):
            queue.append(int(elem))

def deadcode(prog):
    total = len(prog)
    if prog == []:
        return (0,0)
    queue = [0]
    for pos in queue:
        if "jump" in prog[pos]:
            local(prog,pos,queue, total)
        elif pos+1 not in queue and pos+1 < total:
            queue.append(pos+1)

    n = len(queue)
    return (n,total-n)
