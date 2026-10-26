# Ficha 5
1) Apresente definições das seguintes funções de ordem superior, já pré-definidas no Prelude ou no Data.List:
a) `any :: (a -> Bool) -> [a] -> Bool` que testa se um predicado é verdade para algum elemento de uma lista; por exemplo: `any odd [1..10] == True`.

```hs
any' :: (a -> Bool) -> [a] -> Bool
any' f [] = False
any' f (h:t) = f h && any' f t
```

b) `zipWith :: (a->b->c) -> [a] -> [b] -> [c]` que combina os elementos de duas listas usando uma função específica; por exemplo: `zipWith (+) [1,2,3,4,5] [10,20,30,40] == [11,22,33,44]`.

```hs
zipWith2 :: (a->b->c) -> [a] -> [b] -> [c]
zipWith2 _ [] _ = [] 
zipWith2 _ _ [] = [] 
zipWith2 f (h:t) (x:xs) = (f h x : (zipWith2 f t xs))
```

c) `takeWhile :: (a->Bool) -> [a] -> [a]` que determina os primeiros elementos da lista que satisfazem um dado predicado; por exemplo: `takeWhile odd [1,3,4,5,6,6] == [1,3]`.

```hs
takeWhile2 :: (a->Bool) -> [a] -> [a]
takeWhile2 f [] = [] 
takeWhile2 f (h:t) 
    | f h = h: takeWhile2 f t 
    | otherwise = takeWhile f t 

```

d) `dropWhile :: (a->Bool) -> [a] -> [a]` que elimina os primeiros elementos da lista que satisfazem um dado predicado; por exemplo: `dropWhile odd [1,3,4,5,6,6] == [4,5,6,6]`.

```hs
dropWhile2 :: (a->Bool) -> [a] -> [a]
dropWhile2 f [] = [] 
dropWhile2 f (h:t) 
    | f h = dropWhile2 f t 
    | otherwise = h : dropWhile f t 
```


e) `span :: (a-> Bool) -> [a] -> ([a],[a])` que calcula simultaneamente os dois resultados anteriores. Note que apesar de poder ser definida à custa das outras duas, usando a definição:

```hs
span p l = (takeWhile p l, dropWhile p l)
```

nessa definição há trabalho redundante que pode ser evitado. Apresente uma definição alternativa onde não haja duplicação de trabalho.

```hs
span' :: (a-> Bool) -> [a] -> ([a],[a])
span' _ [] = ([], [])
span' f (h:t) 
    |  f h = let (taken, dropped) = span' f t in (h:taken, dropped)
    | otherwise = ([], h:t) 
```

f) `deleteBy :: (a -> a -> Bool) -> a -> [a] -> [a]` que apaga o primeiro elemento de uma lista que é “igual” a um dado elemento de acordo com a função de comparação que é passada como parâmetro. Por exemplo: `deleteBy (\x y -> snd x == snd y) (1,2) [(3,3),(2,2),(4,2)] == [(3,3),(4,2)]`.

```hs
deleteBy :: (a -> a -> Bool) -> a -> [a] -> [a] 
deleteBy f _ [] = [] 
deleteBy f x (y:ys) 
    | f x y = ys 
    | otherwise = y:deleteBy f x ys  

```


-- g 
-- ex sortOn fst [(3,1),(1,2),(2,5)] == [(1,2),(2,5),(3,1)]
sortOn :: Ord b => (a -> b) -> [a] -> [a]
sortOn _ [] = []
sortOn _ [x] = [x] 
sortOn f (x:y:xs) 
    | f x < f y = x : (sortOn f (y:xs))
    | f x > f y = y : (sortOn f (x:xs)) 
    | otherwise = x : (sortOn f (y:xs)) 

-- 2 

-- selgrau da tarefa 2
selgrau :: Int -> Polinomio -> Polinomio
selgrau _ [] = []
selgrau n ((c,g):t)
    | n == g = (c,g) : selgrau n t
    | otherwise = selgrau n t

-- a 
selGrau :: Int -> Polinomio -> Polinomio 
selGrau n p = filter (\ x -> snd x == n) p

-- b 
conta :: Int -> Polinomio -> Int 
conta n p = length $ selGrau n p 

-- c 
grau :: Polinomio -> Int 
grau poli = maximum $ map snd poli 

-- d
derivada :: Polinomio -> Polinomio 
derivada poli = [(c * fromIntegral g, g - 1) | (c, g) <- poli, g /= 0]

-- e 
calcula :: Float -> Polinomio -> Float 
calcula x poli = foldl (\acc (c, g) -> acc + c * x ^ g) 0 poli  

-- f 
simp :: Polinomio -> Polinomio 
simp poli = filter (\(c, g) -> c /= 0) poli  

-- g 
mult :: Monomio -> Polinomio -> Polinomio 
mult (c1, g1) = map (\(c, g) -> (c * c1, g1 + g))  

-- h 
ordena :: Polinomio -> Polinomio 
ordena = sortOn snd 

-- i) 
normaliza :: Polinomio -> Polinomio 
normaliza poli = 
    let 
        adiciona :: Monomio -> Polinomio -> Polinomio 
        adiciona m [] = [m] 
        adiciona (c1, e1) ((c, e):t) 
            | e1 == e = (c1 + c, e) : t 
            | otherwise = (c, e) : adiciona (c1, e1) t 
    in foldl (\acc m -> adiciona m acc) [] poli 

-- j
soma :: Polinomio -> Polinomio -> Polinomio 
soma poli1 poli2 = foldl (\acc m -> adiciona m acc) poli1 poli2
    where 
        adiciona :: Monomio -> Polinomio -> Polinomio 
        adiciona m [] = [m]
        adiciona (cm, gm) ((c, g):t) = if gm == g then (cm+c,g) : t else (c,g) : adiciona (cm,gm) t
            
-- k 
produto :: Polinomio -> Polinomio -> Polinomio 
produto poli1 poli2 = foldl (\acc m -> soma (mult m poli2) acc) [] poli1 

-- l 
equiv :: Polinomio -> Polinomio -> Bool 
equiv poli1 poli2 = ordena (normaliza poli1) == ordena (normaliza poli2)

-- 3
{-

| 1 2 3 |
| 0 4 5 |
| 0 0 6 |

= [[1,2,3], [0,4,5], [0,0,6]]

-}

-- a
dimOk :: Mat a -> Bool 
dimOk [] = True 
dimOk (h:t) = length h == length t && dimOk t 

-- b 
dimMat :: Mat a -> (Int, Int) 
dimMatriz [] = (0, 0) 
dimMat matriz = (length matriz, length (head matriz))

-- c 
addMat :: Num a => Mat a -> Mat a -> Mat a 
addMat = zipWith (zipWith (+))

-- d 
transpose' :: Mat a -> Mat a 
transpose' [] = []
transpose' ([]: _) = []
transpose' matriz = (map head matriz) : transpose' (map tail matriz) 

-- e 
multMat :: Num a => Mat a -> Mat a -> Mat a 
multMat m1 m2 = [[dotProd linhaA colunaB | colunaB <- transpose' m2] | linhaA <- m1]
    where 
        dotProd v1 v2 = sum (zipWith (*) v1 v2)  

-- f 
zipMat :: (a -> b -> c) -> Mat a -> Mat b -> Mat c 
zipMat f m1 m2 = zipWith (zipWith f) m1 m2 

-- g 
triSup :: (Num a, Eq a) => Mat a -> Bool 
triSup matriz = all verificarFila (zip [0..] matriz) -- and (zipWith (\k fila -> all (==0) (take k fila)) [0..] mat)
  where
    verificarFila (k, fila) = all (==0) (take k fila)

-- h 
rotateleft :: Mat a -> Mat a 
rotateleft m = reverse (transpose m)

rotateRight :: Mat a -> Mat a 
rotateRight = map reverse . transpose 


