from calc_sin import parser
import sys

print(
"""
Interactive calculator, available commands:
    ! e - print the value of an expression e
    ? v - read a value for variable v
    v = e - assign value of expression e to variable v
    * - dump the value of all variables
    # - close the calculator
""")

for line in sys.stdin:
    parser.error = None
    result = parser.parse(line)
    if parser.terminate:
        print("Goodbye")
        break
    elif parser.error:
        print("Error!", parser.error)
    else: 
        print(result)

        

    