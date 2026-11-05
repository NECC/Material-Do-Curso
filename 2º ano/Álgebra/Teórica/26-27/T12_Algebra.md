**Definição:** Seja $\varphi : G \to G'$ um homomorfismo de grupos. Defina-se 

$$
Im \,\varphi = \varphi (G) = \{\varphi(x) : x \in G\} \quad \text{a "imagem de } \varphi \text{"}
$$
e
$$
Nuc\,\varphi = Ker\, \varphi = \{x \in G : \varphi(x) = 1_{G'} \} \subseteq G \quad \text{o "núcleo de } \varphi \text{" ou "Kernel de } \varphi \text{"}
$$

**Proposição:** Seja $\varphi : G \to G'$ um homomorfismo de grupo. Então:
1) $\forall_{i \in \varphi} \leq G$ e $Im \, \varphi = G'$
2) $\varphi$ é um epimorfismo se e só se $Im \, \varphi = G'$
3) $\varphi$ é um monomorfismo se e só se $Nuc \, \varphi = \{1_G\}$.

*Demonstração.*
1)
$$
\begin{align}
G \leq G &\implies Im\, \varphi = \varphi(G) \leq G' \\
\{1_G\} \leq G &\implies Nuc \, \varphi = \varphi^{\leftarrow}(\{1_G\}) \leq G
\end{align}
$$
pois homomorfismo transforma subgrupos em subgrupos e as imagens recíprocas de subgrupos ainda são subgrupos.

2) É imediato pela definição de aplicação subjetiva. $\varphi$ é subjetiva se e só se $\varphi(G) = G'$

3) 
$(\implies)$
Se $\varphi$ é injetiva, então não existe $a \in G$ tal que $a \neq 1_G$ e $\varphi(a) = \varphi (1_G)$. Logo, como $\varphi(1_G) = 1_{G'}$, necessariamente $Nuc \, \varphi = {1_G}$.

$(\impliedby)$
Sejam $a, b \in G$. Tem-se 
$$
\begin{align}
\varphi(a) = \varphi(b) &\implies \varphi(a) \varphi(b)^{-1} = \varphi(b)\varphi(b^{-3})\\
&\implies \varphi(a)\varphi(b') = 1_G \\
&\implies\varphi(ab^{-1}) = 1_{G'}\\
&\implies ab^{-1} = 1_G \quad \text{pois por definição} Nuc \, \varphi = \{1_G\} \\
&\implies a = b
\end{align}
$$
Logo $\varphi$ é injetiva 

Sabemos já que, num grupo $G$, se $a \in G$, então 

$$
\langle a \rangle = \{a^n : n \in \mathbb{Z}\}
$$

Se $G$ é cíclico e gerado por $a$, então 

$$
G = \left\{ 
\underset{\overset{\downarrow}{n}}{\dots}, 
\underset{\overset{\downarrow}{-3}}{a^{-3}}, 
\underset{\overset{\downarrow}{-2}}{a^{-2}}, 
\underset{\overset{\downarrow}{-1}}{a^{-1}}, 
\underset{\overset{\downarrow}{0}}{1_G}, 
\underset{\overset{\downarrow}{1}}{a}, 
\underset{\overset{\downarrow}{2}}{a^2}, 
\underset{\overset{\downarrow}{3}}{a^3}, 
\underset{\overset{\downarrow}{n}}{\dots} 
\right\}
$$

**Proposição:**  Seja $G = \langle a \rangle$ um grupo cíclico
1) Se $G$ é infinito, então $(G, \cdot) \cong (\mathbb{Z}, +)$
2) Se $G$ é finito e a ordem de $G$ é $n$ ($\lvert G \rvert = n$), então $(G, \cdot) \cong (\mathbb{Z}, +_n)$

*Demonstração:* 
Suponhamos que $G$ é infinito. Então 

$$
G = \{a^n : n \in \mathbb{Z}\}
$$
e
$$
\forall_{m,n \in \mathbb{Z}}a^m = a^n \iff m = n \quad \text{*}
$$

Consideremos a correspondência $\varphi : G \to \mathbb{Z}$

$$
\begin{align}
\varphi : G \longrightarrow \mathbb{Z} \\
a^m \longmapsto n
\end{align}
$$

- $\varphi$ é a aplicação injetiva: para $m,\, n \in \mathbb{Z}$

$$
\begin{align}
a^m  = a^n &\iff m = n \quad \text{por *} \\ 
&\iff \varphi(a^m) = \varphi(a^n)
\end{align}
$$

- $\varphi$ é sobrejetiva: dado $n \in \mathbb{Z}$, $n = \varphi(a^n)$.

- $\varphi$ é homomorfismo: para $m, n \in \mathbb{Z}$

$$
\varphi(a^m \cdot a^n) = \varphi(a^{m + n}) = m + n = \varphi(a^m) + \varphi(a^n) \\
$$
$\therefore \varphi \text{ é um isomorfismo}$

2. exercício

Provou-se assim que, a menos de isomorfismo: $(\mathbb{Z}, +)$ é o único grupo cíclico infinito e $(\mathbb{Z}_m, +_ n)$ é o único grupo cíclico finito de ordem $n$.

*Exercício 1.52:*
Para $x, y \in \mathbb{Z}$

$\varphi(x, y) = e^{x+y} = e^x \, e^y = \varphi(x) \varphi(y)$

$\therefore \varphi$ é um homomorfismo 

$\psi$ é bijetiva
