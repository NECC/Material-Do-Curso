module Ficha7 where

--1. Considere o seguinte tipo para representar expressões inteiras.

data ExpInt = Const Int | Simetrico ExpInt | Mais ExpInt ExpInt | Menos ExpInt ExpInt | Mult ExpInt ExpInt

{- Os termos deste tipo ExpInt podem ser vistos como árvores cujas folhas são inteiros e
cujos nodos (não folhas) são operadores.

(a) Defina uma função calcula :: ExpInt -> Int que, dada uma destas expressões
calcula o seu valor. -} 

calcula :: ExpInt -> Int
calcula (Const x) = x
calcula (Simetrico x) = - calcula x
calcula (Mais x y) = calcula x + calcula y
calcula (Menos x y) = calcula x - calcula y
calcula (Mult x y) = calcula x * calcula y

{- (b) Defina uma função infixa :: ExpInt -> String de forma a que
infixa (Mais (Const 3) (Menos (Const 2) (Const 5))) dê como resultado
"(3 + (2 - 5))". -}

infixa :: ExpInt -> String
infixa (Const x) = show x
infixa (Simetrico x) = '-' : '(' :  infixa x ++ ")"
infixa (Mais x y) = '(' : infixa x ++ " + " ++ infixa y ++ ")"
infixa (Menos x y) = '(' : infixa x ++ " - " ++ infixa y ++ ")"
infixa (Mult x y) = '(' : infixa x ++ " * " ++ infixa y ++ ")"

{- (c) Defina uma outra função de conversão para strings posfixa :: ExpInt -> String
de forma a que quando aplicada à expressão acima dê como resultado "3 2 5 -
+". -}

posfixa :: ExpInt -> String
posfixa (Const x) = show x
posfixa (Simetrico x) = posfixa x ++ " -"
posfixa (Mais x y) = posfixa x ++ " " ++  posfixa y ++ " +"
posfixa (Menos x y) = posfixa x ++ " " ++ posfixa y ++ " -"
posfixa (Mult x y) = posfixa x ++ " " ++ posfixa y ++ " *"

--2. Considere o seguinte tipo para representar árvores irregulares (rose trees).

data RTree a = R a [RTree a]

{- Defina as seguintes funções sobre estas árvores:

(a) soma :: Num a => RTree a -> a que soma os elementos da árvore. -}

soma :: Num a => RTree a -> a
soma (R r []) = r
soma (R r l) = r + sum (map soma l) 

--(b) altura :: RTree a -> Int que calcula a altura da árvore.

altura :: RTree a -> Int
altura (R r []) = 1 
altura (R r l) = 1 + maximum( map altura l) 

--(c) prune :: Int -> RTree a -> RTree a que remove de uma árvore todos os elementos a partir de uma determinada profundidade.

prune :: Int -> RTree a -> RTree a
prune 0 (R r _) = R r []
prune x (R r []) | x > 1 = R r []
prune x (R r l) = R r (map (prune (x-1)) l)

--(d) mirror :: RTree a -> RTree a que gera a árvore simétrica.

mirror :: RTree a -> RTree a
mirror (R r l) = R r (map mirror (reverse l)) 

--(e) postorder :: RTree a -> [a] que corresponde à travessia postorder da árvore.

postorder :: RTree a -> [a]
postorder (R r l) = concat (map postorder l) ++ [r]

-- Ou então: postorder (R r l) = concatMap postorder l ++ [r] 

--3. Relembre a definição de árvores binárias apresentada na ficha anterior:

data BTree a = Empty | Node a (BTree a) (BTree a)

{- Nestas árvores a informação está nos nodos (as extermidades da árvore têm apenas
uma marca – Empty). E também habitual definirem-se árvores em que a informação está apenas nas extermidades (leaf trees): -}

data LTree a = Tip a | Fork (LTree a) (LTree a)

{- Defina sobre este tipo as seguintes funções:

(a) ltSum :: Num a => LTree a -> a que soma as folhas de uma árvore. -}

ltSum :: Num a => LTree a -> a
ltSum (Tip x) = x
ltSum (Fork ae ad) = ltSum ae + ltSum ad

{- (b) listaLT :: LTree a -> [a] que lista as folhas de uma árvore (da esquerda para
a direita). -}

listaLT :: LTree a -> [a]
listaLT (Tip x) = [x]
listaLT (Fork ae ad) = listaLT ae ++ listaLT ad

--(c) ltHeight :: LTree a -> Int que calcula a altura de uma árvore.

ltHeight :: LTree a -> Int
ltHeight (Tip x) = 1
ltHeight (Fork ae ad) = 1 + max (ltHeight ae) (ltHeight ad) 

--4. Estes dois conceitos podem ser agrupados num só, definindo o seguinte tipo:

data FTree a b = Leaf b | No a (FTree a b) (FTree a b)

{- São as chamadas full trees onde a informação está não só nos nodos, como também nas
folhas (note que o tipo da informação nos nodos e nas folhas não tem que ser o mesmo).

(a) Defina a função splitFTree :: FTree a b -> (BTree a, LTree b) que separa
uma árvore com informação nos nodos e nas folhas em duas árvores de tipos
diferentes.-}

splitFTree :: FTree a b -> (BTree a, LTree b)
splitFTree (Leaf x) = (Empty, Tip x)
splitFTree (No r ae ad) = ( (Node r (fst(splitFTree ae)) (fst(splitFTree ad)) ) , (Fork (snd(splitFTree ae)) (snd(splitFTree ad)) ) )

-- Ou então:

splitFTree' :: FTree a b -> (BTree a, LTree b)
splitFTree' (Leaf x) = (Empty, Tip x)
splitFTree' (No r ae ad) = (Node r bte btd , Fork lte ltd)
                           where (bte, lte) = splitFTree ae
                                 (btd, ltd) = splitFTree ad

{- (b) Defina ainda a função joinTrees :: BTree a -> LTree b -> Maybe (FTree a b)
que sempre que as árvores sejam compatíveis as junta numa só. -}

joinTrees :: BTree a -> LTree b -> Maybe (FTree a b)
joinTrees (Empty) (Tip x) = Just (Leaf x)
joinTrees (Node r ae1 ad1) (Fork ae2 ad2) = Just (No r aux1 aux2)
                                            where Just aux1 = joinTrees ae1 ae2
                                                  Just aux2 = joinTrees ad1 ad2 
joinTrees _ _ = Nothing