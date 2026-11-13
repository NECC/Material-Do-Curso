
# Homomorfismos

**Definição.** Sejam $(G, \cdot)$ e $(H, *)$ grupos. Uma aplicação $\varphi: G \to H$ diz-se um homomorfismo se 
$$\forall_{x, y \in G} \phi(x \cdot y) = \phi(x) * \phi(y)$$ 

**Definição.** Um homomorfismo $\varphi: G \to G'$ diz-se um:
- *monomorfismo* se é uma aplicação injetiva
- *epimorfismo* se é uma aplicação sobrejetiva
- *isomorfismo* se é uma aplicação bijetiva. Neste caso diz-se que $G$ é isomorfo a $G'$ e escreve-se $G \cong G'$

**Lema.** A relação $\cong$ é uma equivalencia no conjunto de todos os grupos. Ou seja, $G \cong G$ (a $id_G$ é um isomorfismo); $G \cong G' \implies G' \cong G$ ($\varphi: G \to G^{-1} \implies \varphi^{-1}: G^{-1} \to G$); $G \cong G'$ e $G' \cong G'' \implies G \cong G''$ (a composta de um isomorfismo é ainda um isomorfismo)

**Exemplos**
1) Se $G$ e $G'$ são grupos, então 
$$
\begin{align}
id_G: G &\longrightarrow G \\
x &\longmapsto x \\
\end{align}
$$
é um isomorfismo e
$$
\begin{align}
\varphi: G &\longrightarrow G' \\
x &\longmapsto 1_G \\
\end{align}
$$
é um homomorfismo

2) 
$$
\begin{align}
f: (\mathbb{Z}, +) &\longrightarrow (\mathbb{Z}, +) \\
x &\longmapsto 2x \\
\end{align}
$$
é um monomorfismo e para além disso é injetiva e 
$$
\begin{align}
\varphi(x + y) &= 2(x + y) \\
&= 2x + 2y \\
&= \varphi(x) + \varphi(y)
\end{align}
$$

para quaisquer $x, y$ e $\mathbb{Z}$

3) 
$$
\begin{align}
\psi: (\mathbb{Z}, +) &\longrightarrow (\mathbb{Z_n}, +_n) \\
x &\longmapsto [x]_n \\
\end{align}
$$
é um epimorfismo

>[!note]- Exemplo 
> Seja $n = 3$, tem-se $2 = 5 = [2]_3$

**Proposição.** Seja $\varphi: G \to G'$ um homomorfismo (de grupos). Então
1) $\varphi(1_G) = 1_{G'}$
2) $\forall_{a \in G} \, \varphi(a^{-1}) = \varphi(a)^{-1}$
3) Se $H \leq G$, então $\varphi(H') = \{x \in G \, : \, \varphi(x) \in H'\} \leq G$
4) Se $H' \leq G'$, então $\varphi(H') = \{x \in G \, : \, \varphi(x) \in H'\} \leq G$

**Demonstração.**

1) $\varphi(1_G) \in G'$ e 

$$
\begin{align}
\varphi(1_G) \cdot \varphi(1_G) &= \varphi(1_G \cdot 1_G) \quad \text{pois, } \varphi \text{ é homomorfismo} \\
&= \varphi(1_G)
\end{align}
$$

$\therefore \, \varphi(1_G)$ é idempotente
$\therefore \varphi(1_G) = 1_{G'}$

2) 

$$
\begin{align*}
\varphi(a^{-1}) &= \varphi(a^{-1}) \quad \text{pois, } 1_G \in H \text{ já que } H \leq G \\
&= \varphi(1_G) \\
&= 1_{G'} \\
\end{align*}
$$

$\therefore \varphi(a^{-1} = \varphi(a^{-1})$

3)
i) $1_{G'} = \varphi(1_G) \in \varphi(H)$ pois, $1_G \in H$ já que $H \leq G$. 

ii) Sejam $a, b \in \varphi(H)$. Então 

$$a = \varphi(x) \quad e \quad b = \varphi(H) \quad \text{para alguns } x, y \in \varphi(H)$$

Logo,

$$
\begin{align}
ab^{-1} &= \varphi(x)\varphi(y)^{-1} \\
&= \varphi(x)\varphi(y^{-1}) \quad \text{por 2)} \\
&= \varphi(xy^{-1]}) \quad \text{pois } \varphi \text{ é homomorfismo}
\end{align}
$$

Dado que $xy^{-1} \in H$ por $H$ ser subgrupo de $G$, conclui-se que $ab^{-1} \in \varphi(H)$. Por i) e ii), deduz-se do critério II de subgrupo que $\varphi(H) \leq G'$

*Exercicio 1.52*

Consideremos $\varphi_n$ com $z \in \mathbb{Z}$. Tem-se: 
$$\varphi(x + y) = x + y + n$$
$$\varphi(x) + \varphi(y) = (x + n) + (y + n) = (x + y) + 2n$$
Tem-se $\varphi(x + y) = \varphi(x) + \varphi(y) \, \forall_{x,y \in \mathbb{Z}}$ se e só se $n = 2n$ se e só se $n = 0$. Logo $\varphi_n$ é homomorfismo se e só se $n = 0$.
- $\varphi_0$ é um isomorfismo (também se diz um automorfismo por ser um isomorfismo de $(\mathbb{Z}, +)$ em $(\mathbb{Z}, +)$)
- $f_n$ é homomorfismo para todo o $n$ pois $\forall_{x, y \in \mathbb{Z}} \, f_n(x + y) = n(x + y) = nx + ny = f_n(x) + f_n(y)$
se $n \neq 0$, então $f_n$ é injetiva
se $n= 0$, então $f_n$, não é injetiva nem subjetiva. Logo $f_0$ é homomorfismo 
- $f_1$ e $f_{-1}$ são isomorfismo.
- $f_n$ com $n \in \mathbb{Z} \setminus \{-1, 0, 1\}$ é monomorfismo.

