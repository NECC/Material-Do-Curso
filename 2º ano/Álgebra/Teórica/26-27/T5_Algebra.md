$\textbf{Lema.}$ Seja $(M, \cdot)$ um monóide e $a \in M$. Se $a$ é invertível então, para todo $b \in M$, as equações

$$ax = b \quad \text{e} \quad ya = b$$

têm uma e uma só solução.

$\textbf{Teorema.}$ Seja $G$ um semigrupo. As seguintes condições são equivalentes:

1. $G$ é grupo;
2. As equações $ax = b$ e $ya = b$ são solúveis para quaisquer $a, b \in G$;
3. Verificam-se:
   - (i) $\exists_{e \in G} \forall_{a \in G}\; ea = a$;
   - (ii) $\forall_{a \in G} \exists_{a' \in G}\; a'a = e$;
4. Verificam-se:
   - (i) $\exists_{e \in G} \forall_{a \in G}\; ae = a$;
   - (ii) $\forall_{a \in G} \exists_{a' \in G}\; aa' = e$;

$\textbf{Definição.}$ Seja $(G, \cdot)$ um grupóide e seja $A \subseteq G$. Diz-se que $A$ é fechado para $*$ se

$$\forall_{a, b \in A}\; a * b \in A$$

Exemplos:

1. Consideremos o semigrupo $(\mathbb{N}, \cdot)$. Então os conjuntos $P = \{n \in \mathbb{N} : n \text{ é par}\}$ e $I = \{n \in \mathbb{N} : n \text{ é ímpar}\}$ são fechados para $\cdot$.
2. $P$ é fechado em $(\mathbb{N}, +)$ mas $I$ não é fechado (por exemplo, $1 + 3 = 4 \notin I$).

$\textbf{Definição.}$ Seja $(G, \cdot)$ um grupo e seja $A \subseteq G$. Diz-se que $A$ é um subgrupo de $G$, se

1. $A$ é fechado para $\cdot$, ou seja, $\forall_{a, b \in A}\; a \cdot b \in A$;
2. $(A, \cdot)$ é um grupo.

Escrevem-se então $A \leq G$.

Exemplos:

1. Dado um grupo $G$ qualquer, existem sempre os seguintes subgrupos de $G$:
   - o *subgrupo trivial*: $\{1_G\} \leq G$
   - o *subgrupo impróprio*: $G \leq G$

   Um subgrupo de $G$ que não é impróprio é dito um *subgrupo próprio* de $G$.
2. $(\mathbb{Z}, +) \leq (\mathbb{R}, +)$
3. Seja $n\mathbb{Z} = \{na : a \in \mathbb{Z}\}$, onde $n$ é um elemento fixo de $\mathbb{Z}$. Então $(n\mathbb{Z}, +) \leq (\mathbb{Z}, +)$. Por exemplo:

   $$3\mathbb{Z} = \{\dots, -9, -6, -3, 0, 3, 6, 9, \dots\}$$

*Resolução do exercício 1.28 da folha 1:*

Seja $G = \{e, f, g, h\}$. Os subgrupos de $G$ são:
- $\{e\}$, o subgrupo trivial, que é de ordem 1;
- $\{e, f\}$, $\{e, g\}$, $\{e, h\}$, que têm ordem 2;
- $G$, o subgrupo impróprio, que é de ordem 4.

Não existem subgrupos de ordem 3. Veremos posteriormente que isto acontece devido ao facto de 3 não ser um divisor de $4 = |G|$.

Seja $H = \{1, i, -1, -i\}$. Os subgrupos de $H$ são:
- $\{1\}$, o subgrupo trivial, de ordem 1;
- $\{1, -1\}$, que é o único subgrupo de ordem 2;
- $H$, o subgrupo impróprio de ordem 4.

