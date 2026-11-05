Uma permutação é uma aplicação bijetiva
$$f : A \longrightarrow A$$
de um conjunto $A \neq \emptyset$ nele mesmo.
Denota-se $\mathcal{S}_A$ ao conjunto destas permutações. Em particular, se $A = \{1, 2, \dots, n\}$ então $\mathcal{S}_A$ denota-se por $\mathcal{S}_n$.

**Proposição**. O par $(\mathcal{S}_A, \circ)$ com a operação $\circ$ de composição de aplicação é um grupo, chamado o grupo das permutações de $A$.
Em particular $\mathcal{S}_n$ diz-se o grupo simétrico de grau $n$

**Observações**
1) Se $A$ é um conjunto qualquer de cardinal $n$, então $\mathcal{S}_A \cong \mathcal{S}_n$.
2) Uma permutação $f \in \mathcal{S}_n$ denota-se habitualmente 
$$
f = \begin{pmatrix} 
1 & 2 & \dots & n \\
i_1 & i_2 & \dots & i_n 
\end{pmatrix}
\quad
\text{e}
\quad
f^{-1} = \begin{pmatrix}
i_1 & i_2 & \dots & i_n \\
1 & 2 & \dots & n
\end{pmatrix}
$$
A aplicação $f^{-1}$ é o elemento inverso de $f$ no grupo $\mathcal{S}_n$ pois
$$
f \circ f^{-1} = f^{-1} \circ f = id = 
\begin{pmatrix}
1 & 2 & \dots & n\\
1 & 2 & \dots & n 
\end{pmatrix}
$$
3) Se $f, g \in \mathcal{S}_n$, então 
$$
f = \begin{pmatrix}
1 & 2 & \dots & n\\
i_1 & i_2 & \dots &  i_n
\end{pmatrix}
\quad 
\text{e}
\quad 
g = \begin{pmatrix}
1 & 2 6 \dots & n \\
j_1 & j_2 & \dots & j_n
\end{pmatrix}
$$
logo,
$$
f \circ g = \begin{pmatrix}
1 & 2 & \dots & n \\
i_{j_1} & i_{j_2} & \dots & i_{j_n}
\end{pmatrix}
\quad 
\text{e}
\quad 
g \circ f = \begin{pmatrix}
1 & 2 & \dots & n \\
j_{i_1} & j_{i_2} & \dots & j_{i_n}
\end{pmatrix}
$$

4. $\lvert \mathcal{S}_n \rvert = n!$
Em particular, $\lvert \mathcal{S}_1 \rvert =1$, $\lvert \mathcal{S}_2 \rvert =2$, $\lvert \mathcal{S}_3 \rvert =6$, $\lvert \mathcal{S}_4 \rvert =24$

5. $\mathcal{S}_n \, (n \geq 3)$ não é abeliano. Por exemplo, 
$$
\begin{align}
\sigma &= \begin{pmatrix}
1 & 2 & 3 & 4 & \dots & n \\
2 & 3 & 1 & 4 & \dots & n 
\end{pmatrix}
\quad 
\text{e}
\quad
\gamma = \begin{pmatrix}
1 & 2 & 3 & 4 & \dots & n \\
2 & 1 & 3 & 4 & \dots & n  
\end{pmatrix}\\
\sigma \gamma &= \begin{pmatrix}
1 & 2 & 3 & 4 & \dots & n \\
3 & 2 & 1 & 4 & \dots & n \\ 
\end{pmatrix} 
\neq \gamma \sigma \\
\gamma \sigma &= \begin{pmatrix}
1 & 2 & 3 & 4 & \dots & n \\
1 & 3 & 2 & 4 & \dots & n \\ 
\end{pmatrix} 
\end{align}
$$

**Definição.** Um ciclo de comprimento $k$ é uma permutação $\sigma \in \mathcal{S}_n$ denotada por $\sigma = (i_1, i_2, \dots, i_K)$ tal que $\sigma(i_1) = i_2$, $\sigma(i_2) = i_3, \dots, \sigma(i_k) = 1$ e $\sigma(j) = j$ para todo $j \in I_n$ com $I_n = \{1, 2, \dots, n\}$

**Proposição.** Um ciclo $\sigma$ de comprimento $k$ rem ordem $k$.

**Demonstração.** $\sigma^k = id$ e $k$ é o menor natural em que isto acontece.
Um ciclo de comprimento 2 chama-se uma transcripção.

**Definição.** O suporte de um ciclo $\sigma = (i_1, i_2, \dots, i_k)$ é o conjunto $supp(\sigma)=\{i_1, i_2, \dots, i_k\}$ dos elementos não constantes de $\sigma$

%% TO FIX... %% 

**Proposição.** Toda a permutação $\sigma \in \mathcal{S}_m$ pode ser escrita como produto de ciclos disjuntos

**Exemplo.**
$$
\begin{pmatrix}
1 & 2 & 3 & 4 & 5 & 6 & 7 & 8 & 9 \\
8 & 2 & 5 & 9 & 1 & 4 & 3 & 6 & 7 \\
\end{pmatrix}
= \begin{pmatrix}
1 & 8 & 6 & 4 & 9 & 7 & 3 & 5
\end{pmatrix}
\begin{pmatrix}
2
\end{pmatrix}
$$
