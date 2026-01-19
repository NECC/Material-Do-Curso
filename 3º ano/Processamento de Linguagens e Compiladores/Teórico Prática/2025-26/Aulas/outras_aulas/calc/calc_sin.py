import ply.yacc as yacc
from calc_lex import lexer, tokens, literals

def p_inst_exit(p):
    r'Instruction : "#"'
    parser.terminate = True

def p_inst_assign(p):
    r'Instruction : VAR "=" Exp'
    parser.vars[p[1]] = p[3]
    p[0] = f"Variable {p[1]} defined"

def p_inst_var(p):
    r'Instruction : "?" VAR'
    try:
         v = int(input())
         parser.vars[p[2]] = v
         p[0] = f"Variable {p[2]} defined"
    except:
         parser.error = f"Invalid value for {p[2]}"

def p_inst_exp(p):
     r'Instruction : "!" Exp'
     p[0] = p[2]

def p_inst_dump(p):
     r'Instruction : "*"'
     p[0] = "\n".join(f"{var} -> {val}" for var, val in parser.vars.items())

def p_exp_sub(p):
     r'Exp : Exp "-" Term'
     p[0] = p[1] - p[3]

def p_exp_add(p):
     r'Exp : Exp "+" Term'
     p[0] = p[1] + p[3]

# Alternative without breaking Exp into individual functions
# def p_exp_sub(p):
#     r"""
#     Exp : Exp "-" Term
#         | Exp "+" Term
#         | Term
#     """
#     if len(p) == 2:
#         p[0] = p[1]
#     elif p[2] == "+":
#         p[0] = p[1] + p[3]
#     else:
#         p[0] = p[1] - p[3]

def p_exp_term(p):
     r'Exp : Term'
     p[0] = p[1]

def p_term_mul(p):
     r'Term : Term "*" Factor'
     p[0] = p[1] * p[3]

def p_term_div(p):
     r'Term : Term "/" Factor'
     p[0] = p[1] / p[3]

def p_term_factor(p):
     r'Term : Factor'
     p[0] = p[1]

def p_factor_num(p):
     r'Factor : NUM'
     p[0] = p[1]

def p_factor_var(p):
    r'Factor : VAR'
    if p[1] in parser.vars:
        p[0] = parser.vars[p[1]]
    else:
        parser.error = f"Undefined variable {p[1]}"
        p[0] = 0

def p_factor_paren(p):
     r'Factor : "(" Exp ")"'
     p[0] = p[2]

def p_error(t):
    parser.error = f"Syntax error: {t}"

parser = yacc.yacc()
parser.vars = {}
parser.terminate = False
parser.error = None