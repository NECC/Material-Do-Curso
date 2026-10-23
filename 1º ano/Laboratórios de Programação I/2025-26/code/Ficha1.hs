module Ficha1 where 

-- a) 
par :: [Integer] -> (Integer, Integer)   
par xs = (head xs, last xs)

-- b)
nomes :: [String] -> (String, String)  
nomes ys = (head ys, last ys)

-- c)
nomes2 :: [String] -> String 
nomes2 [] = [] 
nomes2 nm = head nm ++ (" " ++ last nm )    

-- c)
nomes2' :: [String] -> String 
nomes2' [] = [] 
nomes2' l = head l ++ (' ' : last l)

-- d)
apelido :: [String] -> Int  
apelido [] = 0 
apelido ws = length (last ws)  

-- e) 
valorLogico :: Char -> String -> Bool 
valorLogico c s = elem c s  

-- g) 
type Turma = [Int] 
juntaTurmas :: Turma -> Turma -> Turma 
juntaTurmas t1 t2 = t1 ++ t2
numeroAlunosresultante :: Turma -> Turma -> Int 
numeroAlunosresultante t1 t2 = length (juntaTurmas t1 t2) 
dif :: Turma -> Turma -> Int 
dif t1 t2 = if length t1 > length t2 then length t1 - length t2 
    else length t2 - length t1
verifica :: Turma -> Int -> String
verifica t n 
  | elem n t = "Sim"
  | otherwise = "Nao" 



-- f)
listaPar :: [a] -> [a] 
listaPar l =  if (mod (length l) 2 == 0) then tail l 
    else init l 

-- h) 
menorLista :: [a] -> [a] -> [a] 
menorLista xs ys = if (length xs) < (length ys) then xs else ys 

maiorLista :: [a] -> [a] -> [a]
maiorLista xs ys = if (length xs) > (length ys) then xs else ys

ex8 :: [Int] -> [Int] -> [Int] 
ex8 xs ys = as ++ bs 
    where as = menorLista xs ys 
          bs = maiorLista xs ys 

-- i) 
ex9 :: [Int] -> [Int] -> [Int]
ex9 xs ys 
    | head xs < head ys = xs ++ ys 
    | otherwise  = ys ++ xs 

-- j) 
ex10 :: [a] -> [a] -> (a, [a]) 
ex10 xs [ys] = (head xs, [ys])

-- k) 
ex11 :: [String] -> String
ex11 (f:ln) = [head f] ++ "." ++ last ln 

-- l) 
ex12 :: [(Int, Int)] -> Int 
ex12 [] = 0 
ex12 l = snd (head l)

-- m) 
ex13 :: [(Int, Int)] -> Int
ex13 [] = 0
ex13 l = fst (last l) + snd (last l) 

-- n) 
ex14 :: (String, Int) -> (String, Int) -> String
ex14 (n1, i1) (n2, i2)
    | i1 > i2 = n2 
    | otherwise = n1 

--o)
ex15 :: (Int, Int) -> Int -> (Int, Int) 
ex15 (x, y) lado = (x + lado, y - lado)

--p) 
ex16 :: ((Int, Int), Int) -> ((Int, Int), Int) -> Int 
ex16 ((x, y), l1) ((x1, y1), l2)  
    | y > y1 = l1 * l1 
    | y < y1 = l2 * l2 
    | otherwise = if l1 * l1 > l2 * l2 then l2 * l2 else l1 * l1 
