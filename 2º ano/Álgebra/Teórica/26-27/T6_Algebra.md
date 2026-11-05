**Definição**
Seja $(G, \cdot)$ um grupo e seja $H \subseteq D$. Diz-se que o $H$ é subgrupo de $G$, e escreve-se $H \leq G$, se
1) $\forall_{a, b \in H}a \cdot b \in H$ ($H$ é estável ou fechado para $\cdot$)
2) $(H, \cdot)$ é grupo.

**Teorema (Critérios de subgrupos):**
Seja $(G, \cdot)$ um grupo e seja $H \subseteq G$. As seguintes condições são equivalentes:
1) $H \leq G$;
2)
  i) $1_G \in H$;
  ii) $\forall_{a, b \in H} a \cdot b \in H$;
  iii) $\forall_{a \in H} a^{-1} \in H$;
3) 
  i) $1_G \in H$;
  ii) $\forall_{a, b \in H} a \cdot b^{-1} \in H$; (Combinação do 2) i) e do 2) ii))

*Demonstração:*
$(1) \implies (2)$
  Assumimos como hipótese que $H \leq G$.
A condição 2) ii) é válida pela hipótese $H \leq G$.
A condição 2) i) por hipótese $(H, \cdot)$ é grupo, logo $\exists_{e \in H} \forall_{a \in H} e \cdot a = a \cdot e = a$.
  Em particular o $e \cdot e = e$. Logo. $\cancel{e} \cdot e = \cancel{e} \cdot 1_G \iff 1_G = e$ e dai, pela lei do corte, que é válida em qualquer grupo, $e = 1_G.$ Portanto, $1_G \in H$.

2) iii) Por $(H, \cdot)$ ser grupo, tem-se $\forall_{a \in H}a \cdot a' = a' \cdot a = e$. Seja $a \in H$. Então existe um $a' \in H$, tal que $a \cdot a' = e$. Logo,$$a \cdot a' = e = 1_G = a \cdot a^{-1}$$ então, pela lei do corte o $a' = a^{-1}$.

$(2) \implies (3)$

3) i) é válida por hipótese pois, é a condição 2) i)
3) ii) Sejam $a, b \in H$. Por 2) iii), $b^b{-1} \in H$. Logo por 2) ii), $a \cdot b^{-1} \in H$.

$(3) \implies (1)$
Admitimos (3) e queremos provar que $H \leq G$.
  Para provar que $H$ é fechado para $\cdot$, sejam $a, b \in H$. Então, por 3)ii), $a \cdot(b^{-1})^{-1} \in H$. Ou seja, $a \cdot b \in H$.
Ficou assim provado que $H$ é fechado para $\cdot$;
Falta provar que $(H, \cdot)$ é grupo.
  - $(H, \cdot)$ é grupóide pois $H$ é fechado para $\cdot$;
  - $(H, \cdot)$ é semigrupo pois, $\cdot$ é associativa em $G$ e daí é associativa em $H \in G$.
  - $(H, \cdot)$ é monóide pois, por 3)i), $1_G \in H$. Logo, $\forall_{a \in H} 1_G \cdot a = a \cdot 1_G = a$. Portanto $1_G$ é elemento neutro de $H$. 
  - $(H, \cdot)$ é grupo:
    Seja $b\in H$. Então, por 3)ii), $b{-1} = 1_G \cdot b^{-1} \in H$. Logo, $$\forall_{b \in H} \exists_b^{-1} \in H : b \cdot b^{-1} = b^{-1} \cdot b = 1_G$$.

Como consequência do Teorema (Critérios de subgrupos), tem-se os dois seguintes critérios de subgrupos:

Critério I (de subgrupo)
  Seja $(G, \cdot)$ um grupo e sejam $H \subseteq G$. Então $H \leq G$ se e só se
  i) $1_G \in H$;
  ii) $\forall_{a, b \in H} a \cdot b \in H$;
  iii) $\forall_a \in H a \cdot b^{-1} \in H$.


*exercício 1.32* 

Pelo critério I de subgrupos, $Ca \leq G$ se e só se
i) $1_G \in Ca$
$1_G \in Ca$ se $1_G \cdot a = a \cdot 1_G$, da definição de identidade.
ii) $\forall_{x, y \in Ca} x \cdot y \in Ca$
  Sejam $x, y \in Ca$, temos que $xa = ax$ e $ya = ay$. Quer-se provar que $xy \in Ca$, ou seja $$a(xy) = (xy)a$$
Temos $$a(xy) = (ax)y = (xa)y = x(ay) = (xy) a$$
iii) $\forall_{x \in Ca} x^{-1} \in Ca$
  Seja $x \in Ca$. Então $ax = xa$. Quer-se provar que $x^{-1} \in Ca$, isto é, que $$ax^{-1} = x^{-1}a$$
Ora, de
$$
\begin{align*}
&ax = xa \implies x^{-1}(ax)x^{-1} = x^{-1}(xa)x^{-1} \\
&\implies (x^{-1}a)(xx^{-1}) = (x^{-1}x)(ax^{-1}) \implies (x^{-1}a) 1_G = 1_G(ax^{-1}) \\
&\implies x^{-1}a = ax^{-1}\\
\end{align*}
$$
Portanto o $x^{-1} \in Ca$.
Conclusão: $Ca \leq G$.

