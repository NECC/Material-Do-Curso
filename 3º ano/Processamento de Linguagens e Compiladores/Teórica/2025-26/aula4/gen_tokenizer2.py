import sys
import json

def main():
    # Ensure a filename was provided as a command-line argument
    if len(sys.argv) < 2:
        print("Usage: python gen_tokenizer2.py <filename>")
        sys.exit(1)

    filename = sys.argv[1]

    # Try to open and load the specified file
    try:
        with open(filename, 'r', encoding='utf-8') as f:
            tokens = json.load(f)

        tokens_regex = '|'.join([f'(?P<{t['id']}>{t['expreg']})' for t in tokens])

        code = f"""
import sys
import re

def tokenize(input_string):
    reconhecidos = []
    mo = re.finditer(r'{tokens_regex}', input_string)
    for m in mo:
        dic = m.groupdict()
        if dic['{tokens[0]['id']}']:
            t = ("{tokens[0]['id']}", dic['{tokens[0]['id']}'], nlinha, m.span())
"""

        for t in tokens[1:]:
            code += f"""
        elif dic['{t['id']}']:
            t = ("{t['id']}", dic['{t['id']}'], nlinha, m.span())
    """
        code += f"""
        else:
            t = ("UNKNOWN", m.group(), nlinha, m.span())
        if not dic['SKIP'] and t[0] != 'UNKNOWN': reconhecidos.append(t)
    return reconhecidos

nlinha = 1
for linha in sys.stdin:
    for tok in tokenize(linha):
        print(tok) 
    nlinha += 1   
"""
        print(code)

    except FileNotFoundError:
        print(f"Error: File '{filename}' not found.")
        sys.exit(1)
    except json.JSONDecodeError:
        print(f"Error: File '{filename}' is not valid JSON.")
        sys.exit(1)

if __name__ == "__main__":
    main()
