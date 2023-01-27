-- Author: Bruno Jardim @ NECC/UMinho
-- Date: 2023-01-27
-- Description: Teste de Programação Funcional 2023-01-9

import Data.List.Split (splitOn)

-- Exercício 1
unlines' :: [String] -> String
unlines' [x] = x
unlines' (h:t) = h ++ "\n" ++ unlines' t

-- Exercício 2
type Matrix = [[Int]]

stringToMatrix :: String -> Matrix
stringToMatrix s = map stringToVector (lines s)
-- a)
stringToVector :: String -> [Int]
stringToVector s = map read $ splitOn "," $ s
-- b)

matrixToString :: Matrix -> String
matrixToString m = unlines $ map vectorToString m

comma :: [String] -> String
comma [x] = x
comma (h:t) = h ++ "," ++ comma t

vectorToString :: [Int] -> String
vectorToString v = comma $ map show v

transpose :: Matrix -> Matrix
transpose ([]:_) = []
transpose m = (map head m) : transpose (map tail m)

transposta :: String -> String
transposta s = matrixToString $ transpose $ stringToMatrix s

-- Exercício 3

data Lista a = Esq a (Lista a) | Dir (Lista a) a | Nula deriving (Show)

-- a)
semUltimo :: Lista a -> Lista a
semUltimo (Esq x Nula) = Nula
semUltimo (Dir Nula x) = Nula  
semUltimo (Esq x l) = Esq x (semUltimo l)
semUltimo (Dir l x) = l

-- b)
toList :: Lista a -> [a]
toList Nula = []
toList (Esq x l) = x : toList l
toList (Dir l x) = toList l ++ [x]

showListaA :: Show a => Lista a -> String
showListaA = show . toList

-- Exercício 4
data BTree a = Empty | Node a (BTree a) (BTree a) deriving (Show)

inorder :: BTree a -> [a]
inorder Empty = []
inorder (Node r e d) = (inorder e) ++ (r:inorder d)

-- a)
numera :: BTree a -> BTree (Int, a)
numera t = snd $ numeraAux 1 t

numeraAux :: Int -> BTree a -> (Int, BTree (Int, a))
numeraAux n Empty = (n, Empty)
numeraAux n (Node r e d) = (n2, Node (n1,r) e' d')
    where
        (n1,e') = numeraAux n e
        (n2,d') = numeraAux (n1+1) d

-- b)
unInorder :: [a] -> [BTree a]
unInorder [] = [Empty]
unInorder l = [Node ((!!) l c) e d | c <- [0..length l-1], e <- unInorder (take c l), d <- unInorder (drop (c+1) l)]