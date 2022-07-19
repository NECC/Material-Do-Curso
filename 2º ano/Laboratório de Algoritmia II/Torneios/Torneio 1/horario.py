# 50%

def cabe(hora, uc): # 1 aula, outra aula
    res = True
    a = (hora[1],hora[1]+hora[2])
    b = (uc[1],uc[1]+uc[2])
    
    if a[0] <= b[0] < a[1]: # b começa a meio de a 
        res = False
    elif b[0] <= a[0] < b[1]: # a começa a meio de b
        res = False
    
    return res

def horario(ucs,alunos):
    result = []
    horarios = {}
    
    for aluno in alunos:
        if aluno not in horarios:
            horarios[aluno] = []
            
        for cad in alunos[aluno]:
            possivel = True
            if cad not in ucs:
                possivel = False
            
            for hora in horarios[aluno]:
                if cad in ucs and hora[0] == ucs[cad][0]: # dia da semana
                    if not cabe(hora, ucs[cad]):
                        possivel = False
            if possivel:
                horarios[aluno].append((ucs[cad][0],ucs[cad][1],ucs[cad][2]))
                
        if len(horarios[aluno]) == len(alunos[aluno]):
            result.append(aluno)
    
    resultado = []
    for aluno in result:
        horas = 0
        for x in horarios[aluno]:
            horas+=x[2]
        resultado.append((aluno, horas))
    
    resultado.sort(key=lambda x: (-x[1], x[0]))
    
    return resultado