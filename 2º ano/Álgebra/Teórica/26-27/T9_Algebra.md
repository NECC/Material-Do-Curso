**Teorema:** Seja $G$ um grupo e seja $a \in G$. As condições seguintes são equivalentes se $\langle a \rangle$ é finito
1) $\langle a \rangle$ é finito;
2) $\exists_{m, n\in \mathbb{Z}}, \; m \neq n, \; a^m = a^n$;
3) $\exists_{k \in \mathbb{N}} a^k = 1_G$

>[!note]
> se $\langle a \rangle$ é finito, então $\lvert \langle a \rangle \rvert$ é chamado a ordem de $a$ e denota-se $O(a)$

*Demonstração:*
$(1) \implies (2)$ Sabemos já que $\langle a \rangle = \{a^n \; : \; n \in \mathbb{Z}\}$. Logo esta implicação é imediata.

$(2) \implies (3)$ Suponhamos que $a^m = a^n$ para algum $m, n \in \mathbb{Z} \; e \; m > n$. Então 

$$a^m a^{-n} = a^na^{-m}$$
donde $a^{m -n} = 1_G$. Ora $m > n$ e, portanto, denotando $k = m - n$, tem-se 

$$a^k = 1_G \quad com \quad k \in \mathbb{N}$$
$(3) \implies (1)$ Suponhamos que existe $k \in \mathbb{N}$ tal que $a^k = 1_ G$. Para provar que $\langle a \rangle$ é finito mostraremos que $\langle a \rangle = \{1_G, a, a^2, \dots, a^{k - 1}\}$. Para isso, tomemos $n \in \mathbb{Z}$ arbitrario.
Pelo algoritmo da divisão 
$$\exists_{q \in \mathbb{Z}} \; \exists_{r \in \{0, 1, \dots, k - 1 \}} n = qk + r$$
Logo 
$$
\begin{align}
a^n &= a^{qk + r} \\
&= a^{qk}a^r \\
&= (a^k)^q a^r \\
&= 1_G^q a^r \\
&= 1_G a^r \\
&= a^r
\end{align}
$$

Prova-se assim a igualdade $\langle a \rangle = \{1_G, a, a^2, \dots, a^{k - 1}\}$.

*Corolario:* Seja $G$ um grupo  e seja $a \in G$ tal que $\langle a \rangle$ é finito. Então, a ordem de $a$ é o menor $k \in \mathbb{N}$ tal que $a^k = 1_G$. Seja $k \in \mathbb{N}$ o menor tal que $a^k = 1_G$.

*Demonstração:* Vimos na demonstração do teorema anterior.

$$\langle a \rangle = \{1_G, a, a^2, \dots, a^{k - 1}\}$$

Logo $O(a) = \vert \langle a \rangle \rvert \leq k$. Para deduzir que $O(a) = k$ é necessário provar que os elementos $1_G, a, a^2, \dots, a^{k - 1}$ são todos distintos.
Por contradição, suponhamos que 

$$\exists_{m,n \in \{0, 1, \dots, k - 1\}, \; m, n} a^m = a^n$$
então 
$$a^{m - n} = 1_G$$

Ora $m -n \in \mathbb{N}$ e $m - n < k$ o que contraria a definição de k. Então $\exists_{m,n \in \{0, 1, \dots, k - 1\}, \; m, n} a^m = a^n$ não acontece e portanto $O(a) = k$.

*Observação:* Como se pede verificar nas demonstrações anteriores, se $a \in G$ é um elemento tal que $O(a) = k$, então então $a^n = a^r$, onde $r$ é o resto da divisão de $n$ por $k$, i.e., as potências de $a$ repetem-se ciclicamente com período $k$. Tem-se ainda 
(1) $O(1_G) = 1$
(2) $O(a^{-1} = k = O(a)$
(3) Para qualquer $n \in \mathbb{Z}$
$$a^n = a^r$$
onde $r \in \{0, 1, \dots, k - 1 \}$ é resto da divisão inteira de $n$ para $k$.

*Exemplo:*
$O(a) = 5 \implies \langle a \rangle \{16, a,  a^2, a^3, a^4\}$

$$
\begin{align}
a^23 &= a^3 \quad (23 \pmod 5 = 3) \\
a^62 &= a^2 \quad (62 \pmod 5 = 2) \\
a^{-16} &= a^4 \quad (-16 \pmod 5 = 4)
\end{align}
$$

Em particular,

$$
\forall_{n \in \mathbb{Z}}(a^n = 1_G \iff k | n)
$$

