module Ficha5 where

import Data.Char
import Data.List

{- 1. Apresente definições das seguintes funções de ordem superior, já pré-definidas no Prelude
ou no Data.List: -}

{- (a) any :: (a -> Bool) -> [a] -> Bool que teste se um predicado é verdade para
algum elemento de uma lista; por exemplo:
any odd [1..10] == True -}

any' :: (a -> Bool) -> [a] -> Bool
any' f [] = False
any' f (x:xs) = f x || any' f xs

{- (b) zipWith :: (a->b->c) -> [a] -> [b] -> [c] que combina os elementos de
duas listas usando uma função específica; por exemplo:
zipWith (+) [1,2,3,4,5] [10,20,30,40] == [11,22,33,44]. -}

zipWith' :: (a->b->c) -> [a] -> [b] -> [c]
zipWith' f (x:xs) (y:ys) = x `f` y : zipWith' f xs ys
zipWith' f _ _ = []

{- (c) takeWhile :: (a->Bool) -> [a] -> [a] que determina os primeiros elementos
da lista que satisfazem um dado predicado; por exemplo:
takeWhile odd [1,3,4,5,6,6] == [1,3]. -}

takeWhile1 :: (a -> Bool) -> [a] -> [a]
takeWhile1 f [] = []
takeWhile1 f (h:t) = if f h then h : takeWhile1 f t 
                    else takeWhile1 f t

{- (d) dropWhile :: (a->Bool) -> [a] -> [a] que elimina os primeiros elementos da
lista que satisfazem um dado predicado; por exemplo:
dropWhile odd [1,3,4,5,6,6] == [4,5,6,6]. -}

dropWhile' :: (a->Bool) -> [a] -> [a]
dropWhile' f [] = []
dropWhile' f (x:xs) = if f x then dropWhile' f xs else (x:xs)

{- (e) span :: (a-> Bool) -> [a] -> ([a],[a]), que calcula simultaneamente os dois
resultados anteriores. Note que apesar de poder ser definida à custa das outras
duas, usando a definição span p l = (takeWhile p l, dropWhile p l)
nessa definição há trabalho redundante que pode ser evitado. Apresente uma
definição alternativa onde não haja duplicação de trabalho. -}

span' :: (a-> Bool) -> [a] -> ([a],[a])
span' f [] = ([],[])
span' f (x:xs) | f x = (x:a,b)
               | otherwise = ([],(x:xs))
               where (a,b) = span' f xs

{- (f) deleteBy :: (a -> a -> Bool) -> a -> [a] -> [a] que apaga o primeiro elemento de uma lista que é “igual” a um dado elemento de acordo com a função
de comparação que é passada como parâmetro. Por exemplo:
deleteBy (\x y -> snd x == snd y) (1,2) [(3,3),(2,2),(4,2)] -}

deleteBy' :: (a -> a -> Bool) -> a -> [a] -> [a]
deleteBy' f _ [] = []
deleteBy' f n (x:xs) = if f n x then xs else x:deleteBy' f n xs

{- (g) sortOn :: Ord b => (a -> b) -> [a] -> [a] que ordena uma lista comparando os resultados de aplicar uma função de extracção de uma chave a cada elemento de uma lista. Por exemplo:
sortOn fst [(3,1),(1,2),(2,5)] == [(1,2),(2,5),(3,1)]. -}

sortOn' :: Ord b => (a -> b) -> [a] -> [a]
sortOn' f [] = []
sortOn' f (h:t) = aux f h (sortOn' f t)
                  where aux :: Ord b => (a -> b) -> a -> [a] -> [a]
                        aux f x [] = [x]
                        aux f x (a:b) = if f x > f a then a : aux f x b else x : a : b

{- 2. Relembre a questão sobre polinómios introduzida na Ficha 3, onde um polinómio era
representado por uma lista de monómios representados por pares (coeficiente, expoente): -}

type Polinomio = [Monomio]
type Monomio = (Float,Int)

{- Por exemplo, [(2,3), (3,4), (5,3), (4,5)] representa o polinómio 
2 x^3 + 3 x^4 + 5 x^3 + 4 x^5.

Redefina as funções pedidas nessa ficha, usando agora funções de ordem
superior (definidas no Prelude ou no Data.List) em vez de recursividade explícita:

(a) selgrau :: Int -> Polinomio -> Polinomio que selecciona os monómios com
um dado grau de um polinómio. -}

selgrau :: Int -> Polinomio -> Polinomio
selgrau n pol = filter (\x -> n == snd (x)) pol 

--(b) conta :: Int -> Polinomio -> Int de forma a que (conta n p) indica quantos monómios de grau n existem em p.

conta :: Int -> Polinomio -> Int
conta n pol = foldr (\ x conta -> if n == snd(x) then conta+1 else conta) 0 pol

conta' :: Int -> Polinomio -> Int
conta' n p = length (filter (\x -> n == snd x) p)
-- equivalente a conta' n p = length  $ filter (\x -> n == snd x) p

--(c) grau :: Polinomio -> Int que indica o grau de um polinómio.

grau :: Polinomio -> Int
grau pol = foldr  (\x g-> if snd x > g then snd (x) else g) 0 pol

--(d) deriv :: Polinomio -> Polinomio que calcula a derivada de um polinómio.

deriv :: Polinomio -> Polinomio
deriv pol = let l = map (\(c,g) -> if g > 0 then (c*fromIntegral(g),g-1) else (0,0)) pol
            in filter(/=(0,0)) l

{- (e) calcula :: Float -> Polinomio -> Float que calcula o valor de um polinómio
para uma dado valor de x. -}

calcula :: Float -> Polinomio -> Float
calcula x pol = foldr (\(c,g) soma -> c*(x^g) + soma) 0 pol 

{- (f) simp :: Polinomio -> Polinomio que retira de um polinómio os monómios de
coeficiente zero. -}

simp :: Polinomio -> Polinomio
simp pol = filter(\x -> fst(x) /= 0 ) pol

--(g) mult :: Monomio -> Polinomio -> Polinomio que calcula o resultado da multiplicação de um monómio por um polinómio.

mult :: Monomio -> Polinomio -> Polinomio
mult (cm,gm) pol = map(\x -> (fst(x)*cm, snd(x)*gm)) pol

--Nota: https://stackoverflow.com/questions/7872852/map-filter-foldr-in-drracket-scheme

--(h) ordena :: Polinomio -> Polinomio que ordena um polonómio por ordem crescente dos graus dos seus monómios.

ordena :: Polinomio -> Polinomio
ordena pol = foldr aux [] pol
             where aux :: Monomio -> Polinomio -> Polinomio
                   aux (cm,gm) [] = [(cm,gm)]
                   aux (cm,gm) ((cm2,gm2):t) = if gm < gm2 then (cm,gm): (cm2,gm2): t else (cm2,gm2): aux (cm,gm) t

ordena' :: Polinomio -> Polinomio
ordena' pol = sortOn snd pol

{- (i) normaliza :: Polinomio -> Polinomio que dado um polinómio constrói um
polinómio equivalente em que não podem aparecer varios monómios com o mesmo
grau. -}

normaliza :: Polinomio -> Polinomio
normaliza l = let x = fromIntegral $ grau l in [ ((a/x),b) | (a,b) <- l]

{- (j) soma :: Polinomio -> Polinomio -> Polinomio que faz a soma de dois polinómios
de forma que se os polinómios que recebe estiverem normalizados produz também
um polinómio normalizado. -}

soma :: Polinomio -> Polinomio -> Polinomio
soma pol1 pol2 = normaliza $ (++) pol1 pol2
--soma pol1 pol2 = normaliza ( (++) pol1 pol2)

{- (k) produto :: Polinomio -> Polinomio -> Polinomio que calcula o produto de
dois polinómios. -}

produto :: Polinomio -> Polinomio -> Polinomio
produto pol1 pol2 = foldr mult pol1 pol2

{- (l) equiv :: Polinomio -> Polinomio -> Bool que testa se dois polinómios são
equivalentes. -}

equiv :: Polinomio -> Polinomio -> Bool
equiv pol1 pol2 =  ordena(normaliza  pol1) == ordena(normaliza pol2)

--3. Considere a sequinte definição para representar matrizes:

type Mat a = [[a]]

{- Por exemplo, a matriz (triangular superior)

|1 2 3|
|0 4 5|
|0 0 6|

seria representada por [[1,2,3], [0,4,5], [0,0,6]]

Defina as seguintes funções sobre matrizes (use, sempre que achar apropriado, funções
de ordem superior).

 (a) dimOK :: Mat a -> Bool que testa se uma matriz está bem construída (i.e., se
todas as linhas têm a mesma dimensão). -}

dimOK :: Mat a -> Bool
dimOK (l:rm) = all (\l1 -> length l == length l1) rm

--all: returns True if all items in the list fulfill the condition

--(b) dimMat :: Mat a -> (Int,Int) que calcula a dimensão de uma matriz.

dimMat :: Mat a -> (Int,Int)
dimMat (l:rm)= (length l, length (l:rm))

--(c) addMat :: Num a => Mat a -> Mat a -> Mat a que adiciona duas matrizes.

addMat :: Num a => Mat a -> Mat a -> Mat a
addMat m1 m2 = zipWith (\l1 l2 -> zipWith (+) l1 l2) m1 m2

--(d) transpose :: Mat a -> Mat a que calcula a transposta de uma matriz.

transpose' :: Mat a -> Mat a
transpose' ([]:_) = []
transpose' m = let l = map head m
                   rm = map tail m
              in l: transpose' rm

{- (e) multMat :: Num a => Mat a -> Mat a -> Mat a que calcula o produto de duas
matrizes. -}

multMat :: Num a => Mat a -> Mat a -> Mat a
multMat m1 m2 = zipWith (\l1 l2 -> zipWith (*) l1 l2) m1 m2

{- (f) zipWMat :: (a -> b -> c) -> Mat a -> Mat b -> Mat c que, à semelhança
do que acontece com a função zipWith, combina duas matrizes. Use essa função
para definir uma função que adiciona duas matrizes. -}

zipWMat :: (a -> b -> c) -> Mat a -> Mat b -> Mat c
zipWMat f m1 m2 = zipWith (\l1 l2 -> zipWith f l1 l2) m1 m2

--(g) triSup :: Num a => Mat a -> Bool que testa se uma matriz quadrada é triangular superior (i.e., todos os elementos abaixo da diagonal são nulos).

triSup :: (Num a,Eq a) => Mat a -> Bool
triSup [] = True
triSup (h:t) = let l = map head t
                   rm = map tail t
               in all (==0) l && triSup rm

{- (h) rotateLeft :: Mat a -> Mat a que roda uma matriz 90º para a esquerda. Por
exemplo, o resultado de rodar a matriz acima apresentada deve corresponder à
matriz

|3 5 6|
|2 4 0|
|1 0 0|
 -}

rotateLeft :: Mat a -> Mat a
rotateLeft ([]:_) = [[]]
rotateLeft m = let l = map last m
                   rm = map init m
               in l: rotateLeft rm
