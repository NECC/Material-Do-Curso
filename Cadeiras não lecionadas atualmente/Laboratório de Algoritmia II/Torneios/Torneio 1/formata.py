# 40%

def formata(codigo):
    final = ""
    newLine = False
    i = 0
    l = len(codigo)
    tabs = 0
    for char in codigo:
        i += 1
        if char == '{':
            final += '{' + '\n'
            newLine = True
            tabs += 2
        elif char == ';':
            newLine = True
            final += ';' + '\n'*(i<l)
        elif char == '}':
            tabs -= 2
            final += ' '*tabs + '}' + '\n'*(i<l)
            newLine = True
        elif newLine:
            if char == ' ':
                continue
            else:
                final += ' '*tabs + char
                newLine = False
        else:
            final+=char
        
    return final