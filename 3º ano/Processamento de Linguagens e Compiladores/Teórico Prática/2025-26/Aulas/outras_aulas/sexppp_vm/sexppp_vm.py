
from sexppp_vm_syn import init

ex1 = """
(read a)
(read b)
(read c)
(if (> a b) 
    (if (> a c)
        (write a)
        (write c)
    )
    (if (> b c)
        (write b)
        (write c)
    )
)
"""

ex2 = """
(read a)
(= f 1)
(while (> a 1)
    (
        (= f (* f a))
        (= a (- a 1))
    )
)
(write f)
"""

parser = init()
result = parser.parse(ex2)
if parser.error:
    print("Error!", parser.error)
else:
    print(result)

    