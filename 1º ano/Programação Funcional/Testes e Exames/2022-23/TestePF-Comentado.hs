-- Author: Bruno Jardim @ NECC/UMinho
-- Date: 2023-01-27
-- Description: Teste de Programação Funcional 2023-01-9

import Data.List.Split (splitOn)

-- Exercício 1
-- Função clássica das 50 questões de PF
unlines' :: [String] -> String
unlines' [x] = x
unlines' (h:t) = h ++ "\n" ++ unlines' t

-- Exercício 2
-- Função que recebe uma lista de strings e devolve uma string com os elementos da lista separados por vírgulas
-- Exemplo: ["a","b","c"] -> "a,b,c"
comma :: [String] -> String
comma [x] = x
comma (h:t) = h ++ "," ++ comma t


type Matrix = [[Int]]
-- Função fornecida no enunciado
stringToMatrix :: String -> Matrix
stringToMatrix s = map stringToVector (lines s)

-- a)
-- Função que recebe uma string e devolve uma lista de inteiros
-- Separamos a string pelas vírgulas e depois convertemos cada elemento da lista de strings para inteiro
stringToVector :: String -> [Int]
stringToVector s = map read $ splitOn "," $ s

-- b)
-- A estratégia utilizada foi converter a string para matriz, transpor a matriz e converter a matriz transposta para string
-- Função que recebe uma matriz e devolve uma string
-- Exemplo: [[1,2,3],[4,5,6]] -> "1,2,3\n4,5,6"

matrixToString :: Matrix -> String
matrixToString m = unlines $ map vectorToString m

-- Função que recebe uma lista de inteiros e devolve uma string
-- Exemplo: [1,2,3] -> "1,2,3"
vectorToString :: [Int] -> String
vectorToString v = comma $ map show v

-- Função que transpõe uma matriz
-- Exemplo: [[1,2,3],[4,5,6]] -> [[1,4],[2,5],[3,6]]
transpose :: Matrix -> Matrix
transpose ([]:_) = []
transpose m = (map head m) : transpose (map tail m)

-- Função pedida no enunciado
-- Começamos por converter a string para matriz, transpomos a matriz e depois convertemos a matriz transposta para string
transposta :: String -> String
transposta s = matrixToString $ transpose $ stringToMatrix s


-- Exercício 3

data Lista a = Esq a (Lista a) | Dir (Lista a) a | Nula deriving (Show)

-- a)
-- Função que recebe uma lista e devolve a mesma lista sem o último elemento
-- A estratégia para perceber este problema e assumir que temos uma lista e vamos adicionando elementos à esquerda e à direita
semUltimo :: Lista a -> Lista a
-- Casos base existe apenas 1 elemento na lista
semUltimo (Esq x Nula) = Nula
semUltimo (Dir Nula x) = Nula  
-- Casos "recursivos" 
-- Como o elemento está na esquerda, vamos tirar o elemento mais à direita
semUltimo (Esq x l) = Esq x (semUltimo l)
-- Como o elemento "x" está na direita, vamos tirar o elemento
semUltimo (Dir l x) = l

-- b)
-- Em vez de estarmos a complicar o exercicio, convertemos a "Lista a" para uma lista normal e depois aplicamos a função show
-- Função que recebe uma "Lista a" e devolve uma lista de a
toList :: Lista a -> [a]
toList Nula = []
toList (Esq x l) = x : toList l
toList (Dir l x) = toList l ++ [x]

-- Como o show para listas normais já está definido, podemos usar a função show para converter a lista para string
showListaA :: Show a => Lista a -> String
showListaA = show . toList

-- Exercício 4
data BTree a = Empty | Node a (BTree a) (BTree a) deriving (Show)

-- Função fornecida no enunciado
inorder :: BTree a -> [a]
inorder Empty = []
inorder (Node r e d) = (inorder e) ++ (r:inorder d)

-- a)
-- Utilizando a sugetão do enunciado, vamos utilizar a função auxiliar numeraAux para percorrer a árvore e atribuir um número a cada nó
numera :: BTree a -> BTree (Int, a)
-- Como a função numeraAux devolve um par, vamos usar o snd para devolver apenas a árvore
numera t = snd $ numeraAux 1 t

numeraAux :: Int -> BTree a -> (Int, BTree (Int, a))
-- Caso base, a árvore está vazia
numeraAux n Empty = (n, Empty)
-- Caso recursivo, vamos percorrer a árvore e atribuir um número a cada nó
-- Como a travessia é inorder, vamos atribuir o número ao nó da esquerda, depois ao nó raiz e depois ao nó da direita
numeraAux n (Node r e d) = (n2, Node (n1,r) e' d')
    where
        -- Atribuir o número ao nó da esquerda, n1 é o número do nó raiz
        (n1,e') = numeraAux n e
        -- Atribuir o número ao nó da direita
        (n2,d') = numeraAux (n1+1) d

-- b)
-- unInorder find all the possible trees that can be built from a given inorder traversal
-- Não vou mentir este exercicio é meio puxadito e é o tipo de exercicio para nao deixar um aluno tirar 20
unInorder :: [a] -> [BTree a]
-- Caso base, a lista está vazia
unInorder [] = [Empty]
-- Básicamente o que se está a fazer é percorrer a lista e para cada elemento da lista, vamos criar uma árvore com esse elemento como raiz
-- isso é o que se está a fazer com o c <- [0..length l-1]
-- Depois vamos criar as sub-árvores da esquerda e da direita
-- Para isso vamos usar a função unInorder e passar como argumento a lista até ao elemento c e depois a lista depois do elemento c
-- Para finalizar, temos que ter em consideração que o elemento c é um indice e nao um elemento da lista
-- Por isso temos que usar o operador (!!) para obter o elemento da lista
unInorder l = [Node ((!!) l c) e d | c <- [0..length l-1], e <- unInorder (take c l), d <- unInorder (drop (c+1) l)]