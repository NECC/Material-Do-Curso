# Pergunta 1

def elgamal_decrypt(pub_key, a, cripto):
    p, r, b = pub_key
    Zp = IntegerModRing(p)
    gama, delta = cripto
    gama, delta = Zp(gama), Zp(delta)
    decry = (gama^a)^(-1)*delta
    return decry

# Dada a chave pública ElGamal
pub_key = (59879295262580794019, 2, 46532948489070777896) # (p,r,b)
# , sabendo que o índice de 46532948489070777896 na base 2 é igual a 26889797028840904448 a
# decifração de
cryptogram = (31508193067819085597, 42769957659645449029)
# é igual a ___.
elgamal_decrypt(pub_key,26889797028840904448,cryptogram)

# Pergunta 2
# Considere o primo
p= 17
# e o natural
a= 5
# Então o número dos menores resíduos de ka maiores que p/2, com k entre 1 e (p-1)/2 é igual a ___.

len([Mod(k*a,p) for k in range(1,(p-1)/2+1) if Mod(k*a,p)>p//2]) # == [10,15,13]

# Pergunta 3

def index_of(n,root,a):
    Zn = IntegerModRing(n)
    return discrete_log(a,Zn(root))

# Considere o primo
p=16456780161579311951
# e a raiz primitiva
r=10632721783361421121
# de p. O índice de 12124670967023022731 na base r é igual a
[a for a in
    [1945473589762547835,9108492322933321998,765875512,78664311121]
    if is_index_of(r,12124670967023022731,a,p)] # == [9108492322933321998]

# Pergunta 4

def is_euler_pseudoprime(n, base=2):
    assert n % 2 == 1
    return gcd(a,n)==1 and (power_mod(a,(n-1)//2,n) == 1 or power_mod(a,(n-1)//2,n) == -1) and not is_prime(n)

# São pseudo primos de Euler de base 5
[p for p in [99,781,101,1541] if is_euler_pseudoprime(p,5)] # == [781, 1541]

# Pergunta 5
# Indique todos os elementos que são raiz primitiva de 233

[r for r in [21,86,46,207] if r in all_prim_roots(233)] # == [21, 86]

# Pergunta 6
# Dada a chave pública ElGamal
pub_key=(39957963614327378639, 13, 2518634842003570977)
# a cifração de
mens=1234
# com o parâmetro aleatório
k=4321
# é
elgamal_encrypt(pub_key,mens,k) # == (11727766830592979831, 35640834212194464972)
