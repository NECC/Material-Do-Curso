**Proposição.** (aula anterior)

*Demonstração.:*
(v)
Caso 1: $n > 0$
$$
\begin{align*}
(a^n)^{-1} &= \underbrace{aa\dots a}_{\text{n vezes}} \quad \text{por definição de } a^n \text{com } n \in \mathbb{N} \\
&= \underbrace{a^{-1}a^{-1} \dot a^{-1}}_{\text{n vezes}} \quad \text{por (iv)} \\
&= (a^{-1}) \quad \text{por definição de } (a^{-1})^n \text{ com } n \in \mathbb{N}
\end{align*}
$$

Caso 2: $n = 0$
$$
\begin{align*}
(a^n)^{-1} &= (a^0)^{-1} \\
&= 1_G^{-1} \quad \text{por definição de } a^0 \\
&= 1_G \quad \text{por (i)} \\
&= (a^{-1})^0 \\
&= (a^{-1})^0 \\
\end{align*}
$$

Caso 3: $n < 0 \\$
Seja $n = -k$. Então $k = -n > 0 \\$
Tem-se 

$$
\begin{align*}
(a^n)^{-1} &= (a^{-k})^{-1} \\
&= ((a^k)^{-1})^{-1} \quad \text{definição de} a^{-k} \text{ com } k \in \mathbb{N} \\
&= ((a^{-1})^k)^{-1} \quad \text{pelo caso 1 por } k > 0 \\ 
&= (a^{-1})^{-k} \quad \text{definição de } (a^{-1})^{-k} \\
&=(a^{-1})^n \quad \text{pois } -k = n
\end{align*}
$$

**Definição:** Seja $(G, \cdot)$ um grupóide e seja $a \in G$. Diz-se que $a$ é:
- simplicável (ou cancelável) à esquerda se $\forall_{c, d \in G} (ac = ad \implies c = d)$
- simplicável (ou cancelável) à direita se $\forall_{c, d \in G}(ca = da \implies c = d)$
- simplicável (ou cancelável) se é simplicável à esquerda e à direita

**Definição:** Dizemos que num grupóide $(G, \cdot)$ é valida a:
- lei do corte à esquerda se todos os elementos do grupóide são caneláveis à esquerda
- lei do corte à direita se todos os elementos do grupóide são canceláveis à direita
- lei do corte se são válidas as leis da corte à esquerda e à direita

*Exemplos:*
1) A lei do corte é válida em $(\mathbb{N}, +)$ e em $(\mathbb{N}, \cdot)$
2) Em $(\mathbb{N}_0, \cdot)$ e em $(\mathbb{Z}, \cdot)$ não é válida a lei do corte pois por exemplo $0 \cdot 8 = 0 \cdot 5 = 0$ e no entanto $8 \ne 5$. Portanto o $0$ não é cancelável.

*Propriedade:*Seja $(M, \cdot)$ um monóide. Se $a \in M$ é invertível, então $a$ é simplicável

*Demonstração:* Se $a$ é invertível, então $a$ existe um elemento $a^{-1} \in M$ tal que $$a \cdot a^{-1} = a^{-1} \cdot a = 1_M$$ Logo, para quaisquer $c, d \in M$, tem-se

$$
\begin{align*}
ac = ad &\implies a^{-1}(ac) = a^{-1}(ad) \\
&\implies (a^{-1}a)c = (a^{-1}a)d \\
&\implies 1_M c = 1_M d \\
&\implies c = d
\end{align*}
$$

Provam-se assim que $a$ é simplificável à esquerda. De forma simétrica, prova-se que $a$ é simplificável à direita. Portanto, $a$ é simplicável.

**Corolario:** Num grupo qualquer é válida a lei do corte.

**Proposição:** Seja $(M, \cdot)$ um monóide e seja $a \in M$ um elemento invertível. Então, dado um $b \in M$ qualquer, as equações $$ax = b \quad \text{e} \quad ya = b$$ tem uma e uma só solução.

*Demonstração:* Tem-se $$ax=b \implies a^{-1}(ax) = a^{-1}b \implies x=a{-1}b$$ Logo $a^{-1}b$ é a única solução da equação $ax = b$. Analogamente, $ba^{-1}$ é a única solução da equação $ya = b.$

*exercício 1.23* 

$$
\begin{array}{c|ccc}
\cdot & a & b & c \\
\hline
a & a & b & c \\
b & b & c & a \\
c & c & a & b
\end{array}
$$

$$
\begin{array}{c|cccc}
\cdot & e & f & g & h \\
\hline
e & e & f & g & h \\
f & f & e & h & g \\
g & g & h & e & f \\
h & h & g & f & e
\end{array}
$$

