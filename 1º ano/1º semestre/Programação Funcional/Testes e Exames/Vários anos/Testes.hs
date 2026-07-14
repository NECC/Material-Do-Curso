module Testes where

import Data.Char
import Data.List
import Data.Maybe


{-♅-----------------------------------------------------------------------✃----------------------------------------------------------------------♅-}
--Teste 2016/2017

--1. Considere o tipo MSet a para representar multi-conjuntos de tipo a

type MSet a = [(a,Int)]

{- Considere ainda que nestas listas não há pares cuja primeira componente coincida, nem cuja segunda
componente seja menor ou igual a zero. Para além disso, os multi-conjuntos estão organizados
por ordem decrescente da muiltplicidade. O multi-conjunto {’b’,’a’,’c’,’b’,’b’,’a’,’b’} é
representado pela lista [(’b’,4),(’a’,2),(’c’,1)], por exemplo. -}

{-(a) Defina a função cardMSet :: MSet a -> Int que calcula a cardinalidade de um multiconjunto. 
Por exemplo, cardMSet [(’b’,4),(’a’,2),(’c’,1)] devolve 7. -}

cardMSet :: MSet a -> Int
cardMSet [] = 0
cardMSet ((x,num):t) = num + cardMSet t
-- cardMset  = foldr( (+) . snd) 0

{- (b) Defina a função moda :: MSet a -> [a] que devolve a lista dos elementos com maior número
de ocorrências. -}

moda :: MSet a -> [a]
moda = fst .  foldr (\(a,num) (acc,maior) -> if num >= maior then (if num > maior then [a] else a : acc ,num) else (acc,maior) ) ([],0)

{- (c) Defina a função converteMSet :: MSet a -> [a] que converte um multi-conjunto numa
lista. Por exemplo, converteMSet [(’b’,4),(’a’,2),(’c’,1)] devolve ‘‘bbbbaac’’. -}

converteMSet :: MSet a -> [a]
converteMSet [] = []
converteMSet ((x,num):t) = replicate num x ++ converteMSet t
 
{- (d) Defina a função addNcopies :: Eq a => MSet a -> a -> Int -> MSet a que faz a inserção
de um dado número de ocorrências de um elemento no multi-conjunto, mantendo a ordenação
por ordem decrescente da multiplicidade. Não use uma função de ordenação. -}

addNcopies :: Eq a => MSet a -> a -> Int -> MSet a
addNcopies [] x y = [(x,y)]
addNcopies ((h,num):t) x y | h == x = insere (h,num+y) t
                           | otherwise = insere (x,y) (addNcopies t x y)

insere :: Eq a => (a,Int) -> MSet a -> MSet a
insere (h,num) [] = [(h,num)]
insere (h,num) ((x,y):t) | num <= y = (x,y) : insere (h,num) t
                         | otherwise = (h,num) : (x,y) : t

--2. Considere o seguinte tipo de dados para representar subconjuntos de números reais (Doubles).

data SReais = AA Double Double | FF Double Double | AF Double Double | FA Double Double | Uniao SReais SReais

{- (AA x y) representa o intervalo aberto ]x, y[, (FF x y) representa o intervalo fechado [x, y], (AF x
y) representa ]x, y], (FA x y) representa [x, y[ e (Uniao a b) a união de conjuntos. -}

{- (a) Defina a SReais como instância da classe Show, de forma a que, por exemplo, a apresentação
do termo Uniao (Uniao (AA 4.2 5.5) (AF 3.1 7.0)) (FF (-12.3) 30.0) seja
((]4.2,5.5[ U ]3.1,7.0]) U [-12.3,30.0]) -}

instance Show SReais where
         show (AA x y) = "]"++ show x ++ " , " ++ show y ++ "["
         show (FF x y) = "["++ show x ++ " , " ++ show y ++ "]"
         show (AF x y) = "]"++ show x ++ " , " ++ show y ++ "]"
         show (FA x y) = "["++ show x ++ " , " ++ show y ++ "["
         show (Uniao x y) = "(" ++ show x ++ " U " ++ show y ++ ")"

{- (b) Defina a função pertence :: Double-> SReais -> Bool que testa se um elemento pertence
a um conjunto. -}

pertence :: Double-> SReais -> Bool
pertence x (AA a b) = x > a && x < b
pertence x (FF a b) = x >= a && x >= b
pertence x (AF a b) = x > a && x <= b
pertence x (FA a b) = x >= a && x < b
pertence x (Uniao a b) = pertence x a && pertence x b

--(c) Defina a função tira :: Double -> SReais -> SReais que retira um elemento de um conjunto.

tira :: Double -> SReais -> SReais
tira x (Uniao a b) = Uniao (tira x a) (tira x b)
tira x real@(AA a b) | pertence x real = Uniao (AA a x) (AA x b)
                     | otherwise = real
tira x real@(FF a b) | pertence x real = Uniao (FA a x) (AF x b)
                     | otherwise = real
tira x real@(AF a b) | pertence x real = Uniao (AA a x) (AF x b)
                     | otherwise = real
tira x real@(FA a b) | pertence x real = Uniao (FA a x) (AA x b)
                     | otherwise = real

--3. Considere o seguinte tipo para representar árvores irregulares (rose trees).

data RTree a = R a [RTree a]

{- (a) Defina a função percorre :: [Int] -> RTree a -> Maybe [a] que recebe um caminho e
uma árvore e dá a lista de valores por onde esse caminho passa. Se o caminho não for válido
a função deve retornar Nothing. O caminho é representado por uma lista de inteiros (1 indica
seguir pela primeira sub-árvore, 2 pela segunda, etc). -} 

percorre :: [Int] -> RTree a -> Maybe [a]
percorre [] (R a _) = Just [a]
percorre _  (R a []) = Nothing
percorre (x:xs)  (R a l) = Just (a:b)
                           where b = aux (percorre xs (l!!(x-1)))
                                 aux Nothing = []
                                 aux (Just y) = y 

{-♅-----------------------------------------------------------------------✃----------------------------------------------------------------------♅-}
--Teste 2017/2018

{-1. Apresente uma definição recursiva da função (pré-definida) insert :: Ord a => a -> [a] -> [a] 
que dado um elemento e uma lista ordenada retorna a lista resultante de inserir ordenadamente esse elemento na lista.-}

insert' :: Ord a => a -> [a] -> [a]
insert' x [] = [x]
insert' x (h:t) = if x < h then x:h:t else h:insert' x t

{-2. Apresente uma definição recursiva da função pré-definida catMaybes :: [Maybe a] -> [a]
que colecciona os elementos do tipo a de uma lista. -}

catMaybes' :: [Maybe a] -> [a]
catMaybes' [] = []
catMaybes' (h:t) = case h of Nothing -> catMaybes' t
                             Just x -> x : catMaybes' t

{-3. Considere o tipo ao lado para representar expressões aritméticas com variáveis. Defina Exp a como 
instância da classe Show, de forma a que show (Mais (Var "x") (Mult (Const 3) (Const 4))) seja 
a string "(x + (3 * 4))". -}

data Exp a = Const a | Var String | Mais (Exp a) (Exp a) | Mult (Exp a) (Exp a)

instance Show a => Show (Exp a) where
         show (Const a) = show a
         show (Var a) = show a
         show (Mais a b) = "(" ++ show a ++" + "++ show b ++ ")"
         show (Mult a b) = "(" ++ show a ++" x "++ show b ++ ")" 

{- 4. Apresente uma definição da função sortOn :: Ord b => (a -> b) -> [a] -> [a] que ordena
uma lista comparando os resultados de aplicar uma função de extração de uma chave a cada elemento de uma lista. 
Por exemplo: sortOn fst [(3,1),(1,2),(2,5)] == [(1,2),(2,5),(3,1)]. -}

sortOn' :: Ord b => (a -> b) -> [a] -> [a]
sortOn' f [] = []
sortOn' f (h:t) = aux f h (sortOn' f t)
                  where aux :: Ord b => (a -> b) -> a -> [a] -> [a] 
                        aux f x [] = [x]
                        aux f x (y:ys) = if f x > f y then y : aux f x ys else x : y : ys

{- 5. A amplitude de uma lista de inteiros define-se como a diferença entre o maior e o menor dos elementos
da lista (a amplitude de uma lista vazia é 0).

(a) Defina a função amplitude :: [Int] -> Int que calcula a amplitude de uma lista (idealmente numa única passagem pela lista). -}

amplitude :: [Int] -> Int
amplitude [] = 0
amplitude l = maior - menor
              where (maior,menor) = foldl (\(a,b) v -> (if v > a then v else a, if v < b then v else b)) (head l, head l) l 

{- (b) Defina a função parte :: [Int] -> ([Int],[Int]) que parte uma lista de inteiros em duas, minimizando a soma das amplitudes. 
Por exemplo, parte [1,18,3,19,17,20] deve colocar 1 e 3 numa das listas e os restantes na outra. Admita, caso necessite, que existe 
pré-definida uma função sort :: Ord a => [a] -> [a] de ordenação de listas. -}

parte :: [Int] -> ([Int],[Int])
parte [] = ([],[])
parte l = let ordenada = sort l
              metade = div (last ordenada - head ordenada) 2
              metInf = filter(\z ->last ordenada - z <= metade ) ordenada
              metSup = filter(\z ->last ordenada - z > metade) ordenada
          in (metInf,metSup)

--6. Considere o seguinte tipo para representar imagens compostas por quadrados (apenas com coordenadas positivas)

data Imagem = Quadrado Int | Mover (Int,Int) Imagem | Juntar [Imagem]

{- Por exemplo, a seguinte imagem é constituída por três quadrados.

ex :: Imagem
ex = Mover (5,5) (Juntar [Mover (0,1) (Quadrado 5), Quadrado 4, Mover (4,3) (Quadrado 2)])

(a) Defina a função conta :: Imagem -> Int que conta quantos quadrados tem uma imagem. -}

conta :: Imagem -> Int
conta (Quadrado a) = 1
conta (Mover (_,_) a) = conta a
conta (Juntar l) = sum (map conta l)

{-♅-----------------------------------------------------------------------✃----------------------------------------------------------------------♅-}
--Teste 2018/2019

--1. Apresente uma definição recursiva da função (pré-definida) 

--(a) elemIndices :: Eq a => a -> [a] -> [Int] que calcula a lista de posições em que um dado elemento ocorre numa lista.

elemIndices' :: Eq a => a -> [a] -> [Int]
elemIndices' x [] = []
elemIndices' x l = aux 0 x l
                   where aux i v [] = []
                         aux i v (h:t) = if v == h then (i) : aux (i+1) v t else aux (i+1) v t

--(b) isSubsequenceOf :: Eq a => [a] -> [a] -> Bool que testa se os elementos de uma lista ocorrem noutra pela mesma ordem relativa.

isSubsequenceOf' :: Eq a => [a] -> [a] -> Bool
isSubsequenceOf' l [] = False
isSubsequenceOf' [] l = True
isSubsequenceOf' (x:xs) (y:ys) = if x == y then isSubsequenceOf' xs ys else isSubsequenceOf' (x:xs) ys

--2. Considere o seguinte tipo para representar árvores binárias.

data BTree a = Empty | Node a (BTree a) (BTree a)

{- (a) Defina a funçãoo lookupAP :: Ord a => a -> BTree (a,b) -> Maybe b que generaliza função
lookup para árvores binárias de procura. -}

lookupAP :: Ord a => a -> BTree (a,b) -> Maybe b
lookupAP x Empty = Nothing
lookupAP x (Node (r,b) ae ad) | x > r = lookupAP x ad 
                              | x < r = lookupAP x ae
                              | otherwise = Just b

{- (b) Defina a função zipWithBT :: (a -> b -> c) -> BTree a -> BTree b -> BTree c que generaliza a função zipWith para árvores binárias.-}

zipWithBT :: (a -> b -> c) -> BTree a -> BTree b -> BTree c
zipWithBT _ Empty _ = Empty
zipWithBT _ _ Empty = Empty
zipWithBT f (Node r1 ae1 ad1) (Node r2 ae2 ad2) = Node (f r1 r2) (zipWithBT f ae1 ae2) (zipWithBT f ad1 ad2)

{- 3. Defina a função digitAlpha :: String -> (String,String), que dada uma string, devolve um par de
strings: uma apenas com os números presentes nessa string, e a outra apenas com as letras presentes
na string. Implemente a função de modo a fazer uma única travessia da string. Sugestão: pode usar as
funções isDigit, isAlpha :: Char -> Bool. -}

digitAlpha :: String -> (String,String)
digitAlpha [] = ([],[])
digitAlpha (h:t) | isDigit h = (h:a,b)
                 | isAlpha h = (a,h:b)
                 where (a,b) = digitAlpha t

{-4. Considere o seguinte tipo de dados para representar uma sequência em que os elementos podem ser
acrecentados à esquerda (Cons) ou por concatenação de duas sequências (App). -}

data Seq a = Nil | Cons a (Seq a) | App (Seq a) (Seq a)

{- (a) Defina a função firstSeq :: Seq a -> a que recebe uma sequência não vazia e devolve o seu
primeiro elemento. -}

firstSeq :: Seq a -> a
firstSeq Nil = error "Something Wrong"
firstSeq (Cons a seq) = a
firstSeq (App Nil seq) = firstSeq seq
firstSeq (App a _) = firstSeq a


{- (b) Defina a função dropSeq :: Int -> Seq a -> Seq a, tal que dropSeq n s elimina os n primeiros
elementos da sequência s. A função deve manter a estrutura da sequência.
Por exemplo: dropSeq 2 (App (App (Cons 7 (Cons 5 Nil)) (Cons 3 Nil)) (Cons 1 Nil)) == App (Cons 3 Nil) (Cons 1 Nil) -}

dropSeq :: Int -> Seq a -> Seq a
dropSeq n Nil = Nil
dropSeq n (Cons a seq) = dropSeq (n-1) seq
dropSeq n (App a b) | n > nx = dropSeq (n - nx) b
                    | n == nx = b
                    | otherwise = (App (dropSeq n a) b)
                    where nx = contaCons a

contaCons :: Seq a -> Int
contaCons Nil = 0
contaCons (Cons _ seq) = 1 + contaCons seq
contaCons (App a b) = contaCons a + contaCons b

{- (c) Declare (Seq a) como instância da classe Show de forma a obter o seguinte comportamento no
interpretador:
> App (Cons 1 Nil) (App (Cons 7 (Cons 5 Nil)) (Cons 3 Nil))
<<1,7,5,3>>-}

instance Show a => Show (Seq a) where
    show x = "<<" ++ mostra x ++ ">>"

mostra :: Show a => Seq a -> String
mostra Nil = ""
mostra (Cons a Nil) = show a
mostra (Cons a s) = show a ++ "," ++ mostra s
mostra (App s1 s2) = mostra s1 ++ "," ++ mostra s2

{-♅-----------------------------------------------------------------------✃----------------------------------------------------------------------♅-}
--Teste 2019/2020

--1. Apresente uma definição recursiva da função (pré-definida):

--(a) intersect :: Eq a => [a] -> [a] -> [a] que retorna a lista resultante de remover da primeira lista os elementos que não pertencem à segunda.

intersect' :: Eq a => [a] -> [a] -> [a]
intersect' [] _ = []
intersect' (x:xs) l = if x `elem` l then x:intersect' xs l else intersect' xs l

--(b) tails :: [a] -> [[a]] que calcula a lista dos sufixos de uma lista.

tails' :: [a] -> [[a]]
tails' [] = [[]]
tails' l = l : tails' (tail l)

{- 2. Para armazenar conjuntos de números inteiros, optou-se pelo uso de sequências de intervalos.
Assim, por exemplo, o conjunto {1, 2, 3, 4, 7, 8, 19, 21, 22, 23}
poderia ser representado por [(1,4),(7,8),(19,19),(21,23)]. -}

type ConjInt = [Intervalo]
type Intervalo = (Int,Int)

{- (a) Defina uma função elems :: ConjInt -> [Int] que, dado um conjunto, dá como resultado a lista
dos elementos desse conjunto. -}

elems :: ConjInt -> [Int]
elems [] = []
elems ((x,y):t) | x == y = x : elems t
                | otherwise = x : elems ((succ x , y):t)

{- (b) Defina uma função geraconj :: [Int] -> ConjInt que recebe uma lista de inteiros, ordenada por
ordem crescente e sem repetições, e gera um conjunto. -}

geraconj :: [Int] -> ConjInt
geraconj [] = []
geraconj l = let a = groupBy (\ x y -> x == y-1) l
                 b = map convInt a
             in b

convInt :: [Int] -> Intervalo
convInt l = (head l, last l)

{- 3. Para armazenar uma agenda de contactos telefónicos e de correio electrónico definiram-se os 
seguintes tipos de dados. Não existem nomes repetidos na agenda e para cada nome existe uma lista 
de contactos. -}

data Contacto = Casa Integer | Trab Integer | Tlm Integer | Email String deriving (Show)
type Nome = String
type Agenda = [(Nome, [Contacto])]

{- (a) Defina a função acrescEmail :: Nome -> String -> Agenda -> Agenda que, dado um nome,
um email e uma agenda, acrescenta essa informação à agenda. -}

acrescEmail :: Nome -> String -> Agenda -> Agenda
acrescEmail nome email [] = [(nome,[Email email])]
acrescEmail nome email agenda = agenda ++ [(nome,[Email email])]

{- (b) Defina a função verEmails :: Nome -> Agenda -> Maybe [String] que, dado um nome e uma
agenda, retorna a lista dos emails associados a esse nome. Se esse nome não existir na agenda a
função deve retornar Nothing. -}

verEmails :: Nome -> Agenda -> Maybe [String]
verEmails nome [(nom,contacto)] = if nome == nom then Just (map (\ x -> case x of Email e -> e) contacto) else  Nothing
verEmails nome ((nom,contacto):agenda) = if nome == nom then verEmails nome [(nom,contacto)] else verEmails nome agenda

{- (c) Defina a função consulta :: [Contacto] -> ([Integer],[String]) que, dada lista de contactos, 
retorna o par com a lista de números de telefone (tanto telefones fixos como telemóveis) e a
lista de emails, dessa lista. Implemente a função de modo a fazer uma única travessia da lista de
contactos. -}

consulta :: [Contacto] -> ([Integer],[String])
consulta = foldr (\x (i,s) -> case x of Email email -> (i,email:s); otherwise -> (n x:i,s)) ([],[]) 
           where n x = case x of Casa num1 -> num1
                                 Trab num2 -> num2
                                 Tlm num3 -> num3

--4. Relembre o tipo RTree a definido nas aulas.

--data RTree a = R a [RTree a] deriving (Show, Eq)

--(a) Defina a função paths :: RTree a -> [[a]] que dada uma destas árvores calcula todos os caminhos desde a raíz até às folhas.

paths :: RTree a -> [[a]]
paths (R n []) = [[n]]
paths (R n ns) = map ((:) n . concat . paths) ns

paths' :: RTree a -> [[a]]
paths' (R a []) = [[a]]
paths' (R a l) = map (\x -> a:x) (concat (map paths' l))

{-(b) Defina a função unpaths :: Eq a => [[a]] -> RTree a inversa da anterior, i.e., tal que unpaths (paths t) == t, para qualquer 
árvore t :: Eq a => RTree a. -}

unpaths :: Eq a => [[a]] -> RTree a
unpaths [[h]] = R h []
unpaths [(h:t)] = R h [(unpaths [t])]
unpaths ((h:t):l) = R h ((unpaths [t]):(map unpaths [l]))

{-♅-----------------------------------------------------------------------✃----------------------------------------------------------------------♅-}