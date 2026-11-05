**Teorema de Lagrange:** $\lvert H \rvert$ divide $\lvert G \rvert$ ou seja $\lvert G \rvert = n \lvert H \rvert$

*Demonstração:*
$\lvert H \rvert, \vert H \rvert$ e $(G : H)$ são finitas pois $G$ é finita. Seja 

$$
n= (G : H). \text{ Então } \, G/H = \{a_1H, a_2H, \dots, a_nH\}
$$

e

$$
G = a_1H \bigcup^\cdot a_2H \bigcup^\cdot \dots \bigcup^\cdot a_nH
$$

Logo, 

$$
\begin{align}
\lvert G \rvert &= \lvert a_1 H \rvert + \lvert a_2 H \rvert + \dots + \lvert a_n H \rvert \\
&= \underbrace{\lvert H \rvert + \lvert H \rvert + \dots + \lvert  H \rvert}_{n \text{ vezes}} \quad \text{pois } \lvert a_i H \rvert = \lvert H \rvert
&= n \lvert H \rvert \\
&= (G : H) \lvert H \rvert 
\end{align}
$$

**Proposição:** Todo o grupo de ordem $p$, onde $p$ é primo, é cíclico.

*Demonstração:* 
$$
\lvert G \rvert = p \quad p \text{ primo}
$$

Seja $a \in G \setminus \{1_G\}$. Pelo teorema de Lagrange

$$
ord(a) \text{ divide } \lvert G \rvert = p
$$

$\therefore ord(a) = 1$ ou $ord(a) = p$
$\therefore ord(a) = p$ pois $a \neq 1_G$
$\therefore \langle a \rangle = G$
$\therefore G$ é cíclico 

*Exercício 1.61:*

- $K \leq H$ pois $K \leq G$ e $k \subseteq H$

Pelo teorema de Lagrange

$$
\begin{align}
\lvert G \rvert &= (G : H) \lvert H \rvert \quad \text{pois } H \leq G \\
\lvert G \rvert &= (G : K) \lvert K \rvert \quad \text{pois } K \leq G \\
\lvert H \rvert &= (H : K) \lvert K \rvert
\end{align}
$$

$$
\begin{align}
\therefore (G:H) &= \frac{\lvert G \rvert}{\lvert K \rvert} \\
&= \frac{(G : H) \lvert H \rvert}{\frac{\lvert H \rvert}{(H:K)}} \\ &= (G:K)(H:K)
\end{align}
$$
