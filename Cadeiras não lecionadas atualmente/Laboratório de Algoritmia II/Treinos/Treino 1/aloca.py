"""

Implemente uma função que dado um dicionário com as preferências dos alunos
por projectos (para cada aluno uma lista de identificadores de projecto, 
por ordem de preferência), aloca esses alunos aos projectos. A alocação
é feita por ordem de número de aluno, e cada projecto só pode ser feito
por um aluno. A função deve devolver a lista com os alunos que não ficaram
alocados a nenhum projecto, ordenada por ordem de número de aluno.

"""

def aloca(prefs):
    projetos = []
    result = []
    numeros = [x for x in prefs.keys()]
    numeros.sort()
    for aluno in numeros:
        preferencias = prefs[aluno]
        alocado = False
        for num in preferencias:
            if num not in projetos:
                projetos.append(num)
                alocado = True
                break
        if not alocado:
            result.append(aluno)
    return result
