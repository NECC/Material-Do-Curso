module Ficha6 where

--1. Considere o seguinte tipo para representar árvores binárias.

data BTree a = Empty | Node a (BTree a) (BTree a) deriving Show

{- Defina as seguintes funções:

(a) altura :: BTree a -> Int que calcula a altura da árvore. -}

altura :: BTree a -> Int
altura Empty = 0
altura (Node r ae ad) = 1 + max (altura ae) (altura ad)

--(b) contaNodos :: BTree a -> Int que calcula o número de nodos da árvore.

contaNodos :: BTree a -> Int
contaNodos Empty = 0
contaNodos (Node r ae ad) = 1 + contaNodos ae + contaNodos ad 

--(c) folhas :: BTree a -> Int, que calcula o número de folhas (i.e., nodos sem descendentes) da árvore.

folhas :: BTree a -> Int
folhas Empty = 0
folhas (Node r Empty Empty) = 1
folhas (Node r ae ad) = folhas ae + folhas ad  

--(d) prune :: Int -> BTree a -> BTree a, que remove de uma árvore todos os elementos a partir de uma determinada profundidade.

prune :: Int -> BTree a -> BTree a
prune _ Empty = Empty
prune 0 _ = Empty
prune x (Node r ae ad) = Node r (prune (x-1) ae) (prune (x-1) ad)

{- (e) path :: [Bool] -> BTree a -> [a], que dado um caminho (False corresponde
a esquerda e True a direita) e uma árvore, dá a lista com a informação dos nodos
por onde esse caminho passa. -}

path :: [Bool] -> BTree a -> [a]
path _ Empty = []
path [] (Node r ae ad) = [r]
path (x:xs) (Node r ae ad) = if x == True then r : (path xs ad) else r : (path xs ae)   

--(f) mirror :: BTree a -> BTree a, que dá a árvore simétrica.

mirror :: BTree a -> BTree a
mirror Empty = Empty
mirror (Node r ae ad) = Node r (mirror ad) (mirror ae)

--(g) zipWithBT :: (a -> b -> c) -> BTree a -> BTree b -> BTree c que generaliza a função zipWith para árvores binárias.

zipWithBT :: (a -> b -> c) -> BTree a -> BTree b -> BTree c 
zipWithBT f (Node r1 ae1 ad1) (Node r2 ae2 ad2) = let ae = (zipWithBT f ae1 ae2)
                                                      ad = (zipWithBT f ad1 ad2)
                                                  in Node (f r1 r2) ae ad
zipWithBT _ _ _ = Empty

{- (h) unzipBT :: BTree (a,b,c) -> (BTree a,BTree b,BTree c), que generaliza a
função unzip (neste caso de triplos) para árvores binárias. -}

unzipBT :: BTree (a,b,c) -> (BTree a,BTree b,BTree c)
unzipBT Empty = (Empty,Empty,Empty)
unzipBT (Node (r1,r2,r3) ae ad) = let (ae1,ae2,ae3) = unzipBT ae
                                      (ad1,ad2,ad3) = unzipBT ad
                                  in ((Node r1 ae1 ad1),(Node r2 ae2 ad2),(Node r3 ae3 ad3))

{- 2. Defina as seguintes funções, assumindo agora que as árvores são binárias de procura:

(a) Defina uma função minimo :: Ord a => BTree a -> a que calcula o menor elemento de uma árvore binária de procura não vazia. -}

minimo :: Ord a => BTree a -> a
minimo (Node r Empty _) = r
minimo (Node r ae ad) = minimo ae

{- (b) Defina uma função semMinimo :: Ord a => BTree a -> BTree a que remove o
menor elemento de uma árvore binária de procura não vazia. -}

semMinimo :: Ord a => BTree a -> BTree a
semMinimo (Node r Empty Empty) = Empty
semMinimo (Node r Empty ad ) = ad
semMinimo (Node r ae ad) = Node r (semMinimo ae) ad 

{- (c) Defina uma função minSmin :: Ord a => BTree a -> (a,BTree a) que calcula,
com uma única travessia da árvore o resultado das duas funções anteriores. -}

minSmin :: Ord a => BTree a -> (a,BTree a)
minSmin (Node r Empty Empty) = (r,Empty)
minSmin (Node r Empty ad) = (r,ad)
minSmin (Node r ae ad) = let (min, ae') = minSmin ae
                         in (min, Node r ae' ad)

{- (d) Defina uma função remove :: Ord a => a -> BTree a -> BTree a que remove
um elemento de uma árvore binária de procura, usando a função anterior. -}

remove :: Ord a => a -> BTree a -> BTree a
remove _ Empty = Empty
remove x (Node r ae ad) | x > r = Node r ae (remove x ad)
                        | x < r = Node r (remove x ae) ad
                        | otherwise = aux ad ae
                        where aux :: Ord a => BTree a -> BTree a -> BTree a
                              aux Empty ad = ad
                              aux ae Empty = ae
                              aux ae ad = let ( m,ad') = minSmin ad
                                          in Node m ae ad'

{- 3. Considere agora que guardamos a informação sobre uma turma de alunos na seguinte
estrutura de dados: -}

type Aluno = (Numero,Nome,Regime,Classificacao)
type Numero = Int
type Nome = String
data Regime = ORD | TE | MEL deriving Show
data Classificacao = Aprov Int | Rep | Faltou deriving Show
type Turma = BTree Aluno -- árvore binária de procura (ordenada por número)

{- Defina as seguintes funções:

(a) inscNum :: Numero -> Turma -> Bool, que verifica se um aluno, com um dado
número, está inscrito. -}

inscNum :: Numero -> Turma -> Bool
inscNum num Empty = False
inscNum num (Node (n,_,_,_) ae ad) | num < n = inscNum num ae
                                   | num > n = inscNum num ad
                                   |otherwise = True

{- (b) inscNome :: Nome -> Turma -> Bool, que verifica se um aluno, com um dado
nome, está inscrito. -}

inscNome :: Nome -> Turma -> Bool
inscNome nom Empty = False
inscNome nom (Node (_,name,_,_) ae ad) = nom == name || inscNome nom ae || inscNome nom ad


{- (c) trabEst :: Turma -> [(Numero,Nome)], que lista o número e nome dos alunos
trabalhadores-estudantes (ordenados por número). -}

trabEst :: Turma -> [(Numero,Nome)]
trabEst Empty = []
trabEst (Node (num,name,reg,_) ae ad) = (case reg of TE -> [(num,name)] ++ trabEst ae ++ trabEst ad; otherwise -> [] )

{- (d) nota :: Numero -> Turma -> Maybe Classificacao, que calcula a classificação
de um aluno (se o aluno não estiver inscrito a função deve retornar Nothing). -}

nota :: Numero -> Turma -> Maybe Classificacao
nota num Empty = Nothing
nota num (Node (n,_,_,clas) ae ad) | num > n = nota num ad
                                   | num < n = nota num ae
                                   | otherwise = Just clas

--(e) percFaltas :: Turma -> Float, que calcula a percentagem de alunos que faltaram à avaliação.

percFaltas :: Turma -> Float
percFaltas Empty = 0
percFaltas t = ((fromIntegral(faltas t))/(fromIntegral(contaNodos t)))*100
                                       where faltas :: Turma -> Int
                                             faltas Empty = 0
                                             faltas (Node (_,_,_,clas) ae ad) = (case clas of Faltou -> 1 + faltas ae + faltas ad; otherwise -> 0)

{- (f) mediaAprov :: Turma -> Float, que calcula a média das notas dos alunos que
passaram. -}

mediaAprov :: Turma -> Float
mediaAprov Empty = 0
mediaAprov t = sumNotas t / total t
               where sumNotas :: Turma -> Float
                     sumNotas Empty = 0
                     sumNotas (Node (_,_,_,clas) ae ad) = (case clas of Aprov nota -> fromIntegral nota + sumNotas ae + sumNotas ad; otherwise -> sumNotas ae + sumNotas ad)
                     total :: Turma -> Float
                     total Empty = 0
                     total (Node (_,_,_,clas) ae ad) = (case clas of Aprov nota -> 1 + total ae + total ad; otherwise -> 0)

--(g) aprovAv :: Turma -> Float, que calcula o rácio de alunos aprovados por avaliados. Implemente esta função fazendo apenas uma travessia da árvore.

aprovAv :: Turma -> Float
aprovAv Empty = 0
aprovAv t = a/b
            where (a,b) = aux t
                  aux Empty = (0,0)
                  aux (Node (_,_,_,clas) ae ad) = (case clas of Aprov nota -> (x+1,y); Rep -> (x,y+1); otherwise -> (x,y))
                                                   where (x,y) = (aprovesq + aprovdir, repesq + repdir)
                                                         (aprovesq,repesq) = aux ae
                                                         (aprovdir,repdir) = aux ad