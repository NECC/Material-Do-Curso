# Subgrupo gerado

**Proposição:** Seja $G$ um grupo e seja $(H_i)_{i \in I}$ uma familia não vazia (i.e., $I \neq \emptyset$) de subgrupos de $G$. 

Então, 
$$
\bigcap_{i \in I} H_i \leq G.
$$
Em particular, se $H_1, H_2 \leq G$, então $H_1 \cap H_2 \leq G$.

*Demonstração:* 

(i) Pelo critério II de subgrupo, $1_G \in H_i$, para todo o $i \in I$.
Logo, 

$$
1_G \in \bigcap_{i \in I} H_i.
$$

>[!note] Critério II de subgrupo:
> Se $G$ é grupo e $H \subseteq G$, então $H \leq G$ se e só se
> (i) $1_G \in H$
> (ii) $\forall_{a, b \in H} a \cdot b^{-1} \in H$

(ii) Sejam $a, b \in \bigcap_{i \in I} H_i$. Então $a, b \in H_i$, para todo $i \in I$.

Logo pelo critério II de subgrupo, $a, b^{-1} \in H_i$ para qualquer $i \in I$. Portanto $a \cdot b^{-1} \in \bigcap_{i \in I} H_i$

Por (i) e (ii) conclui-se do critério II que $\bigcap_{i \in I}H_i \leq G$. 

*Observação:*

Quanto a operação de união de conjunto, o mesmo não acontece. Isto é, existem grupos $G$ e subgrupos $H_1$ e $H_2$ de $G$ tais que $H_1 \cup H_2$ não é subgrupo de $G$.

*Exemplo:*

Considera-se o grupo $(\mathbb{Z}, +)$ e os subgrupos $2 \mathbb{Z}$ e $3 \mathbb{Z}$. A união $2 \mathbb{Z} \cup 3 \mathbb{Z}$ não é subgrupo de $( \mathbb{Z}, +)$. De facto, $-4, 9 \in 2 \mathbb{Z} \cup 3 \mathbb{Z}$ e no entanto $-4 + 9 \notin 2 \mathbb{Z} \cup 3 \mathbb{Z}$

**Proposição:** Sejam $G$ um grupo e $H_1, H_2 \leq G$. Então 

$$
H_1 \cup H_2 \leq G \iff (H_1 \subseteq H_2 \lor H_2 \subseteq H_1) 
$$

*Demonstração:* Exércicio

**Definição:**
Sejam $G$ um grupo e $A$ um subconjunto de $G$.

(a) Existe pelo menos um subconjunto de $G$ que contém $A : G$. 

(b) $A$ interseção de todos os grupos de $G$ que contém $A$ ainda é um subgrupo de $G$ (e é claro que contém $A$).
Este subgrupo é denotado por $\langle A \rangle$

(c) $\langle A \rangle$ é o menor subgrupo de $G$ que contém $A$ e é chamado o *subgrupo de G gerado por A*. 

(d) O conjunto $A$ é chamado um *conjunto de geradores* de $\langle A \rangle$.

(e) Se $A = \{a_1, a_2, \dots, a_n\}$, então denota-se $\langle a_1, a_2, \dots, a_n \rangle$ em vez de $\langle A \rangle$.

(f) $\langle \emptyset \rangle = \{1_G\}$

(g) $\langle G \rangle = G$

*Exemplo:*
Considere-se o grupo $(\mathbb{Z}, +)$. Tem-se

$$
\begin{align}
\langle 2 \rangle &= 3 \mathbb{Z} = \{-6, -3, 0, 3, 6\}\\
\langle 3, 9 \rangle &= n \mathbb{Z} = 3 \mathbb{Z}, \quad \text{onde } n = m.d.c(6, 9)
\end{align}
$$

**Definição:** Um grupo $G$ diz-se cíclico se existe $a \in G$ tal que $G = \langle a \rangle$

*Exemplo:*
1) $(\mathbb{Z}, +)$ é grupo cíclico por $\mathbb{Z} = \langle 1 \rangle$.
2) $\mathbb{Z}_n = \{\overline{0}, \overline{1}, \dots, \overline{n -1}\}$
$(\mathbb{Z}_n, +)$, com a adição módulo $n$, é um grupo cíclico pois $\mathbb{Z}_n = \langle \overline{1} \rangle$.
3) O grupo $G = \{e, a, b, c\}$ (4-Klein cíclico)


$$
\begin{align}
\langle e \rangle &= \{e\} \\
\langle a \rangle &= \{e, a\} \\
\langle b \rangle &= \{e, b\} \\
\langle c \rangle &= \{e, c\} \\
\end{align}
$$

