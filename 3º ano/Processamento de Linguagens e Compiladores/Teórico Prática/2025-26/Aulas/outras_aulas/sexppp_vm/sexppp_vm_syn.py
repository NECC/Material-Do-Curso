from sexppp_vm_lex import lexer, tokens, literals
import ply.yacc as yacc

def p_program(t):
    r'Program : Statements'
    # TODO: Allow any variable name in any quantity, optimize memory allocation
    t[0] = "\n".join(["pushi 0" for i in range(26)] + t[1])

def p_stmts_0(t):
    r'Statements : Statements Statement'
    t[0] = t[1] + t[2]

def p_stmts_1(t):
    r'Statements : '
    t[0] = []

def p_stmt_read(t):
    r'Statement : "(" READ VAR ")"'
    idx = ord(t[3]) - ord("a")
    t[0] = [f'pushs "\\nvar {t[3]}? " ', "writes", "read", "atoi", f"storeg {idx}"]

def p_stmt_write(t):
    r'Statement : "(" WRITE VAR ")"'
    # TODO: Error handling, variable may not be defined
    idx = ord(t[3]) - ord("a")
    t[0] = [f'pushs "\\nvar {t[3]}: " ', "writes", f"pushg {idx}", "writei"]

def p_stmt_assign(t):
    r'Statement : "(" "=" VAR Exp ")"'
    idx = ord(t[3]) - ord("a")
    t[0] = t[4] + [f"storeg {idx}"]

def p_stmt_if(t):
    r'Statement : "(" IF Cond Block Block ")"'
    t[0] = t[3] + [f"jz else{parser.label}"] + t[4] + [f"jump end{parser.label}", f"else{parser.label}:"] + t[5] + [f"end{parser.label}:"]
    parser.label += 1

def p_stmt_while(t):
    r'Statement : "(" WHILE Cond Block ")"'
    t[0] = [f"while{parser.label}:"] + t[3] + [f"jz end{parser.label}"] + t[4] + [f"jump while{parser.label}", f"end{parser.label}:"]
    parser.label += 1

def p_block_0(t):
    r'Block : Statement'
    t[0] = t[1]

def p_block_1(t):
    r'Block : "(" Statements ")"'
    t[0] = t[2]

def p_exp_sum(t):
    r'Exp : "(" "+" Exp Term ")"'
    t[0] = t[3] + t[4] + ["add"]

def p_exp_sub(t):
    r'Exp : "(" "-" Exp Term ")"'
    t[0] = t[3] + t[4] + ["sub"]

def p_exp_term(t):
    r'Exp : Term'
    t[0] = t[1]

def p_term_mul(t):
    r'Term : "(" "*" Term Factor ")"'
    t[0] = t[3] + t[4] + ["mul"]

def p_term_div(t):
    r'Term : "(" "/" Term Factor ")"'
    t[0] = t[3] + t[4] + ["div"]

def p_term_fact(t):
    r'Term : Factor'
    t[0] = t[1]

def p_factor_num(t):
    r'Factor : NUM'
    t[0] = [f"pushi {t[1]}"]

def p_factor_var(t):
    r'Factor : VAR'
    # TODO: Error handling, variable may not be defined
    idx = ord(t[1]) - ord("a")
    t[0] = [f"pushg {idx}"]

def p_cond_lt(t):
    r'Cond : "(" "<" Exp Exp ")"'
    t[0] = t[3] + t[4] + ["inf"]

def p_cond_gt(t):
    r'Cond : "(" ">" Exp Exp ")"'
    t[0] = t[3] + t[4] + ["sup"]

def p_error(t):
    parser.error = f"Syntax error: {t}"

parser = yacc.yacc()

def init():
    parser.error = None
    parser.label = 0
    return parser