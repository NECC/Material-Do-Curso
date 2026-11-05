**Definição:** Um grupo é um par ordenado $(G, *)$ onde $G$ é um conjunto não vazio, chamado o suporte do grupo, e $*: G \times G \to G$ é uma operação binária
  (i) $\forall_{a, b, c \in G} (a * b) * c = a * (b * c)$
  (ii) $exists_{e \in G} \forall_{a \in G} e * a = a * e = a$
  (iii) $\forall_{a \in G} \exists_{a' \in G} a * a' = a' * a = e$

*Observação:*
1. Num grupo o elemento neutro é único e cada elemento tem um e um só oposto.
2. Um grupo comutativo, ou seja, tal que $\forall_{a, b \in G} a * b = b * a$ é dito um grupo abeliano

Habitualmente usam-se dois tipos de linguagem (notação). A aditiva e a multiplicativa. A mais usada é a multiplicativa.
Em linguagem multiplicativa:
- Num semigrupo $(S, \cdot)$,
  - escreve-se $ab$ em vez de a $a \cdot b$
  - escreve-se $a^2$ em vez de $aa$
  - escreve-se $a^n$ em vez de $\underbrace{aa \dots a}_{\text{n vezes}}$

- Num monóide $(M, \cdot)$, escreve-se 
  - $1_M$ para representar o elemento neutro chamado identidade
  - $a^0$ para representar $1_M$ (onde $a \in M$)

- Num grupo $(G, \cdot)$ denota-se 
  - $a^{-1}$ para representar o elemento oposto de $a \in G$ e é chamado o inverso de $a$
  - $a^{-n}$ o elemento $(a^n)^-1, n \in \mathbb{N}$

Em linguagem aditiva:
- Num semigrupo $(S, +)$
  - $2a$ em vez de $a + a$
  - $na$ em vez de $\underbrace{a + a + \dots + a}_{\text{n vezes}} (n \in \mathbb{N})$

- Num monóide $(M, +)$, escreve-se
  - $0_M$ para representar o elemento neutro chamado elemento zero
  - $0a$ para representar $0_M$

- Num grupo $(G, +)$ denota-se por
  - $-a$ o elemento oposto de $a$, e é chamado o simétrico de $a$
  - $(-n)a$ o elemento $-(na)$ com $n \in \mathbb{N}$

**Proposição:** Seja $(G, \cdot)$ um grupo, sejam $a, b, a_1, a_2, \dots, a_k \in G$, com $k \in \mathbb{N}$, e sejam $m, n \in \mathbb{Z}$. Então:
  (i) $1_G^{-1} = 1_G$
  (ii) $(a^{-1})^{-1} = a$
  (iii) $(ab)^{-1} = b^{-1}a^{-1}$
  (iv) $(a_1 a_2 \dots a_k)^{-1} = a_k^{-1} \dots a_2^{-1} a_1^{-1}$
  (v) $(a^n)^{-1} = (a^{-1})^n$
  (vi) $a^m a^n = a^{m + n}$

*Demonstração:*
> [!check]- **(i)** $1_G^{-1} = 1_G$
> Como $1_G$ é o elemento neutro, $1_G \cdot 1_G = 1_G$. Isto diz exatamente que $1_G$ satisfaz a condição para ser o **inverso de si próprio** ($x$ tal que $1_G \cdot x = x \cdot 1_G = 1_G$). Pela unicidade do inverso, $1_G^{-1} = 1_G$. $\blacksquare$
 
> [!check]- **(ii)** $(a^{-1})^{-1} = a$
> Por definição de $a^{-1}$: $a \cdot a^{-1} = a^{-1} \cdot a = 1_G$. Esta mesma igualdade, lida "ao contrário", diz que $a$ é o inverso de $a^{-1}$. Pela unicidade do inverso, $(a^{-1})^{-1} = a$. $\blacksquare$
 
  (iii) Basta notar que 

$$
\begin{align*}
(ab)(b^{-1}a^{-1}) &= a(bb^{-1})a^{-1} \\
&=a 1_G a^{-1} \\ 
&= aa^{-1} \\
&= 1_G
\end{align*}
$$


> [!check]- **(iv)** $(a_1 a_2 \cdots a_k)^{-1} = a_k^{-1} \cdots a_2^{-1} a_1^{-1}$ — por indução em $k$
> **Base** ($k=1$): trivial, $a_1^{-1} = a_1^{-1}$.
>
> **Caso $k=2$**: é exatamente a alínea (iii).
>
> **Passo indutivo**: suponhamos o resultado válido para $k-1$ (H.I.):
> $$(a_1 \cdots a_{k-1})^{-1} = a_{k-1}^{-1} \cdots a_1^{-1}.$$
> Escrevendo $a_1 \cdots a_k = (a_1 \cdots a_{k-1}) \cdot a_k$ e aplicando (iii) a este produto de **dois** fatores:
> $$(a_1 \cdots a_k)^{-1} = \big[(a_1\cdots a_{k-1}) \cdot a_k\big]^{-1} = a_k^{-1} \cdot (a_1 \cdots a_{k-1})^{-1} \overset{\text{H.I.}}{=} a_k^{-1} \cdot a_{k-1}^{-1} \cdots a_1^{-1}.$$
> $\blacksquare$

Logo $(ab)^{-1} = b^{-1}a^{-1}$.
Repare-se que não é preciso provar que $(b^{-1}a^{-1})(ab) = 1_G$


## Tabela-resumo: multiplicativa vs. aditiva

$$
\begin{array}{l|ll}
\textbf{Conceito} & \textbf{Multiplicativa} & \textbf{Aditiva} \\
\hline
\text{Elemento neutro} & 1_M \text{ (identidade)} & 0_M \text{ (elemento zero)} \\
\text{Oposto de } a & a^{-1} \text{ (inverso)} & -a \text{ (simétrico)} \\
\text{"Potência" } n\text{-ésima} & a^n & na \\
\text{Expoente } 0 & a^0 = 1_M & 0a = 0_M \\
\text{Expoente negativo} & a^{-n} = (a^n)^{-1} & (-n)a = -(na) \\
(ab)^{-1} \text{ / } -(a+b) & b^{-1}a^{-1} & -b + (-a) = -a-b \text{ (comuta, pois é abeliano)}
\end{array}
$$


> [!info] Nota
> Em linguagem aditiva assume-se **sempre** que o grupo é abeliano — por isso, na linha do produto/soma de dois elementos, $-b + (-a) = -a - b$: a ordem já não importa.
 
## Exemplos extra
 
1. Em $\mathbb{Z}_6 = \{0,1,2,3,4,5\}$** (aditivo, mod 6): o simétrico de $2$ é $4$ (pois $2+4=0$); o simétrico de $0$ é $0$. Confere com (ii): $-(-2) = -4 = 2$. ✓
2. Em $GL_2(\mathbb{R})$ (multiplicativo, visto na Aula 3): sejam $A = \begin{pmatrix}1&1\\0&1\end{pmatrix}$, $B=\begin{pmatrix}2&0\\0&1\end{pmatrix}$. Calcula-se $(AB)^{-1}$ diretamente e compara-se com $B^{-1}A^{-1}$ — confirma (iii) num grupo **não abeliano**.
3. Em $S_3$ (grupo simétrico, visto na Aula 3): sejam $\sigma = (1\,2)$, $\tau=(1\,2\,3)$. Como $S_3$ não é abeliano, $(\sigma\tau)^{-1} = \tau^{-1}\sigma^{-1} \neq \sigma^{-1}\tau^{-1}$ em geral — bom exemplo para ver porque a ordem em (iii)/(iv) importa de verdade (não é só decoração).

