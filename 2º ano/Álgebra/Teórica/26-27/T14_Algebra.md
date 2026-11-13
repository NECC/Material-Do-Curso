**Teorema (Cayley, 1854):** Todo o grupo é isomorfo a algum subgrupo de permutações, $\mathcal{S}_G$.

*Demonstração (ideia):*
Mostrar que 

$$
\varphi : G \longrightarrow \mathcal{S_G} \\
x \longmapsto ax
$$

é um monomorfismo. Logo, $G \cong Im\,\varphi$.

**Proposição:** Toda a permutação $o \in \mathcal{S_G}$ é um produto de ciclos disjuntos.

*Exemplo:* 

$$
\begin{matrix} x \\ f(x) \end{matrix}
\begin{pmatrix}
1 & 2 & 3 & 4 & 5 & 6 \\
3 & 5 & 6 & 4 & 2 & 1
\end{pmatrix}
= (1\ 3\ 6)(2\ 5)\underset{\text{pode ser omitida}}{\underbrace{(4)}_{id}} = (1\ 3\ 6)(2\ 5)
$$

*Observação:* 
1) Ciclos disjuntos comutam $\theta\gamma = \gamma\theta$ e $\theta$ e $\gamma$ são ciclos disjuntos;
2) A inversa de um ciclo é um ciclo: $(i_1, i_2, \dots, i_k)^{-1} = (i_k, i_{k-1}, \dots, i_2, i_1)$ 

*Exemplo:*

$$
\theta = (2 \quad 3)(1 \quad 6 \quad 5)(7)(4 \quad 8) \in S_8
$$

$$
\begin{align*}
\theta^2 &= (2 \quad 3)^2 (1 \quad 6 \quad 5)^2 \underbrace{(7)^2}_{id} (4 \quad 8)^2 \\
&= id \, (1 \quad 5 \quad 6)(id) \, (id) = (1 \quad 5 \quad 6)
\end{align*}
$$


$$
\begin{align*}
\theta^3 &= (2 \quad 3)^3 (1 \quad 6 \quad 5)^3 \underbrace{(7)^3}_{id} (4 \quad 8)^3 \\
&= (2 \quad 3)^2(2 \quad 3) \, id \, (id) \, (4 \quad 8)^2(4 \quad 8) \\
&= id \, (2 \quad 3) \, id \, id \, (id) \, (4 \quad 8) \\
&= (2 \quad 3)(4 \quad 8)
\end{align*}
$$

$$
\theta^4 = (1 \quad 6 \quad 5)
$$

$$
\theta^5 = (2 \quad 3)(1 \quad 5 \quad 6)(4 \quad 8) 
$$

$$
\theta^6 = id
$$

$$
\therefore \underset{\text{ordem}}{O(\theta)} = m.m.c(2, 3, 1, 2)
$$

**Proposição:** Se $\theta = \theta_1 \theta_2 \dots \theta_k$ em que $ \theta_1 \theta_2 \dots \theta_k$ são ciclos disjuntos dois a dois, então $O(\theta) = m.m.c(O(\theta_1), O(\theta_2), \dots, O(\theta_k))$

*Exemplo:*
Se $\sigma = (2 \quad 5)(1 \quad 3 \quad 6)$, então $\mathcal{O}(\sigma) = m.m.c(2, 3) = 6$
Se $\gamma = (2 \quad 4)(3 \quad 1 \quad 5 \quad 8)(9 \quad 7 \quad 6)$ então $\mathcal{O}(\gamma) = m.m.c(2, 4, 3) = 12$

*Exemplo:* partir como produto de ciclos de comprimento 2
$$
\begin{align*}
(1 \quad 3 \quad 2 \quad 5) &= (1 \quad 3)(3 \quad 2)(2 \quad 5) \\
&= (1 \quad 5)(1 \quad 2)(1 \quad 3) \\
&= (1 \quad 5)(1 \quad 2)(1 \quad 3)\underbrace{(1 \quad 7)(1 \quad 7)}_{id.}
\end{align*}
$$

Mais geralmente,
$$
\begin{align*}
(i_1 \quad i_2 \quad \dots \quad i_k) &= (i_1 \quad i_2)(i_2 \quad i_3)\dots(i_{k-1} \quad i_k) \\
&= (i_1 \quad i_k)(i_1 \quad i_{k-1})(i_1 \quad i_{k-2})\dots(i_1 \quad i_2)
\end{align*}
$$

Ou seja, qualquer ciclo é produto de *transposições*, ou seja de ciclos de comprimento 2.

**Proposição:** Toda a permutação $\theta \in \mathcal{S}_n$ é um produto de transposições.

**Teorema:** Seja $\theta \in \mathcal{S}_n$ e suponhamos que $\theta = \alpha_1 \ \alpha_2 \dots \alpha_r = \beta_1 \beta_2 \dots \beta_s$ em que o $\alpha_i e \beta_i$ são transposições. Então
1) $r$ e $s$ são ambos pares, ou
2) $r$ e $s$ são ambos ímpares.

Diz-se então que 
- $\theta$ é uma *permutação par* se acontece o caso (1).
- $\theta$ é uma *permutação ímpar* no caso (2).

*Exemplo:*

i) Identifiquemos a paridade da permutação
$$
\sigma = (2 \quad 6 \quad 3)(4 \quad 3 \quad 8 \quad 1 \quad 2)(3 \quad 4)(2 \quad 3 \quad 7 \quad 8)
$$
Tem-se
$$
\sigma = \underbrace{(2 \quad 6)(6 \quad 3)(4 \quad 3)(3 \quad 8)(8 \quad 1)(1 \quad 2)(3 \quad 4)(2 \quad 3)(3 \quad 7)(7 \quad 8)}_{10}
$$
Logo, $\sigma$ é uma permutação par, pois é um produto de 10 trans-
posições e 10 é um número par.

ii) Qual a ordem de $\sigma$?
$$
\mathcal{O}(\sigma) = \, ?
$$
Os ciclos que compõem o $\sigma$ não são disjuntos. Para calcular a ordem
é preciso escrever $\sigma$ como o produto de ciclos disjuntos.
Ora,
$$
\begin{align*}
\sigma &= \begin{pmatrix}
1 & 2 & 3 & 4 & 5 & 6 & 7 & 8 \\
6 & 2 & 7 & 8 & 5 & 3 & 1 & 4
\end{pmatrix} \\
&= (1 \quad 6 \quad 3 \quad 7)(2)(4 \quad 8)(5) = (1 \quad 6 \quad 3 \quad 7)(4 \quad 8)
\end{align*}
$$
Logo $\mathcal{O}(\sigma) = m.m.c.(4, 2) = 4$
