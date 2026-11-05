Vimos na última aula que dado um grupo $G$ e $A \subseteq G$, existe um único subgrupo $\langle A \rangle$, chamado o subgrupo gerado por $A$, que contém $A$ e é o menor nessas condições.

*Observação:* Sejam $G$ um grupo e $A, H \subseteq G$.
Então, $H = \langle A \rangle$ se e só se
1) $A \leq G$
2) $A = H$
3) $(K \leq G \land a \subseteq K) \implies H \subseteq K$.

**Questão:** Dado um grupo $G$ e um elemento $a \in G$, como identificar $\langle a \rangle$?
- $a \in \langle a \rangle$
- $\langle a \rangle \leq G$ e portanto: 
  - $1_G \in \langle a \rangle$
  - $\langle a \rangle$ é fechado para o produto
  - $\langle a \rangle$ é fechado para inversos

Logo, 
$$
\begin{align}
a^{-n} &\in \langle a \rangle \\
a^0 &= 1_G \in \langle a \rangle \\
a^1 &= a \in \langle a \rangle \\
a^2 &\in \langle a \rangle \\
\vdots \\
a^n &\in \langle a \rangle \\
\end{align}
$$

Ou seja, $\langle a \rangle$ contém todas as potências de $a$. Ou seja, $\langle a \rangle \subseteq \{a^n : n \in \mathbb{Z}$.

Ora, $\{a^n : n \in \mathbb{Z}\} \leq G$ pelo critério I de subgrupo. 

Logo, $\langle a \rangle = \{a^n : n \in \mathbb{Z}\}$

Provou-se assim: 

**Lema:**
Seja $G$ um grupo e seja $a \in A$. Então $\langle a \rangle = \{a^n : n \in \mathbb{Z}\}$.

Em notação aditiva
Se $(G, +)$ é um grupo e $a \in G$, então $\langle a \rangle = \{na : n \in \mathbb{Z}\}$.
Em $(\mathbb{Z}, +)$,

$$
\langle 3 \rangle = \{n3 \in \mathbb{Z} : n \in \mathbb{Z}\} = 3 \mathbb{Z}
$$

**Definição:**
Dado um grupo $G$ e $a \in G$, a ordem do subgrupo $\langle a \rangle$ é dita a ordem (ou periodo) de $a$
Se a ordem de $a$ é finita, então é denotado por $o(a)$.


*Exercício 1.33*

![[imgs/ex-133.png]]

a) 
i) 
$\langle I \rangle = \{I\}$

$\langle \alpha \rangle = \{\alpha, \beta, I\}$

$$
\begin{align}
\alpha^0 &= I \\
\alpha^1 &= \alpha \\
\alpha^2 &= \beta \\
\alpha^3 &= \alpha \alpha^3 = \alpha \beta = I \\
\end{align}
$$

$\langle \beta \rangle = \{\beta, \alpha, I\} = \langle \alpha \rangle$

$$
\begin{align}
\beta^2 &= \beta\beta = \alpha \\
\alpha^3 &= \beta\beta^2 = \beta\alpha = I \\
\alpha^4 &= \beta \beta^3 = \beta I = \beta
\end{align}
$$

$\langle \gamma \rangle = \{\gamma, I\}$
$\langle \delta \rangle = \{\delta, I\}$
$\langle \epsilon \rangle = \{\epsilon, I\}$

>[!note] **Teorema de Lagrange**
> A ordem do subgrupo divide a ordem do grupo

ii)

$o(I) = 1$

$o(\alpha) = 3$

$o(\beta) = 3$

$o(\gamma) = 2$

$o(\delta) = 2$

$o(\epsilon) = 2$

b) $\langle \alpha, \gamma \rangle \supseteq \langle \alpha \rangle = ? = \{I, \alpha, \gamma, \beta, \epsilon\}$

$$
\begin{align}
\langle \gamma \rangle &\subseteq \langle \alpha, \gamma \rangle \\
\langle \alpha \rangle &\cup \langle \gamma \rangle = \{I, \alpha, \beta, \gamma\} \\
&\downarrow\\
&\text{não é subgrupo pois } \langle \alpha \rangle \nsubseteq \langle \gamma \rangle \text{ e } \langle \gamma \rangle \nsubseteq \langle \alpha \rangle
\end{align}
$$

c) $D_3$ não é cíclico, pois vimos que na alinha a) i) que o $\langle x \rangle \neq D_3$ para todo o $x \in D_3$.

# Links
[[T1_Algebra.md]]
[[T2_Algebra.md]]
[[T3_Algebra.md]]
[[T4_Algebra.md]]
[[T5_Algebra.md]]
[[T6_Algebra.md]]
[[T7_Algebra.md]]
