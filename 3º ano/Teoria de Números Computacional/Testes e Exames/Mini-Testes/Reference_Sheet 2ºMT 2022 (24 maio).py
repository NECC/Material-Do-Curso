# By Alef Keuffer

# cifrar/decifrar usando o ElGamal
def elgamal_encrypt(pub_key, mens):
    p, r, b = pub_key
    Zp = IntegerModRing(p)
    r, b = Zp(r), Zp(b)
    k = randint(2, p-2)
    gama, delta = r^k, mens*b^k
    return gama, delta

def Elgamal_decif(pub_key, a, cripto):
    p, r, b = pub_key
    Zp = IntegerModRing(p)
    gama, delta = cripto
    gama, delta = Zp(gama), Zp(delta)
    decry = (gama^a)^(-1)*delta
    return decry

# reconhecer raizes primitivas

def multiplicative_group(n):
    return {IntegerModRing(n)(e)
            for e in IntegerModRing(n).list_of_elements_of_multiplicative_group()}

def findOrders(n):
    return {(e,e.multiplicative_order())
            for e in multiplicative_group(n)}

def all_prim_roots(n):
    return {e[0] for e in findOrders(n) if e[1] == euler_phi(n)}

def num_prim_roots(n):
    return euler_phi(euler_phi(n))

def is_prim_root(a,n):
    return a in all_prim_roots(n)


# verificar o valor do índice (aka logaritmo discreto)
# b ≡ rᵃ (mod n) ⟺ indᵣb ≡ a (mod n)
is_index_of(r,b,a,n):
    """
    returns true if a (mod n) is index of b in base r, false otherwise
    """
    return power_mod(r,a,n) == b

# aplicar o Lema de Gauss para calcular o símbolo de Legendre

"""
Let p=17 and a=7.

There are 16 nonzero elements [1...16].

Consider the first half [1...8] and multiply them all by 7 to get

    7, 14, 4, 11, 1, 8, 15, 5.

We single out 14, 11 and 15 because they are greater than p/2 (that is, 9 or higher).

So exactly 3 of them are greater than p/2.

Gauss' Lemma states that if we take this 3 and raise -1 to this power, then we have legendre_symbol(a,b)

that is:

    legendre_symbol(7,17) = (-1)³ = -1
"""

# Identificar pseudo-primos de Euler
# (ou seja, que consigam afirmar se um certo número apresentado é o psprimo Euler de base dada).
# Em particular que não se esquecessem que, tal como todos os pseudo-primos,
# os de Euler são necessariamente números compostos.

"""
an odd composite integer n is called an Euler pseudoprime to base a, if a and n are coprime, and

a^((n-1)/2) ≡ ± 1 (mod n)
"""

# use sagemath is_pseudoprime()

def is_euler_pseudoprime(n, base=2):
    assert n % 2 == 1
    return gcd(a,n)==1 and (power_mod(a,(n-1)/2,n) == 1 or power_mod(a,(n-1)/2,n) == -1) and not is_prime(n)
