module Ficha4 where

import Ficha1
import Data.Char
import Data.List (inits)

{- 1. Para cada uma das expressões seguintes, exprima por enumeração a lista correspondente. Tente ainda, para cada caso, descobrir uma outra forma de obter o mesmo
resultado. -}

--(a) [x | x <- [1..20], mod x 2 == 0, mod x 3 == 0]

--R.: Pega no x que varia de 1 até 20 retirando apenas aqueles que têm modulo tanto de 2 como 3 ficando [6,12,18]  

--(b) [x | x <- [y | y <- [1..20], mod y 2 == 0], mod x 3 == 0]

--R.: Faz exatamente o mesmo que a alínea anterior logo fica [6,12,18]

--(c) [(x,y) | x <- [0..20], y <- [0..20], x+y == 30]

--R.: Vai retornar uma lista de pares tal que a soma dê 30. Ficando[(10,20),(11,19),(12,18),(13,17),...,(20,10)]

--(d) [sum [y | y <- [1..x], odd y] | x <- [1..10]]

{-R.: Neste caso y apenas pode tomar valores impares de x e acaba por formar uma lista com os seguintes valores [[1],[1],[1,3],[1,3],[1,3,5],
[1,3,5],[1,3,5,7],[1,3,5,7],[1,3,5,7,9],[1,3,5,7,9]], por fim faz a soma dos valores de cada lista ficando [1,1,4,4,9,9,16,16,25,25] -}

--2. Defina cada uma das listas seguintes por compreensão.

--(a) [1,2,4,8,16,32,64,128,256,512,1024]

--R.: Esta lista representa os valores de 2^0 ate 2^10.
exp2 = [2^x | x <- [0..10]]

--(b) [(1,5),(2,4),(3,3),(4,2),(5,1)]

--R.: Par de valores em que a soma dê 6.
sum6 = [(x,y) | x <- [1..10], y <- [1..10], x+y == 6]

--(c) [[1],[1,2],[1,2,3],[1,2,3,4],[1,2,3,4,5]]

--R.: Lista com listas de todos os valores menores que 6.
min6 = [[y | y <- [1..x]] | x <- [1..5]]
min6' = [[1..x] | x <- [1..5]]

--(d) [[1],[1,1],[1,1,1],[1,1,1,1],[1,1,1,1,1]]

--R.: Lista com listas de o valor 1 repetidos no máximo 5 vezes
list1 = [replicate x 1 | x <- [1..5]]

--(e) [1,2,6,24,120,720]

--R.: 720/120 = 6; 120/24 = 5; 24/6 = 4;...
prod = [product [y | y <- [1..x]] | x <-[1..6]]

{- 3. Defina a função digitAlpha :: String -> (String,String), que dada uma string,
devolve um par de strings: uma apenas com as letras presentes nessa string, e a outra
apenas com os números presentes na string. Implemente a função de modo a fazer uma
única travessia da string. Relembre que as funções isDigit,isAlpha :: Char -> Bool
estão já definidas no módulo Data.Char. -}

digitAlpha :: String -> (String,String)
digitAlpha [] = ([],[])
digitAlpha (s:ss) | isDigit s = (a,s:b)
                  | isAlpha s = (s:a,b)
                  | otherwise = digitAlpha ss
                  where (a,b) = digitAlpha ss

{-Nota: it takes the second argument and the first item of the list and 
applies the function to them, then feeds the function with this result 
and the second argument and so on. -}

digitAlpha' :: String -> (String,String)
digitAlpha' string = foldl (\(alpha,digit) s -> if isDigit s then (alpha,digit ++ [s]) else if isAlpha s then (alpha ++ [s], digit) else (alpha,digit)) ("","") string 
 

{- 4. Defina a função nzp :: [Int] -> (Int,Int,Int) que, dada uma lista de inteiros,
conta o número de valores negativos, o número de zeros e o número de valores positivos,
devolvendo um triplo com essa informação. Certifique-se que a função que definiu
percorre a lista apenas uma vez. -}

nzp :: [Int] -> (Int,Int,Int)
nzp [] = (0,0,0)
nzp (x:xs) | x > 0 = (n,z,p+1)
           | x == 0 = (n,z+1,p)
           | x < 0 = (n+1,z,p)
           | otherwise = nzp xs
           where (n,z,p) = nzp xs

nzp' :: [Int] -> (Int,Int,Int)
nzp' = foldl (\(neg,zer,pos) x -> if x > 0 then (neg,zer,pos+1) else if x == 0 then (neg,zer+1,pos)  else (neg+1,zer,pos)) (0,0,0)

--5. Defina a função divMod :: Integral a => a -> a -> (a, a) que calcula simultaneamente a divisão e o resto da divisão inteira por subtracções sucessivas.

divMod' :: Integral a => a -> a -> (a, a)
divMod' x y = if x - y > 0 then (divi+1,res) else (0,x)
              where (divi,res) = divMod' (x-y) y
             
divMod'' :: Integral a => a -> a -> (a, a)
divMod'' x y = foldl (\(div',res) n -> (div'+1,res-y)) (0,x) [y,2*y..x]

--6. Utilizando uma função auxiliar com um acumulador, optimize seguinte definição recursiva que determina qual o número que corresponde a uma lista de digitos.

fromDigits :: [Int] -> Int
fromDigits [] = 0
fromDigits (h:t) = h*10^(length t) + fromDigits t

{- Note que
fromDigits [1,2,3,4] = 1 × 103 + 2 × 102 + 3 × 101 + 4 × 100
= 4 + 10 × (3 + 10 × (2 + 10 × (1 + 10 × 0))) -}

fromDigits' :: [Int] -> Int
fromDigits' l = aux 0 l 
                where aux :: Int -> [Int] -> Int
                      aux n [] = n
                      aux n (x:xs) = aux (n*10+x) xs

fromDigits'' :: [Int] -> Int
fromDigits'' = foldl (\acc x -> x+10^acc) 0

{- 7. Utilizando uma função auxiliar com acumuladores, optimize seguinte definição que
determina a soma do segmento inicial de uma lista com soma máxima. -}

maxSumInit :: (Num a, Ord a) => [a] -> a
maxSumInit l = maximum [sum m | m <- inits l]

maxSumInit'' :: (Num a, Ord a) => [a] -> a
maxSumInit'' l = foldl (\ acc x -> max(sum x) acc) (sum l) (inits l)

{- 8. Optimize a seguinte definição recursiva da função que calcula o n-ésimo número da
sequência de Fibonacci, usando uma função auxiliar com 2 acumuladores que representam, respectivamente, 
o n-ésimo e o n+1-ésimo números dessa sequência. -}

fib :: Int -> Int
fib 0 = 0
fib 1 = 1
fib n = fib (n-1) + fib (n-2)

fib' :: Int -> Int
fib' n = aux (0,1) n
         where aux :: (Int,Int) -> Int -> Int
               aux (a,b) 0 = a
               aux (a,b) 1 = b
               aux (a,b) x | x>1 = aux (a,a+b) (x-1)