module Exames where

import Data.Char
import Data.List 

{-♅---------------------------------------------------------------------------------------------------------✃---------------------------------------------------------------------------------------------------------♅-}
--Exame 2016/2017

{- 1. Apresente uma definição recursiva das seguintes funções (pré-definidas) sobre listas:

(a) unlines :: [String] -> String que junta todas as strings da lista numa só, separando-as
pelo caracter ’\n’. Por exemplo, unlines ["Prog", "Func" == "Prog\nFunc". -} 

unlines' :: [String] -> String
unlines' [] = ""
unlines' [h] = h
unlines' (h:t) = h ++ "\n" ++ unlines' t

{- (b) (\\) :: (Eq a) => [a] -> [a] -> [a] que retorna a lista resultante de remover (as primeiras
ocorrências) dos elementos da segunda lista da primeira. Por exemplo,
(\\) [1,2,3,4,5,1] [1,5] == [2,3,4,1] e (\\) [1,2,2,3,2,1,4,1] [2,1,2] == [3,2,1,4,1]. -}

(\\\) :: (Eq a) => [a] -> [a] -> [a]
(\\\) [] _ = []
(\\\) l [] = l
(\\\) l (h:t) = (\\\) (delete h l) t 

{- 2. Considere o seguinte tipo de dados para representar uma sequência em que os elementos podem ser
acrescentados à esquerda (Inicio) ou à direita (Fim) da sequência. -}

data Seq a = Nil | Inicio a (Seq a) | Fim (Seq a) a

{- (a) Defina a função primeiro :: Seq a -> a que recebe uma sequência não vazia e devolve o
primeiro elemento. -}

primeiro :: Seq a -> a
primeiro (Inicio a t) = a
primeiro (Fim Nil t) = t 
primeiro (Fim a t) = primeiro a

--(b) Defina a função semUltimo :: Seq a -> Seq a que recebe uma sequência não vazia e devolve a sequência sem o seu último elemento.

semUltimo :: Seq a -> Seq a
semUltimo (Inicio a Nil) = Nil
semUltimo (Inicio a t) = Inicio a (semUltimo t)
semUltimo (Fim a t) = a

--3. Considere o seguinte tipo para representar árvores binárias.

data BTree a = Empty | Node a (BTree a) (BTree a)

{- (a) Defina uma função prune :: Int -> BTree a -> BTree a, que remove de uma árvore todos
os elementos a partir de uma determinada profundidade. -}

prune :: Int -> BTree a -> BTree a
prune x Empty = Empty
prune 0 _ = Empty
prune x (Node r ae ad) = Node r (prune (x-1) ae) (prune (x-1) ad)

{- (b) Defina uma função semMinimo :: (Ord a) => BTree a -> BTree a que remove o menor
elemento de uma árvore binária de procura não vazia. -}

semMinimo :: (Ord a) => BTree a -> BTree a
semMinimo Empty = Empty
semMinimo (Node r Empty ad) = ad
semMinimo (Node r ae ad) = Node r (semMinimo ae) (ad)

{- 4. O problema das N rainhas consiste em colocar N rainhas num tabuleiro de xadrez com N linhas e N colunas, de tal forma que
nenhuma rainha está amea¸cada por outra. Note que uma rainha amea¸ca todas as posições que estão na mesma linha, na mesma
coluna ou nas mesmas diagonais. Uma forma de representar estas soluções é usando listas de strings. O exemplo representa uma solução 
para este problema quando N é 4. -}

type Tabuleiro = [String]

{- exemplo :: Tabuleiro
   exemplo = ["..R.",
              "R...",
		      "...R",
		      ".R.."] -}

{- (a) Defina a função posicoes :: Tabuleiro -> [(Int,Int)] que determina as posições (coluna e linha) onde se encontram as rainhas num 
tabuleiro, de tal forma que posicoes exemplo == [(2,0),(0,1),(3,2),(1,3)]. -}

posicoes :: Tabuleiro -> [(Int,Int)]
posicoes l = foldl (\acc y -> acc ++ (foldl (\acc2 x -> if (l !! y) !! x == 'R' then acc2 ++ [(x,y)] else acc2)) [] [0..(length (head l) - 1)]) [] [0..(length l - 1)]

{- Nota:

(!!) :: [a] -> Int -> a

List index (subscript) operator, starting from 0. It is an instance of the more general genericIndex, which takes an index of any integral type.

Let us assume that you need help reading this. The first line tell us that (!!) is a function that takes a list of things ([a]) and an Int then gives you 
back one of the thing in the list (a). The descriptions tells you what it does. It will give you the element of the list indexed by the Int. 
So, xs !! i works like xs[i] would in Java, C or Ruby.-}

{- (b) Usando a função anterior, defina a função valido :: Tabuleiro -> Bool que testa se num tabuleiro nenhuma rainha ataca outra. No caso do 
tabuleiro exemplo a resposta deve ser True. Note que pode testar se duas rainhas estão na mesma diagonal vendo se a soma ou a diferença
entre a linha e a coluna em que estão colocadas são iguais. -}

valido :: Tabuleiro -> Bool
valido l = foldl (\acc (x,y) -> if length (filter (\(a,b) -> (a,b) /= (x,y) && (a == x || b == y || a - b == x - y || b - a == y - x)) (posicoes l)) > 0 then False else acc) True (posicoes l)

{- (c) Utilizando funções de ordem superior, defina a função bemFormado :: Int -> Tabuleiro -> Bool que dado um tamanho n e um tabuleiro t 
testa se este é bem formado, isto é, tem n linhas, n colunas, n rainhas, e os restantes caracteres do tabuleiro são o ’.’ . -}

bemFormado ::  Int -> Tabuleiro -> Bool
bemFormado n tab = length tab == n && foldr (\x -> (&&) $ (==) n $ length x) True tab && foldl (\acc (x,y) -> if (tab !! y) !! x == 'R' then acc + 1 else acc) 0 [(a,b) | a <- [0..n - 1], b <- [0..n - 1]] == n

{-♅----------------------------------------------------------------------------------------------------------✃---------------------------------------------------------------------------------------------------------♅-}
--Exame 2017/2018

{- 1. Apresente uma definição recursiva da função (pré-definida) (!!) :: [a] -> Int -> a que dada uma lista e um inteiro, calcula o elemento da 
lista que se encontra nessa posição (assume-se que o primeiro elemento se encontra na posição 0). Por exemplo, (!!) [10,20,30] 1 corresponde a 20.
Ignore os casos em que a função não se encontra definida (i.e., em que a posição fornecida não corresponde a nenhuma posição válida da lista). -}

(!!!) :: [a] -> Int -> a
(!!!) (h:t) 0 = h
(!!!) (h:t) x = (!!!) t (x-1)

--2. Considere o seguinte tipo para representar movimentos de um robot.

data Movimento = Norte | Sul | Este | Oeste deriving Show

{- Defina a função posicao :: (Int,Int) -> [Movimento] -> (Int,Int) que, dada uma posição inicial (abcissa e ordenada) e uma lista de movimentos 
(um movimento para Norte aumenta a ordenada e para Este aumenta a abcissa), calcula a posição final do robot depois de efectuar essa
sequência de movimentos. -}

posicao :: (Int,Int) -> [Movimento] -> (Int,Int)
posicao i [] = i
posicao (x,y) (m:ms) = posicao (case m of Norte -> (x,y+1)
                                          Sul -> (x,y-1)
                                          Este -> (x+1,y)
                                          Oeste -> (x-1,y)) ms 

{- 3. Apresente uma definição recursiva da função any :: (a -> Bool) -> [a] -> Bool que testa se um predicado é verdade para algum elemento 
de uma lista. Por exemplo, any odd [1..10] == True. -}

any' :: (a -> Bool) -> [a] -> Bool
any' f [] = False
any' f (h:t) = f h || any' f t

{- 4. Considere o sequinte tipo type Mat a = [[a]] para representar matrizes. Defina a função triSup :: Num a => Mat a -> Bool que testa se uma
matriz quadrada é triangular superior (i.e., todos  os elementos abaixo da diagonal são nulos). Esta função deve devolver True para a matriz
[[1,2,3], [0,4,5], [0,0,6]]. -}

type Mat a = [[a]]

triSup :: (Num a,Eq a) => Mat a -> Bool
triSup [] = True
triSup (h:t) = let l = map head t
                   rm = map tail t
               in all (==0) l && triSup rm

{- 5. Defina um programa movimenta :: IO (Int,Int) que lê uma sequência de comandos do teclado (’N’ para Norte, ’S’ para Sul, ’E’ para Este, ’O’ 
para Oeste e qualquer outro caracter para parar) e devolve a posição final do robot (assumindo que a posição inicial é (0,0)). -}

movimenta :: IO (Int,Int)
movimenta = moveFrom (0,0)

moveFrom :: (Int,Int) -> IO (Int,Int)
moveFrom (x,y) = do
    dir <- getChar
    case dir of 'n' -> moveFrom (x,y+1)
                's' -> moveFrom (x,y-1)
                'e' -> moveFrom (x+1,y)
                'o' -> moveFrom (x-1,y)
                otherwise -> return (x,y) 

{- 6. Considere o tipo Imagem para representar imagens compostas por quadrados (apenas com coordenadas positivas).
Ao lado apresenta-se um exemplo de uma destas imagens constituída por três quadrados (cujos
lados têm dimensão 5, 4 e 2). -}

data Imagem = Quadrado Int | Mover (Int,Int) Imagem | Juntar [Imagem]

{- ex :: Imagem
   ex = Mover (5,5) (Juntar [Mover (0,1) (Quadrado 5), Quadrado 4, Mover (4,3) (Quadrado 2)])

(a) Defina a função vazia :: Imagem -> Bool que testa se uma imagem não tem nenhum quadrado. A função devolve False para o exemplo acima. -}

vazia :: Imagem -> Bool
vazia (Quadrado x) = False
vazia (Mover (num1,num2) t) = vazia t
vazia (Juntar []) = True
vazia (Juntar l) = all vazia l

{- (b) Defina a função maior :: Imagem -> Maybe Int que calcula a largura do maior quadrado de uma imagem. No exemplo acima, maior ex == Just 5. 
Note que a imagem pode não ter quadrados. -}

maior :: Imagem -> Maybe Int
maior l | vazia l = Nothing
        | otherwise = Just (maximum (quads l))
                      where quads :: Imagem -> [Int]
                            quads (Quadrado x) = [x]
                            quads (Mover _ l) = quads l
                            quads (Juntar l) = concat (map quads l)

{- (c) Defina Imagem como uma instância de Eq de forma a que duas imagens são iguais sse forem compostas pelos mesmos quadrados nas mesmas posições.
Por exemplo, a imagem ex acima deverá ser igual a Juntar [Mover (5,5) (Quadrado 4), Mover (5,6) (Quadrado 5), Mover (9,8) (Quadrado 2)]. -}

instance Eq Imagem where
    x == y = let a = posicoesI (0,0) x
                 b = posicoesI (0,0) y
             in (all (pertence a) b)

posicoesI :: (Int,Int) -> Imagem -> [Imagem]
posicoesI (x,y) (Quadrado a) = [(Mover (x,y) (Quadrado x))]
posicoesI (x,y) (Mover (a,b) l) = posicoesI (x+a,y+b) l
posicoesI (x,y) (Juntar l) = concat (map (posicoesI (x,y)) l)

pertence :: [Imagem] -> Imagem -> Bool
pertence [] _ = False
pertence ((Mover (x1,y1) (Quadrado d1)):t) (Mover (x2,y2) (Quadrado d2)) | x1==x2 && y1==y2 = d1 == d2
                                                                         | otherwise = pertence t (Mover (x2,y2) (Quadrado d2))

{-♅----------------------------------------------------------------------------------------------------------✃---------------------------------------------------------------------------------------------------------♅-}
--Exame 2018/2019

{- 1. Apresente uma definição recursiva das seguintes funções sobre listas:

(a) isSorted :: (Ord a) => [a] -> Bool que testa se uma lista está ordenada por ordem crescente. -}

isSorted' :: (Ord a) => [a] -> Bool
isSorted' [] = True
isSorted' [x] = True
isSorted' (h1:h2:t) = if h1 < h2 then isSorted' (h2:t) else False

{- (b) inits :: [a] -> [[a]] que calcula a lista dos prefixos de uma lista. Por exemplo, inits [11,21,13]
corresponde a [[],[11],[11,21],[11,21,13]]. -}

inits' :: [a] -> [[a]]
inits' [] = [[]]
inits' l = inits'(init l) ++ [l]

{- 2. Defina maximumMB :: (Ord a) => [Maybe a] -> Maybe a que dá o maior elemento de uma lista de
elementos do tipo Maybe a. Considere Nothing o menor dos elementos. -}

maximumMB :: (Ord a) => [Maybe a] -> Maybe a
maximumMB [Just x] = Just x
maximumMB ((Nothing):t) = maximumMB t
maximumMB (a:(Nothing):t) = maximumMB (a:t)
maximumMB ((Just x):(Just y):t) | x >= y = maximumMB ((Just x):t)
                                | otherwise = maximumMB((Just y):t)
maximumMB _ = Nothing 

--3. Considere o seguinte tipo para representar árvores em que a informação está nas extermidades:

data LTree a = Tip a | Fork (LTree a) (LTree a)

{- (a) Defina a função listaLT :: LTree a -> [a] que dá a lista das folhas de uma árvore (da esquerda
para a direita). -}

listaLT :: LTree a -> [a]
listaLT (Tip x) = [x]
listaLT (Fork ae ad) = (listaLT ae) ++ (listaLT ad)

{- (b) Defina uma instância da classe Show para este tipo que apresente uma folha por cada linha, precedida de tantos
pontos quanta a sua profundidade na árvore. Veja o exemplo.

> Fork (Fork (Tip 7) (Tip 1)) (Tip 2)
..7
..1
.2
 -}

instance Show a => Show (LTree a) where
    show (Tip x) = show x
    show x = show' x 0
             where show' (Tip a) c = replicate c '.' ++ show a
                   show' (Fork ae ad) c = show' ae (c+1) ++ '\n':show' ad (c+1)


{- 4. Utilizando uma função auxiliar com acumuladores, optimize a seguinte definição que determina a soma
do segmento inicial de uma lista com soma máxima.  -}

maxSumInit' :: (Num a, Ord a) => [a] -> a
maxSumInit' l = maximum [sum m | m <- inits l]

maxSumInit'' :: (Num a, Ord a) => [a] -> a
maxSumInit'' l = foldl (\ acc x -> max(sum x) acc) (sum l) (inits l)


{- 5. Uma relação binária entre elementos de um tipo a pode ser descrita como um conjunto (lista) de pares
[(a,a)]. Outras formas alternativas consistem em armazenar estes pares agrupados de acordo com a sua
primeira componente. Considere os seguintes três tipos para estas representações. -}

type RelP a = [(a,a)]
type RelL a = [(a,[a])]
type RelF a = ([a], a->[a])

{- Por exemplo, a relação representada na figura ao lado pode ser implementada por:

• [(1,3),(1,4),(2,1),(2,4),(2,5),(3,7),(4,7),(5,7),(6,5),(7,6)] :: RelP Int
• [(1,[3,4]),(2,[1,4,5]),(3,[7]),(4,[7]),(5,[7]),(6,[5]),(7,[6])] :: RelL Int
• ([1,2,3,4,5,6,7],f) :: RelF Int, em que f é uma função tal que
f 1 = [3,4], f 2 = [1,4,5], f 3 = [7], f 4 = [7], f 5 = [7], f 6 = [5], e f 7 = [6].

(a) Considere a seguinte função de conversão entre representações: -}

convLP :: RelL a -> RelP a
convLP l = concat (map junta l)
           where junta (x,xs) = map (\y->(x,y)) xs

{- Defina a função de conversão convPL :: (Eq a) => RelP a -> RelL a, inversa da anterior. Isto
é, tal que convPL (convLP r) = r, para todo o r. -}

convPL :: (Eq a) => RelP a -> RelL a
convPL [(x,y)] = [(x,[y])]
convPL (h:t) = junta h (convPL t)
               where junta (a,b) l = if a `elem` map (fst) l then map (\(c,d) -> if c == a then (c,b:d) else (c,d)) l else (a,[b]):l

--ou

convPL' :: (Eq a,Ord a) => RelP a -> RelL a
convPL' l = let a = sortOn fst l
                b = groupBy (\(x,_) (y,_) -> x == y) a
                k = map junta b
                junta :: [(a,a)] -> (a,[a])
                junta x = (fst (head x),(map snd x))
            in k

--(b) Defina a função criaRelPint :: Int -> IO (RelP Int), tal que criaRelPint n permite ao utilizador criar (interactivamente) uma relação de inteiros com n pares.

{- (c) Defina as funções de conversão entre as representações RelF a e RelP a,
i. convFP :: (Eq a) => RelF a -> RelP a
ii. convPF :: (Eq a) => RelP a -> RelF a
tal que convFP (convPF r) = r, para todo o r. -}

convFP :: (Eq a) => RelF a -> RelP a
convFP (l,f) = convLP $ map (\x -> (x,f x)) l


convPF :: (Eq a) => RelP a -> RelF a
convPF x = ((map fst y),f)
           where y = convPL x
                 f a = foldl (\acc (b,c) -> if a == b then c else acc) [] y

{-♅----------------------------------------------------------------------------------------------------------✃---------------------------------------------------------------------------------------------------------♅-}