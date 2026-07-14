module EparaPassar where

import Data.Char
import Data.List 

--1. Apresente uma definição recursiva da função (pré-definida) enumFromTo :: Int -> Int -> [Int] que constrói a lista dos números inteiros compreendidos entre dois limites.

myenumFromTo :: Int -> Int -> [Int]
myenumFromTo x y | x >= y = x : []
                 | x < y = x : myenumFromTo (x+1) y
                 | otherwise = []

--2. Apresente uma definição recursiva da função (pré-definida) enumFromThenTo :: Int -> Int -> Int -> [Int] que constrói a lista dos números inteiros compreendidos entre dois limites e espaçados de um valor constante.

myenumFromThenTo :: Int -> Int -> Int -> [Int]
myenumFromThenTo x y z | x >= z = x : []
                       | x < z = x : myenumFromThenTo y ( y + ( y - x ) ) z
                       | otherwise = []

--3. Apresente uma definição recursiva da função (pré-definida) (++) :: [a] -> [a] -> [a] que concatena duas listas.

(+++) :: [a] -> [a] -> [a]
(+++) x [] = x
(+++) [] x = x
(+++) (x:xs) l = x : ((+++) xs l) 

{-4. Apresente uma definição recursiva da função (pré-definida) (!!) :: [a] -> Int -> a que dada uma lista e um inteiro, calcula o elemento da lista que se encontra nessa posição (assumese que o primeiro elemento se 
encontra na posição 0). -}

(!!!) :: [a] -> Int -> a
(!!!) (h:t) 0 = h
(!!!) (h:t) n = (!!!) t (n-1) 

--5. Apresente uma definição recursiva da função (pré-definida) reverse :: [a] -> [a] que dada uma lista calcula uma lista com os elementos dessa lista pela ordem inversa.

myreverse :: [a] -> [a]
myreverse [] = []
myreverse (h:t) = myreverse t ++ [h]

--6. Apresente uma definição recursiva da função (pré-definida) take :: Int -> [a] -> [a] que dado um inteiro n e uma lista l calcula a lista com os (no máximo) n primeiros elementos de l.

mytake :: Int -> [a] -> [a]
mytake n [] = []
mytake n (h:t) = if n > 0 then h : mytake (n-1) t else []

--7. Apresente uma definição recursiva da função (pré-definida) drop :: Int -> [a] -> [a] que dado um inteiro n e uma lista l calcula a lista sem os (no máximo) n primeiros elementos de l.

mydrop :: Int -> [a] -> [a]
mydrop n [] = []
mydrop 0 l = l
mydrop n (h:t) = if n > 0 then mydrop (n-1) t else (h:t)

--8. Apresente uma definição recursiva da função (pré-definida) zip :: [a] -> [b] -> [(a,b)] constrói uma lista de pares a partir de duas listas.

myzip :: [a] -> [b] -> [(a,b)]
myzip (x:xs) (y:ys) = (x , y) : myzip xs ys
myzip _ _ = []


--9. Apresente uma definição recursiva da função (pré-definida) elem :: Eq a => a -> [a] -> Bool que testa se um elemento ocorre numa lista.

myelem :: Eq a => a -> [a] -> Bool
myelem x [] = False
myelem x (h:t) = if x == h then True else myelem x t


--10. Apresente uma definição recursiva da função (pré-definida) replicate :: Int -> a -> [a] que dado um inteiro n e um elemento x constrói uma lista com n elementos, todos iguais a x.

myreplicate :: Int -> a -> [a]
myreplicate 0 _ = []
myreplicate n l = if n > 0 then l : myreplicate (n-1) l else []

{-11. Apresente uma definição recursiva da função (pré-definida) intersperse :: a -> [a] -> [a] que dado um elemento e uma lista, constrói uma lista em que o elemento fornecido é intercalado entre os elementos da 
lista fornecida. -}

myintersperse :: a -> [a] -> [a]
myintersperse x [] = []
myintersperse x [a] = [a]
myintersperse x (h:t) = h : x : myintersperse x t 

--12. Apresente uma definição recursiva da função (pré-definida) group :: Eq a => [a] -> [[a]] que agrupa elementos iguais e consecutivos de uma lista.

mygroup :: Eq a => [a] -> [[a]]
mygroup [] = []
mygroup (h:t) = (h : takeWhile (==h) t) : mygroup (dropWhile (==h) t)

--13. Apresente uma definição recursiva da função (pré-definida) concat :: [[a]] -> [a] que concatena as listas de uma lista. 

myconcat :: [[a]] -> [a]
myconcat [] = []
myconcat (h:t) = h ++ myconcat t

--14. Apresente uma definição recursiva da função (pré-definida) inits :: [a] -> [[a]] que calcula a lista dos prefixos de uma lista.

myinits::[a]->[[a]]
myinits [] = [[]]
myinits l  = myinits (init l) ++ [l]

--15. Apresente uma definição recursiva da função (pré-definida) tails :: [a] -> [[a]] que calcula a lista dos sufixos de uma lista.

mytails :: [a] -> [[a]]
mytails [] = [[]]
mytails l = l : mytails (tail l)

--16. Apresente uma definição recursiva da função (pré-definida) isPrefixOf :: Eq a => [a] -> [a] -> Bool que testa se uma lista é prefixo de outra.

myisPrefixOf :: Eq a => [a] -> [a] -> Bool
myisPrefixOf [] _ = True
myisPrefixOf _ [] = False
myisPrefixOf (x:xs) (y:ys) = x == y && myisPrefixOf xs ys

--17. Apresente uma definição recursiva da função (pré-definida) isSuffixOf :: Eq a => [a] -> [a] -> Bool que testa se uma lista é sufixo de outra.

myisSuffixOf :: Eq a => [a] -> [a] -> Bool
myisSuffixOf [] _ = True
myisSuffixOf _ [] = False
myisSuffixOf l1 l2 = isPrefixOf (reverse l1) (reverse l2)

--18. Apresente uma definição recursiva da função (pré-definida) isSubsequenceOf :: Eq a => [a] -> [a] -> Bool que testa se os elementos de uma lista ocorrem noutra pela mesma ordem relativa.

myisSubsequenceOf :: Eq a => [a] -> [a] -> Bool
myisSubsequenceOf [] _ = True
myisSubsequenceOf _ [] = False
myisSubsequenceOf (x:xs) (y:ys) = if x == y then myisSubsequenceOf xs ys else myisSubsequenceOf (x:xs) ys  

--19. Apresente uma definição recursiva da função (pré-definida) elemIndices :: Eq a => a -> [a] -> [Int] que calcula a lista de posições em que um dado elemento ocorre numa lista.

myelemIndices :: Eq a => a -> [a] -> [Int]
myelemIndices x [] = []
myelemIndices x l = aux 0 x l
                    where aux i x [] = []
                          aux i x (h:t) = if x == h then (i) : aux (i+1) x t else aux (i+1) x t 


--20. Apresente uma definição recursiva da função (pré-definida) nub :: Eq a => [a] -> [a] que calcula uma lista com os mesmos elementos da recebida, sem repetições.

mynub :: Eq a => [a] -> [a]
mynub [] = []
mynub (h:t) = h : filter (/= h) (mynub t)


--21. Apresente uma definição recursiva da função (pré-definida) delete :: Eq a => a -> [a] -> [a] que retorna a lista resultante de remover (a primeira ocorrência) de um dado elemento de uma lista.

mydelete :: Eq a => a -> [a] -> [a]
mydelete x [] = []
mydelete x (h:t) = if x == h then t else h : mydelete x t

--22. Apresente uma definição recursiva da função (pré-definida) (\\):: Eq a => [a] -> [a] -> [a] que retorna a lista resultante de remover (as primeiras ocorrências) dos elementos da segunda lista da primeira.

(\\\):: Eq a => [a] -> [a] -> [a]
(\\\) l [] = l
(\\\) [] _ = []
(\\\) l (h:t) = (\\\) (delete h l) t  

--23. Apresente uma definição recursiva da função (pré-definida) union :: Eq a => [a] -> [a] -> [a] que retorna a lista resultante de acrescentar à primeira lista os elementos da segunda que não ocorrem na primeira.

myunion :: Eq a => [a] -> [a] -> [a]
myunion [] l = l
myunion l [] = l
myunion l (h:t) = if elem h l then myunion l t else myunion (l++[h]) t


--24. Apresente uma definição recursiva da função (pré-definida) intersect :: Eq a => [a] -> [a] -> [a] que retorna a lista resultante de remover da primeira lista os elementos que não pertencem à segunda.

myintersect :: Eq a => [a] -> [a] -> [a]
myintersect [] _ = []
myintersect (h:t) l = if elem h l then h : myintersect t l else myintersect t l

--25. Apresente uma definição recursiva da função (pré-definida) insert :: Ord a => a -> [a] -> [a] que dado um elemento e uma lista ordenada retorna a lista resultante de inserir ordenadamente esse elemento na lista.

myinsert :: Ord a => a -> [a] -> [a]
myinsert x [] = [x]
myinsert x (h:t) = if x < h then x:h:t else h:myinsert x t


--26. Apresente uma definição recursiva da função (pré-definida) unwords :: [String] -> String que junta todas as strings da lista numa só, separando-as por um espaço.

myunwords :: [String] -> String
myunwords [] = ""
myunwords [x] = x
myunwords (x:xs) = x ++ " " ++ myunwords xs

--27. Apresente uma definição recursiva da função (pré-definida) unlines :: [String] -> String junta todas as strings da lista numa só, separando-as pelo caracter ’\n’.

myunlines :: [String] -> String
myunlines [] = ""
myunlines [x] = x
myunlines (x:xs) = x ++ "\n" ++ myunlines xs


{-28. Apresente uma definição recursiva da função pMaior :: Ord a => [a] -> Int que dada uma lista não vazia, retorna a posição onde se encontra o maior elemento da lista. As posições da lista começam em 0, i.e., 
a função deverá retornar 0 se o primeiro elemento da lista for o maior. -}

mypMaior :: Ord a => [a] -> Int
mypMaior (h:t) = aux 0 0 h t
             where aux i im _ [] = im
                   aux i im x (y:ys) = if x < y then aux (i+1) (i+1) y ys else aux (i+1) im x ys    

--29. Apresente uma definição recursiva da função temRepetidos :: Eq a => [a] -> Bool que testa se uma lista tem elementos repetidos. 

mytemRepetidos :: Eq a => [a] -> Bool
mytemRepetidos [] = False
mytemRepetidos (h:t) = elem h t || mytemRepetidos t


--30.  Apresente uma definição recursiva da função algarismos :: [Char] -> [Char] que determina a lista dos algarismos de uma dada lista de caracteres.

myalgarismos :: [Char] -> [Char]
myalgarismos = filter (`elem` ['0'..'9']) 


--31. Apresente uma definição recursiva da função posImpares :: [a] -> [a] que determina os elementos de uma lista que ocorrem em posições ímpares. Considere que o primeiro elemento da lista ocorre na posição 0 e por isso par.

posImpares :: [a] -> [a]
posImpares [] = []
posImpares [a] = []
posImpares (a:b:t) = b:posImpares t

--32. Apresente uma definição recursiva da função posPares :: [a] -> [a] que determina os elementos de uma lista que ocorrem em posições pares. Considere que o primeiro elemento da lista ocorre na posição 0 e por isso par.

posPares :: [a] -> [a]
posPares [] = []
posPares [a] = [a]
posPares (a:b:t) = a:posPares t

--33. Apresente uma definição recursiva da função isSorted :: Ord a => [a] -> Bool que testa se uma lista está ordenada por ordem crescente.

myisSorted :: Ord a => [a] -> Bool
myisSorted [] = True
myisSorted [x] = True
myisSorted (x:y:xs) = if x > y then False else myisSorted (y:xs) 

{-34. Apresente uma definição recursiva da função iSort :: Ord a => [a] -> [a] que calcula o resultado de ordenar uma lista. Assuma, se precisar, que existe definida a função insert :: Ord a => a -> [a] -> [a] que dado um elemento 
e uma lista ordenada retorna a lista resultante de inserir ordenadamente esse elemento na lista. -}

myiSort :: Ord a => [a] -> [a]
myiSort [] = []
myiSort (h:t) = insert h (myiSort t)


--35. Apresente uma definição recursiva da função menor :: String -> String -> Bool que dadas duas strings, retorna True se e só se a primeira for menor do que a segunda, segundo a ordem lexicográfica (i.e., do dicionário)

menor :: String -> String -> Bool
menor _ "" = False
menor "" _ = True
menor (x:xs) (y:ys) = x < y || menor xs ys

{- 36. Considere que se usa o tipo [(a,Int)] para representar multi-conjuntos de elementos de a.Considere ainda que nestas listas não há pares cuja primeira componente coincida, nem cuja
segunda componente seja menor ou igual a zero. Defina a função elemMSet :: Eq a => a -> [(a,Int)] -> Bool que testa se um elemento pertence a um multi-conjunto.
Por exemplo, elemMSet 'a' [('b',2), ('a',4), ('c',1)] corresponde a True enquanto que elemMSet 'd' [('b',2), ('a',4), ('c',1)] corresponde a False. -}

elemMSet' :: Eq a => a -> [(a,Int)] -> Bool
elemMSet' n [] = False
elemMSet' n ((x,xs):t) = if n == x then True else elemMSet' n t

{- 37. Defina a função lengthMSet :: [(a,Int)] -> Int que calcula o tamanho de um multiconjunto.
Por exemplo, lengthMSet [('b',2), ('a',4), ('c',1)] corresponde a 7. -}

lengthMSet' :: [(a,Int)] -> Int
lengthMSet' = sum . map snd

{- 38. Defina a função converteMSet :: [(a,Int)] -> [a] que converte um multi-conjuto na
lista dos seus elementos.
Por exemplo, converteMSet [('b',2), ('a',4), ('c',1)] corresponde a "bbaaaac". -}

converteMSet' :: [(a,Int)] -> [a]
converteMSet' [] = []
converteMSet' ((x,n):t) = replicate n x ++ converteMSet' t

{- 39. Defina a função insereMSet :: Eq a => a -> [(a,Int)] -> [(a,Int)] que acrescenta
um elemento a um multi-conjunto.
Por exemplo, insereMSet 'c' [('b',2), ('a',4), ('c',1)] corresponde a [('b',2),
('a',4), ('c',2)]. -}

insereMSet' :: Eq a => a -> [(a,Int)] -> [(a,Int)]
insereMSet' x [] = [(x,1)]
insereMSet' x ((y,ys):t) = if x == y then (y,ys+1):t else (y,ys) : insereMSet' x t

{- 40. Defina a função removeMSet :: Eq a => a -> [(a,Int)] -> [(a,Int)] que remove um
elemento a um multi-conjunto. Se o elemento não existir, deve ser retornado o multi-conjunto
recebido.
Por exemplo, removeMSet 'c' [('b',2), ('a',4), ('c',1)] corresponde a [('b',2),
('a',4)]. -}

removeMSet' :: Eq a => a -> [(a,Int)] -> [(a,Int)]
removeMSet' x [] = []
removeMSet' x ((y,ys):t) = if x == y then t else (y,ys) : removeMSet' x t

{- 41. Defina a função constroiMSet :: Ord a => [a] -> [(a,Int)] dada uma lista ordenada
por ordem crescente, calcula o multi-conjunto dos seus elementos.
Por exemplo, constroiMSet "aaabccc" corresponde a [('a',3), ('b',1), ('c',3)]. -}

constroiMSet' :: Ord a => [a] -> [(a,Int)]
constroiMSet' [] = []
constroiMSet' (h:t) = insereMSet' h (constroiMSet' t)

{- 42. Apresente uma definição recursiva da função pré-definida partitionEithers :: [Either
a b] -> ([a],[b]) que divide uma lista de Eithers em duas listas. -}

partitionEithers' :: [Either a b] -> ([a],[b])
partitionEithers' l = (left l, right l)
                      where left [] = []
                            left (Left x:xs) = x:left xs
                            left (Right x:xs) = left xs 
                            right [] = []
                            right(Left x:xs) = right xs
                            right (Right x:xs)= x: right xs

{- 43. Apresente uma definição recursiva da função pré-definida catMaybes :: [Maybe a] -> [a]
que colecciona os elementos do tipo a de uma lista. -}

catMaybes' :: [Maybe a] -> [a]
catMaybes' [] = []
catMaybes' (h:t) = case h of Nothing -> catMaybes' t
                             Just x -> x: catMaybes' t

--44. Considere o seguinte tipo para representar movimentos de um robot.

data Movimento = Norte | Sul | Este | Oeste deriving Show

{- Defina a função posicao :: (Int,Int) -> [Movimento] -> (Int,Int) que, dada uma
posição inicial (coordenadas) e uma lista de movimentos, calcula a posição final do robot
depois de efectuar essa sequência de movimentos. -}

posicao :: (Int,Int) -> [Movimento] -> (Int,Int)
posicao i [] = i
posicao (x, y) (m:ms) = posicao (case m of Norte -> (x, y + 1)
                                           Sul -> (x, y - 1)
                                           Este -> (x + 1, y)
                                           Oeste -> (x - 1, y)) ms

{- 45. Defina a função caminho :: (Int,Int) -> (Int,Int) -> [Movimento] que, dadas as posições
inicial e final (coordenadas) do robot, produz uma lista de movimentos suficientes para que o
robot passe de uma posição para a outra. -}

caminho :: (Int,Int) -> (Int,Int) -> [Movimento]
caminho (xi,yi) (xf,yf) | xi > xf = Oeste : caminho (xi-1,yi) (xf,yf)
                        | xi < xf = Este : caminho (xi+1,yi) (xf,yf)
                        | yi > yf = Sul : caminho (xi,yi-1) (xf,yf)
                        | yi < yf = Norte : caminho (xi,yi+1) (xf,yf)
                        | otherwise = []

{- 46. Defina a função vertical :: [Movimento] -> Bool que, testa se uma lista de movimentos
só é composta por movimentos verticais (Norte ou Sul). -}

vertical :: [Movimento] -> Bool
vertical [] = True
vertical (h:t) = case h of Norte -> vertical t
                           Sul -> vertical t
                           _ -> False


--47. Considere o seguinte tipo para representar a posição de um robot numa grelha.

data Posicao = Pos Int Int deriving Show

{- Defina a função maisCentral :: [Posicao] -> Posicao que, dada uma lista não vazia de
posições, determina a que está mais perto da origem (note que as coordenadas de cada ponto
são números inteiros). -}

maisCentral :: [Posicao] -> Posicao
maisCentral [Pos x y] = Pos x y
maisCentral ((Pos x y):(Pos a b):ps) = if (x^2 + y^2) < (a^2 + b^2) then maisCentral (Pos x y : ps) else maisCentral (Pos a b : ps)

{- 48. Defina a função vizinhos :: Posicao -> [Posicao] -> [Posicao] que, dada uma posição
e uma lista de posições, selecciona da lista as posições adjacentes à posição dada. -}

vizinhos :: Posicao -> [Posicao] -> [Posicao]
vizinhos (Pos x1 y1) = filter (\(Pos x2 y2) -> abs (x2-x1) + abs (y2-y1) == 1)

{- 49. Defina a função mesmaOrdenada :: [Posicao] -> Bool que testa se todas as posições de
uma dada lista têm a mesma ordenada. -}

mesmaOrdenada :: [Posicao] -> Bool
mesmaOrdenada [] =  True
mesmaOrdenada (Pos x y : t) = all ((==) y . (\(Pos x2 y2) -> y2) ) t

mesmaOrdenada' :: [Posicao] -> Bool
mesmaOrdenada' [] = True
mesmaOrdenada' [Pos _ _] = True
mesmaOrdenada' ((Pos _ y):(Pos x2 y2):ps) = y == y2 && mesmaOrdenada' (Pos x2 y2 : ps)

--50. Considere o seguinte tipo para representar o estado de um semáforo.

data Semaforo = Verde | Amarelo | Vermelho deriving Show

{- Defina a função interseccaoOK :: [Semaforo] -> Bool que testa se o estado dos semáforos
de um cruzamento é seguro, i.e., não há mais do que um semáforo não vermelho. -}

interseccaoOK :: [Semaforo] -> Bool
interseccaoOK l = aux l <= 1
                  where aux [] = 0
                        aux (x:xs) = case x of
                                     Vermelho -> 0 + aux xs
                                     _ -> 1 + aux xs        
