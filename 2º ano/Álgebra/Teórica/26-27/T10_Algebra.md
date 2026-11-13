
*exercício 1.38*

>[!reminder]- 
> Recorde-se que um elemento $a \in G$ tem ordem finita se e só se 
> $$\exists_{k \in \mathbb{N}} a^k = 1_ G$$
> Pelo critério I de subgrupo, $T_G$ é subgrupo de $G$ se e só se
> i) $1_G \in T_G$
> ii) $\forall_{a, b \in T_G} ab \in T_G$
> iii) $\forall_a \in T_G a^{-1} \in T_G$

i) Tem-se $O(1_G)$. Logo $1_G \in T_G$ 
ii) Sejam $a, b \in T_G$. Então existem $m, n \in \mathbb{N}$ tais que $a^m = 1_G \quad e \quad b^n = 1_G$
Quer-se mostrar que $ab \in T_G$, ou seja, que 
$$\exists_{k \in \mathbb{N}}(ab)^k = 1_G$$
Seja $ k = m \cdot n$. Então
$$
\begin{align}
(ab)^k &= a^kb^k\\ 
&= (a^m)^n (b^n)^m \\
&= 1_G^n1_G^m \\
&= 1_G
\end{align}
$$
Portanto $ab$ tem ordem finita e, por isso, $ab \in T_G$
iii) Seja $a \in T_G$. Então existe $m \in \mathbb{N}$ tal que 
$$\exists_{k \in \mathbb{N}} (a^{-1})^k = 1_G$$
Seja $k = m$. Então
$$
\begin{align}
(a^{-1})^k &= (a^{-1})^m \\
&= (a^m)^{-1} \\
&= 1_G^{-1} \\
&= 1_G
\end{align}
$$
Logo $a^{-1}$ tem ordem finita e, portanto $a^{-1} \in T_G$

**Teorema:** Todo o subgrupo de um grupo cíclico ainda é cíclico.
Mais precisamente, se $G = \langle a \rangle$ e $H \leq G$, então $H = \{1_g\} = \langle 1_G \rangle$ ou $H = \langle a^k \rangle$ onde $k$ é o menor natural tal que $a^k \in H$.

*Demonstração:* Sejam $G = \langle a \rangle$ um grupo cíclico, $H$ um subgrupo não trivial de $G$ e $k$ o menor natural tal que $a^k \in H$. Provemos que 

$$H = \langle a^k \rangle$$

Por definição de $\langle a^k \rangle$, tem-se que $\langle a^k \rangle \subseteq H$ pois $H \leq G$, $a^k \in H$ e $\langle a^k \rangle$ é o menor subgrupo de $G$ que contém $a^k$. Para provar a inclusão $H \subseteq \langle a^k \rangle$, consideremos um elemento genérico $x \in H$. Como $G = \langle a \rangle$, tem-se

$$x = a^n$$

para algum $n \in \mathbb{Z}$
Pelo algoritmo da divisão 

$$\exists_{q \in \mathbb{Z}} \; \exists_{r \in \{0, 1, \dots, k - 1\}} n = kq + r$$

Logo, 

$$x = a^n = a^{kq}a^r$$

donde

$$a^r = a^{n-kq}$$

com $n - kq = r \geq 0$ e $r < k$.
Como $a^{n - qk - r} = 1_G$ deduz-se que $r = 0$.
Portanto $a^n = (a^k)^q \in \langle a^k \rangle$.
Conclui-se assim que $H = \langle a^k \rangle$

*Exemplos:*
1) Todos os subgrupos do grupo cíclico $(\mathbb{Z}, +)$ são da forma $\langle n \rangle = n\mathbb{Z}$
2) Seja $G = \langle a \rangle$ um grupo cíclico de ordem $10$ (ou seja, o elemento $a$ tem ordem $10$). Seja $H = \langle a^4 \rangle$. Tem-se
$$H = \langle a^4 \rangle = \{1_G, a^4, a^8, a^2, a^6\} = \langle a^2 \rangle$$

>[!note]-
>$\{1_G, a^4, a^8, a^2, a^6\} = \langle a^2 \rangle \quad$ pois, $2$ é o menor $k \in \mathbb{N}$ tal que $a^k \in H$.

Note-se que $\lvert H \rvert = 5$ e que
$\lvert H \rvert = \frac{O(a)}{2} = \frac{\lvert G \rvert}{2}$

**Proposição:** Seja $G = \langle a \rangle$ um grupo cíclico finito de ordem $n$ e seja $H \leq G$.
Então
1) $\lvert H \rvert$ divide $\lvert G \rvert$.
2) Se $k$ é o menor natural tal que $a^k \in H$, então $\lvert G \rvert = k \lvert H \rvert$.
3) Se $n$ é primo, então $H = \lvert 1_G \rvert$ ou $H = G$.
4) Para qualquer $m \in \mathbb{N}$
$$O(a^m) = \frac{n}{(m, n)} \quad \text{onde } (m,n) = mdc(m, n)$$
Em particular, $a^m$ é um gerador de $G$ se e só se $(m, n) = 1$

