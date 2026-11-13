**Definição:** Se $G$ é um grupo e $H \leq G$ é tal que 
		
$$
\forall_{a \in G} aH = Ha,
$$

dizemos que $H$ é um *subgrupo normal* (ou *subgrupo invariante*) de $G$ e escrevemos $H \unlhd G$.

**Proposição (Critérios de subgrupo normal):** Seja $G$ um subgrupo e seja $H$ um subconjunto de $G$. As seguintes condições são equivalentes:
1) $H$ é subgrupo de $G$;
2) 
  i) $1_G \in H$; 
  ii) $\forall_{a, b \in H} ab \in H$;
  iii) $\forall_{a \in H} a^{-1} \in H$;
  iv) $\forall_{x \in G} \forall_{a \in H} xax^{-1} \in H$
3) 
  i) $1_G \in H$;
  ii) $\forall_{a, b \in H} ab^{-1} \in H$;
  iii) $\forall_{x \in G} \forall_{a \in H}xax^{-1} \in H$

*Observações:*
1) Dado um grupo se tivermos um grupo qualquer
- $\{1_G\} \unlhd G$ pois $a\{1_G\} \{a\} = \{1_G\}a \forall_{a\in G}$
- $G \unlhd G$ pois $aG = G = Ga \forall_{a \in G}$ 
2) Se $G$ é um grupo comutativo, então todos os seus subgrupos são normais.
3) Consideremos o grupo $~\mathcal{S}_3$, que é formado por $id, \rho_ 1 = (1 \ 2 \ 3), \rho_2 = ( 1 \ 3 \ 2), \mu = (2 \ 3), \mu_2 = (1 \ 3), \mu_3 = (1 \ 2)$
Seja $H = \langle \rho_1 \rangle = \{id, \rho_1, \rho_2\}$

$$
\begin{array}{c|c}
H & S_3 \setminus H \\
\hline
id & \mu_1 \\
\rho_1 & \mu_2 \\
\rho_2 & \mu_3 \\
\end{array}
\qquad
\begin{array}{l}
S_3 / H = \{H, S_3 \setminus H\} \\
aH = H = Ha \text{ se } a \in H \\
aH = S_3 \setminus H = Ha \text{ se } a \notin H
\end{array}
$$

Conclusão: $H \unlhd S_3$
4) Se $H \leq G$ e $(G : H) = 2$, então $H \unlhd G$.

*Exercício 1.67:* $G$ grupo $Z_G = \{x \in G : xy = yx \forall_{y \in G}$
a) $Z_G \unlhd G$
b) $G$ é abeliano se e só se $Z_G = G$

i) $1_G \, y = y = y\, 1_G \forall_{y \in G} \implies 1_G \in Z_G = G$
ii) Sejam $a, b \in Z_G$. Então 

$$
\forall_{y_in G} ay = ya \quad e \quad by = yb \quad (*)
$$

Seja $y \in G$. Então
$$
\begin{align} 
(ab)y &= a(by) \\
&= a(yb) \quad \text{por } (*)\\
&= (ay)b \\
&= (ya)b \quad \text{por }(*) \\
&= y(ab)
\end{align}
$$

Logo $ab \in Z_G$

iii) Seja $a \in Z_G$. Então 

$$
\forall_{y \in G} ay = ya \quad (**)
$$

Quer-se provar que 

$$
a^{-1}y = ya^{-1}
$$

Seja $y \in G$. Então

$$
\begin{align}
a^{-1}y &= a^{-1}(y^{-1})^{-1} \\ 
&= (y^{-1}a)^{-1} \\
&= (ay^{-1})^{-1} \quad \text{por } (**) \\
&= (y^{-1})^{-1}a^{-1} \\
&= ya^{-1}
\end{align}
$$

Logo $a^{-1} \in Z_G$


iv) Sejam $x \in G$ e $a \in Z_G$. Então

$$
\forall_{y \in G} \; ay = ya \quad (***)
$$

Em particular, para $y = x$ temos $ax = xa$, logo

$$
\begin{align}
xax^{-1} &= axx^{-1} \quad \text{por } (***) \\
&= a\,1_G \\
&= a \in Z_G
\end{align}
$$

De i), ii) e iii) conclui-se que $Z_G \leq G$ e, por iv), que $Z_G \unlhd G$ (critério 2). $\blacksquare$

b) ($\Rightarrow$) Se $G$ é abeliano, então $xy = yx$ para quaisquer $x, y \in G$, logo todo $x \in G$ está em $Z_G$. Ou seja, $G \subseteq Z_G$ e, como $Z_G \subseteq G$, vem $Z_G = G$.

($\Leftarrow$) Se $Z_G = G$, então todo $x \in G$ comuta com todo $y \in G$, ou seja, $G$ é abeliano. $\blacksquare$

**Grupo quociente:** Seja $G$ um grupo e $H \unlhd G$. Então pode-se definir uma estrutura natural de grupo no conjunto

$$
G/H = \{aH : a \in G\}.
$$

De facto, definindo

$$
\forall_{a, b \in G} \quad (aH)\cdot(bH) = (ab)H,
$$

obtém-se uma operação binária em $G/H$ que o torna um grupo, chamado o *grupo quociente de $G$ por $H$*. Neste grupo:

- $H$ é o elemento identidade, ou seja, $1_{G/H} = 1_G H = H$;
- $a^{-1}H$ é o inverso do elemento $aH$, isto é, $(aH)^{-1} = a^{-1}H$.

**Epimorfismo canónico:** a aplicação

$$
\pi_H : G \to G/H, \qquad a \mapsto aH
$$

é um homomorfismo sobrejetivo, chamado o *epimorfismo canónico* de $G$ em $G/H$.

**Consequência do Teorema de Lagrange:** se $G$ é um grupo finito e $H \unlhd G$, então

$$
|G/H| = (G : H) = \frac{|G|}{|H|}.
$$

**Definição (núcleo):** o *núcleo* de um homomorfismo $\Phi : G \to G'$, denotado $\text{Ker}\,\Phi$ (ou $\text{Nuc}\,\Phi$), é o conjunto

$$
\text{Ker}\,\Phi = \{a \in G : \Phi(a) = 1_{G'}\} = \Phi^{\leftarrow}(\{1_{G'}\}).
$$

Dado um homomorfismo $\Phi : G \to G'$, se $H' \unlhd G'$, então $\Phi^{\leftarrow}(H') \unlhd G$. Em particular, $\text{Ker}\,\Phi \unlhd G$, pois $\{1_{G'}\} \unlhd G'$.

**Teorema Fundamental do Homomorfismo:** Seja $\Phi : G \to G'$ um homomorfismo de grupos com núcleo $K = \text{Ker}\,\Phi$. Então $\Phi(G)$ é um grupo e existe um isomorfismo canónico

$$
\Psi : G/\text{Ker}\,\Phi \to \text{Im}\,\Phi, \qquad a\,\text{Ker}\,\Phi \mapsto \Phi(a)
$$

tal que $\Phi = \Psi \circ \pi$, onde $\pi : G \to G/\text{Ker}\,\Phi$, $a \mapsto a\,\text{Ker}\,\Phi$, é o epimorfismo canónico. Em particular,

$$
G/\text{Ker}\,\Phi \cong \text{Im}\,\Phi.
$$

*Exemplos:*

1) Seja $n \in \mathbb{N}$ e

$$
\begin{align}
\varphi : (\mathbb{Z}, +) &\longrightarrow (\mathbb{Z}_n, +) \quad \text{é um homomorfismo sobrejetivo} \\ 
a &\longmapsto [a]_n
\end{align}
$$

$\varphi$ é um homomorfismo sobrejetivo, pois $\varphi(a+b) = [a+b]_n = [a]_n + [b]_n$.

$$
\text{Ker}\,\varphi = \{a \in \mathbb{Z} : \varphi(a) = 0(mod \, n)\} = n\mathbb{Z}
$$

Logo, pelo Teorema Fundamental do Homomorfismo,

$$
\mathbb{Z}/n\mathbb{Z} \cong \mathbb{Z}_n.
$$

2) Seja

$$
\begin{align}
\varphi : \mathcal{S}_n &\longrightarrow \mathbb{Z}_2 \\ 
\sigma &\longmapsto
\begin{cases}
0 & \text{se } \sigma \text{ é par} \\
1 & \text{se } \sigma \text{ é ímpar}
\end{cases}
\end{align}
$$

- $\varphi$ é um epimorfismo 
- $\text{Ker}\,\varphi = \mathcal{A}_n$

Logo, pelo Teorema Fundamental do Homomorfismo,

$$
\mathcal{A}_n \unlhd \mathcal{S}_n \quad \text{e} \quad \mathcal{S}_n/\mathcal{A}_n \cong \mathbb{Z}_2.
$$

Então

$$
\frac{|\mathcal{S}_n|}{|\mathcal{A}_n|} = |\mathbb{Z}_2| = 2, \quad \text{donde} \quad |\mathcal{A}_n| = \frac{n!}{2}.
$$


