# Questões
[50 questoes from site of the professora Sofia](https://pf.sofiars.xyz/50q/)

1. Apresente uma definição recursiva da função (pré-definida) `enumFromTo :: Int -> Int -> [Int]` que constrói a lista dos números inteiros comprendidos entre dois limites.
Por exemplo, `enumFromTo 1 5` corresponde à lista `[1, 2, 3, 4, 5]`

```haskell title:"enumFromTo recursive"
enumFromTo' :: Int -> Int -> [Int]
enumFromTo' a b | a > b     = []
                | otherwise = a : enumFromTo' (a+1) b
```

```haskell title:"enumFromTo not recursive"
enumFromTo' :: Int -> Int -> [Int] 
enumFromTo' a b | a <= b = [a..b]
                | otherwise = [a, a-1..b]
```

2. Apresente uma definição recursiva da função (pré-definida) `enumFromThenTo :: Int -> Int -> Int -> [Int]` que constrói a lista dos números inteiros compreendidos entre dois limites e espaçados de um valor constante.
Por exemplo, `enumFromThenTo 1 3 10` corresponde à lista `[1, 3, 5, 7, 9]`

```haskell title:"enumFromThenTo"
enumFromThenTo' :: Int -> Int -> Int -> [Int]
enumFromThenTo' x y z = [x, x+(y-x)..z] 
```

3. Apresente uma definição recursiva da função (pré-definida) `(++) :: [a] -> [a] -> [a]` que concatena duas listas.
Por exemplo, `(++) [1, 2, 3] [10, 20, 30]` corresponde à lista `[1, 2, 3, 4, 10, 20, 30]`.

```haskell title:"(++)"
maisMais :: [a] -> [a] -> [a] 
maisMais [] l = l 
maisMais (h:t) (x:xs) = h : maisMais t (x:xs)
```

4. Apresente uma definição recursiva da função (pré-definida) `(!!) :: [a] -> Int -> a` que dada uma lista e um inteiro, calcula o elemento da lista que se encontra nessa posição (assume-se que o primeiro elemento se encontra na posição 0).
Por exemplo, `(!!) [10, 20, 30] 1` corresponde a 20.
Ignore os casos em que a função não se encontra definida (i.e., em que a posição fornecida não corresponde a nenhuma posição válida da lista).

```haskell title:"(!!)"
bangBang :: [a] -> Int -> a
bangBang (h:t) n 
    | n <= 0 = h 
    | otherwise = bangBang t (n-1) 
```

5. Apresente uma definição recursiva da função (pré-definida) `reverse :: [a] -> [a]` que dada uma lista calcula uma lista com os elementos dessa lista pela ordem inversa.
Por exemplo, `reverse [10, 20, 30]` corresponde a `[30, 20, 10]`.

```haskell title:"reverse"
reverse' :: [a] -> [a] 
reverse' [] = [] 
reverse' (h:t) = reverse' t ++ [h] 
```

6. Apresente uma definição recursiva da função (pré-definida) `take :: Int -> [a] -> [a]` que dado um inteiro `n` e uma lista `l` calcula a lista com os (no máximo) `n` primeiros elementos de `l`.
A lista resultado só terá menos de que `n` elementos se a lista `l` tiver menos do que `n` elementos. Nesse caso a lista calculada é igual à lista fornecida.
Por exemplo, `take 2 [10, 20, 30]` corresponde a `[10, 20]`

```haskell title:"Take"
take :: Int -> [a] -> [a]
take _ [] = []
take n _ 
	| n <= 0 = []
take n (h:t) = h . take (n - 1) t
```

7. Apresente uma definição recursiva da função (pré-definida) `drop :: Int -> [a] -> [a]` que dado um inteiro `n` e uma lista `l` calcula a lista se os (no máximo) `n` primeiros elementos de `l`. 
Se a lista fornecida não tiver `n` elementos ou menos, a lista resultante será vazia. 
Por exemplo, `drop 2 [10, 20, 30]` corresponde a `[30]`.

```haskell title:"Drop"
drop' :: Int -> [a] -> [a]
drop' n l | n <= 0 = l
drop' x [] = []
drop' x (h : t)
  | x == 1 = t
  | otherwise = drop' (x - 1) t
```

8. Apresente uma definição recursiva da função (pré-definida) `zip :: [a] -> [b] -> [(a, b)]` constói uma lista de pares a partir de duas listas. 
Por exemplo, `zip [1, 2, 3] [10, 20, 30, 40]` corresponde `[(1, 10), (2, 20), (3, 30)]`.

```haskell title:"Zip"
zip :: [a] -> [b] -> [(a, b)]
zip [] [] = []
zip [] _ = []
zip _ [] = []
zip (x:xs) (y:ys) = (x, y) : zip xs ys
```

9. Apresente uma definição recursiva da função (pré-definida) `replicate :: Int -> a -> [a]` que dado um inteiro `n` e um elemento `x` constói uma lista com `n` elementos, todos iguais a `x`.
Por exemplo, `replicate 3 10` corresponde a `[10, 10, 10]`.

```haskell title:"Replicate"
replicate :: Int -> a -> [a]
replicate n x
	| n <= 0 = []
	| otherwise = x : replicate (n - 1) x
```

10. Apresente uma definição recursiva da função (pré-definida) `intersperse :: a -> [a] -> [a]` que, dado um elemento e uma lista, constrói uma lista em que o elemento fornecido é intercalado entre os elementos da lista fornecida.

```haskell title:"Intersperce"
intersperce :: a -> [a] -> [a]
intersperce x [] = []
intersperce x [z] = [z]
intersperce x (h : t) = h : x : intersperce x t
```

11. Apresente uma definição recursiva da função (pré-definida) `group :: Eq a => [a] -> [[a]]` que agrupa elementos iguais e consecutivos de uma lista.
Exemplo

```ghci
> group [1,2,2,3,4,4,4,5,4]
[[1],[2,2],[3],[4,4,4],[5],[4]]
```

```haskell title:"Group"
group :: (Eq a) => [a] -> [[a]]
group [x] = [[x]]
group (h : t)
	| h `elem` (head gt) = (h : (head gt)) : tail gt
	| otherwise = [h] : gt
	where
		gt = group t
```

12. Apresente uma definição recursiva da função (pré-definida) `concat :: [[a]] -> [a]` que concatena as listas de uma lista.

```ghci
> concat [[1],[2,2],[3],[4,4,4],[5],[4]]
[1,2,2,3,4,4,4,5,4]
```

```haskell title:"Concat"
concat :: [[a]] -> [a]
concat [] = []
concat [[x]] = [x]
concat (h : xs) = h ++ concat xs
```

13. Apresente uma definição recursiva da função (pré-definida) `inits :: [a] -> [[a]]` que calcula a lista dos prefixos de uma lista.

```ghci
> inits [11,21,13]
[[],[11],[11,21],[11,21,13]]
```

```haskell title:"Tails"
inits :: [a] -> [[a]]
inits [] = [[]]
inits l@(h : t) = l : xs
	where 
		xs = inits t
```

14. Apresente uma definição recursiva da função (pré-definida) `tails :: [a] -> [[a]]` que calcula a lista dos sufixos de uma lista.

```ghci
> tails [1,2,3]
[[1,2,3],[2,3],[3],[]]
```

15. Defina a função `heads :: [[a]] -> [a]` que recebe uma lista de listas e produz a lista com o primeiro elemento de cada lista.

```ghci
> heads [[2,3,4],[1,7],[],[8,5,3]]
[2,1,8]
```

```haskell title:"Heads"
heads :: [[a]] -> [a]
heads [[]] = []
heads (h : t)
	| null h = heads t
	| otherwise = head h : heads t
```

16. Defina a função `total :: [[a]] -> Int` que recebe uma lista de listas e conta o total de elementos (de todas as listas).

```ghci
> total [[2,3,4],[1,7],[],[8,5,3]]
8
```

```haskell title:"Total"
total :: [[a]] -> Int
total [] = 0
total (h : t) =
  let total1 :: [a] -> Int
      total1 [] = 0
      total1 [x] = 1
      total1 (h : t) = 1 + total1 t
   in total1 h + total t
```

17. Defina a função `fun :: [(a,b,c)] -> [(a,c)]` que recebe uma lista de triplos e produz a lista de pares com o primeiro e o terceiro elemento de cada triplo.

```ghci title:Exemplo
> fun [("rui",3,2), ("maria",5,2), ("ana",43,7)]
[("rui",2), ("maria",2), ("ana",7)]
```

```haskell title:"Fun"
fun :: [(a, b, c)] -> [(a, c)]
fun [] = []
fun ((x, y, z) : t) = (x, z) : fun t
```

18. Defina a função `cola :: [(String,b,c)] -> String` que recebe uma lista de triplos e concatena as strings que estão na primeira componente dos triplos.

```ghci 
> cola [("rui",3,2), ("maria",5,2), ("ana",43,7)]
"ruimariaana"
```

```haskell title:"Cola"
cola :: [(String, b, c)] -> String
cola l = concat $ map (\(string, _, _) -> string) l
```

19. Defina a função `idade :: Int -> Int -> [(String,Int)] -> [String]` que recebe o ano, a idade e uma lista de pares com o nome e o ano de nascimento de cada pessoa, e devolve a listas de nomes das pessoas que nesse ano atingirão ou já ultrapassaram a idade indicada.

```ghci title:"Idade"
> idade 2021 26 [("rui",1995), ("maria",2009), ("ana",1947)]
["rui","ana"]
```

```haskell title:"Idade"
idade :: Int -> Int -> [(String, Int)] -> [String]
idade _ _ [] = []
idade ano edad lista = [nome | (nome, nasc) <- lista, ano - nasc >= edad]
```

20. Apresente uma definição recursiva da função `powerEnumFrom :: Int -> Int -> [Int]` que dado um valor `n` e um valor `m` constrói a lista `[n^0,…,n^(m−1)]`.

```ghci title:"Exemplo"
> powerEnumFrom 2 10
[1,2,4,8,16,32,64,128,256,512]
```

```haskell title:"Power enum from"
powerEnumFrom :: Int -> Int -> [Int]
powerEnumFrom n m = aux 0
  where
    aux k
      | k >= m = []
      | otherwise = n ^ k : aux (k + 1)
```

21. Apresente uma definição recursiva da função `isPrime :: Int -> Bool` que dado um número inteiro maior ou igual a 2 determina se esse número é primo. Para determinar se um número `n` é primo, descubra se existe algum número inteiro `m` tal que $2 ≤ m ≤ √n e mod n m = 0$. Se um tal número não existir então `n` é primo, e se existir então `n` não é primo.

```ghci title:"Exemplo"
> isPrime 7
True
> isPrime 21
False
```

```haskell title:"Is prime?"
isPrime :: Int -> Bool
isPrime x =
  let prime n = [m | m <- [2 .. (n - 1)], m * m > n, mod n m == 0]
   in (null $ prime x) && (x > 1)
```

22. Apresente uma definição recursiva da função (pré-definida) `isPrefixOf :: Eq a => [a] -> [a] -> Bool` que testa se uma lista é prefixo de outra.

```ghci title:"Exemplo"
> isPrefixOf [10,20] [10,20,30]
True
> isPrefixOf [10,30] [10,20,30]
False
```

```haskell title:"Is prefix of?"
isPrefixOf1 :: (Eq a) => [a] -> [a] -> Bool
isPrefixOf1 lista1 lista2 = lista1 == lista3
  where
    lista3 = take (length lista1) lista2
```

```haskell title:"alternativa"
isPrefixOf :: (Eq a) => [a] -> [a] -> Bool
isPrefixOf [] _ = True
isPrefixOf _ [] = False
isPrefixOf (h : t) (x : xs) = if h == x then isPrefixOf t xs else False
```

23. Apresente uma definição recursiva da função (pré-definida) `isSuffixOf :: Eq a => [a] -> [a] -> Bool` que testa se uma lista é sufixo de outra.

```ghci title:"Exemplo"
> isSuffixOf [20,30] [10,20,30]
True
> isSuffixOf [10,30] [10,20,30]
False
```

```haskell title:"Is suffix of?"
isSuffixOf :: (Eq a) => [a] -> [a] -> Bool
isSuffixOf lista1 lista2 = isPrefixOf (reverse lista1) (reverse lista2)
```

24. Apresente uma definição recursiva da função (pré-definida) `isSubsequenceOf :: Eq a => [a] -> [a] -> Bool` que testa se os elementos de uma lista ocorrem noutra pela mesma ordem relativa.

```ghci title:Exemplo
> isSubsequenceOf [20,40] [10,20,30,40]
True
> isSubsequenceOf [40,20] [10,20,30,40]
False
```

```haskell title:"Is subsequence of?"
isSubsequenceOf :: (Eq a) => [a] -> [a] -> Bool
isSubsequenceOf [] _ = True
isSubsequenceOf _ [] = False
isSubsequenceOf lista@(x : xs) (y : ys)
  | x == y = isSubsequenceOf xs ys
  | otherwise = isSubsequenceOf lista ys
```

25. Apresente uma definição recursiva da função (pré-definida) `elemIndices :: Eq a => a -> [a] -> [Int]` que calcula a lista de posições em que um dado elemento ocorre numa lista.

```ghci title;Exemplo
> elemIndices 3 [1,2,3,4,3,2,3,4,5]
[2,4,6]
```

```haskell title:"Elem indices"
elemIndices :: (Eq a) => a -> [a] -> [Int]
elemIndices _ [] = []
elemIndices x lista = aux 0 lista
  where
    aux :: Int -> [a] -> [Int]
    aux _ [] = []
    aux i (y : ys) = if x == y then i : aux (i + 1) ys else aux (i + 1) ys
```

26. Apresente uma definição recursiva da função (pré-definida) `nub :: Eq a => [a] -> [a]` que calcula uma lista com os mesmos elementos da recebida, sem repetições.

```ghci title:"Exemplo"
> nub [1,2,1,2,3,1,2]
[1,2,3]
```

```haskell title:"nub"
nub :: (Eq a) => [a] -> [a]
nub [] = []
nub (h : t) = h : nub (filter (/= h) t)
```

27. Apresente uma definição recursiva da função (pré-definida) `delete :: Eq a => a -> [a] -> [a]` que retorna a lista resultante de remover (a primeira ocorrência de) um dado elemento de uma lista.

```ghci title:Exemplo
> delete 2 [1,2,1,2,3,1,2]
[1,1,2,3,1,2]
> delete 4 [1,3,2,1,3,5]
[1,3,2,1,3,5]
```

```haskell title:"delete"
delete :: (Eq a) => a -> [a] -> [a]
delete _ [] = []
delete x (h : t)
  | x == h = t
  | otherwise = h : delete x t
```

28. Apresente uma definição recursiva da função (pré-definida) `(\) :: Eq a => [a] -> [a] -> [a]` que retorna a lista resultante de remover (as primeiras ocorrências) dos elementos da segunda lista da primeira.

```ghci title:"\\"
> (\\) [1,2,3,4,5,1] [1,5]
[2,3,4,1]
```

```haskell title:"\\"
(\\) :: (Eq a) => [a] -> [a] -> [a]
(\\) lista [] = lista
(\\) [] _ = []
(\\) lista (h : t) = (\\) (delete h lista) t
```

29. Apresente uma definição recursiva da função (pré-definida) `union :: Eq a => [a] -> [a] -> [a]` que retorna a lista resultante de acrescentar à primeira lista os elementos da segunda que não ocorrem na primeira.

```ghci title:Exemplo
> union [1,1,2,3,4] [1,5]
[1,1,2,3,4,5]
```

```haskell title:Union
union :: (Eq a) => [a] -> [a] -> [a]
union [] lista = lista
union lista [] = lista
union (h : t) ys = h : union t (delete h ys)
```

30. Apresente uma definição recursiva da função (pré-definida) `intersect :: Eq a => [a] -> [a] -> [a]` que retorna a lista resultante de remover da primeira lista os elementos que não pertencem à segunda.

```ghci title:Exemplo
> intersect [1,1,2,3,4] [1,3,5]
[1,1,3]
```

```haskell title:Intersect
intersect :: (Eq a) => [a] -> [a] -> [a]
intersect [] _ = []
intersect _ [] = []
intersect (h : t) lista
  | h `elem` lista = h : intersect t lista
  | otherwise = intersect t lista
```

31. Apresente uma definição recursiva da função (pré-definida) `insert :: Ord a => a -> [a] -> [a]` que dado um elemento e uma lista ordenada retorna a lista resultante de inserir ordenadamente esse elemento na lista.

```ghci title:Exemplo
> insert 25 [1,20,30,40]
[1,20,25,30,40]
```

```haskell title:Insert
insert :: (Ord a) => a -> [a] -> [a]
insert x [] = [x]
insert x lista@(h : t)
  | x == h = lista
  | x < h = x : lista
  | otherwise = h : insert x t
```

32. Apresente uma definição recursiva da função (pré-definida) `unwords :: [String] -> String` que junta todas as strings da lista numa só, separando-as por um espaço.

```ghci title:Exemplo
> unwords ["Programacao", "Funcional"]
"Programacao Funcional"
```

```haskell title:Unwords
unwords :: [String] -> String
unwords [] = []
unwords [x] = x
unwords (h : t) = h ++ " " ++ unwords t
```

33. Apresente uma definição recursiva da função (pré-definida) `unlines :: [String] -> String` que junta todas as strings da lista numa só, separando-as pelo caracter ’ ’.

```ghci title:Exemplo
> unlines ["Prog", "Func"]
"Prog\nFunc\n"
```

```haskell title:Unlines
unlines :: [String] -> String
unlines [] = []
unlines (h : t) = h ++ "\n" ++ unlines t
```

34. Apresente uma definição recursiva da função `pMaior :: Ord a => [a] -> Int` que dada uma lista não vazia, retorna a posição onde se encontra o maior elemento da lista. As posições da lista começam em 0, i.e., a função deverá retornar 0 se o primeiro elemento da lista for o maior.

```ghci title:Exemplo
> pMaior [2,6,3,1,5,4]
1
> pMaior [30,10,20,40,0]
3
```

```haskell title:Pmaior
pMaior :: (Ord a) => [a] -> Int
pMaior [x] = 0
pMaior l@(h : t) = aux 0 (0, h) l
  where
    aux _ (pos, _) [] = pos
    aux i (pos, max) (x : xs)
      | x > max = aux (i + 1) (i, x) xs
      | otherwise = aux (i + 1) (pos, max) xs
```

35. Apresente uma definição recursiva da função (pré-definida) `lookup :: Eq a => a -> [(a,b)] -> Maybe b` que retorna uma lista construída a partir de elementos de uma lista (o segundo argumento) atendendo a uma condição dada pelo primeiro argumento.

```ghci title:Exemplo
> lookup 'a' [('a',1),('b',4),('c',5)]
Just 1
```

```haskell title:Lookup
lookup :: (Eq a) => a -> [(a, b)] -> Maybe b
lookup _ [] = Nothing
lookup k ((a, b) : t) = if k == a then Just b else lookup k t
```

36. Defina a função `preCrescente :: Ord a => [a] -> [a]` que calcula o maior prefixo crescente de uma lista.

```ghci title:Exemplo
> preCrescente [3,7,9,6,10,22]
[3,7,9]
```

```haskell title:"Pre crescente"
preCrescente :: (Ord a) => [a] -> [a]
preCrescente [x] = [x]
preCrescente [] = []
preCrescente (h : x : t)
  | h < x = h : preCrescente (x : t)
  | otherwise = [h]
```

37. Apresente uma definição recursiva da função `iSort :: Ord a => [a] -> [a]` que calcula o resultado de ordenar uma lista. Assuma, se precisar, que existe definida a função `insert :: Ord a => a -> [a] -> [a]` que dado um elemento e uma lista ordenada retorna a lista resultante de inserir ordenadamente esse elemento na lista.

```ghci title:Exemplo
> iSort [3,1,2,5,4]
[1,2,3,4,5]
```

```haskell title:Isort
iSort :: (Ord a) => [a] -> [a]
iSort [] = []
iSort [x] = [x]
iSort (h : t) = insert h (iSort t)
```

38. Apresente uma definição recursiva da função `menor :: String -> String -> Bool` que dadas duas strings, retorna True se e só se a primeira for menor do que a segunda, segundo a ordem lexicográfica (i.e., do dicionário). 

```ghci title:menor
> menor "sai" "saiu"
True
> menor "programacao" "funcional"
False
```

```haskell title:Menor
menor :: String -> String -> Bool
menor [] [] = False
menor [] _ = True
menor _ [] = False
menor (h : t) (x : xs)
  | h < x = True
  | h == x = menor t xs
  | otherwise = False
```

39. Considere que se usa o tipo `[(a,Int)]` para representar multi-conjuntos de elementos de a. Considere ainda que nestas listas não há pares cuja primeira componente coincida, nem cuja segunda componente seja menor ou igual a zero.

Defina a função `elemMSet :: Eq a => a -> [(a,Int)] -> Bool` que testa se um elemento pertence a um multi-conjunto.

```ghci title:Exemplo
> elemMSet ’a’ [(’b’,2), (’a’,4), (’c’,1)]
True
> elemMSet ’d’ [(’b’,2), (’a’,4), (’c’,1)]
False
```

```haskell title:"Elem set"
elemMSet :: (Eq a) => a -> [(a, Int)] -> Bool
elemMSet _ [] = False
elemMSet x ((x1, _) : t) = if x == x1 then True else elemMSet x t
```

40. Considere que se usa o tipo `[(a,Int)]` para representar multi-conjuntos de elementos de a. Considere ainda que nestas listas não há pares cuja primeira componente coincida, nem cuja segunda componente seja menor ou igual a zero.

Defina a função `converteMSet :: [(a,Int)] -> [a]` que converte um multi-conjuto na lista dos seus elementos.

```ghci title:Exemplo 
> converteMSet [(’b’,2), (’a’,4), (’c’,1)]
"bbaaaac"
```

```haskell title:"Converte Mset"
converteMSet :: [(a, Int)] -> [a]
converteMSet [] = []
converteMSet ((x, n) : t) = (replicate' n x) ++ converteMSet t
```

41. Considere que se usa o tipo `[(a,Int)]` para representar multi-conjuntos de elementos de a. Considere ainda que nestas listas não há pares cuja primeira componente coincida, nem cuja segunda componente seja menor ou igual a zero.

Defina a função `insereMSet :: Eq a => a -> [(a,Int)] -> [(a,Int)]` que acrescenta um elemento a um multi-conjunto.

```ghci title:Exemplo
> insereMSet ’c’ [(’b’,2), (’a’,4), (’c’,1)]
[(’b’,2),(’a’,4), (’c’,2)]
```

```haskell title:"Insere M set"
insereMSet :: (Eq a) => a -> [(a, Int)] -> [(a, Int)]
insereMSet x [] = [(x, 1)]
insereMSet a ((x, n) : t) = if a == x then (x, n + 1) : t else (x, n) : insereMSet a t
```

42. Considere que se usa o tipo `[(a,Int)]` para representar multi-conjuntos de elementos de a. Considere ainda que nestas listas não há pares cuja primeira componente coincida, nem cuja segunda componente seja menor ou igual a zero.

Defina a função `removeMSet :: Eq a => a -> [(a,Int)] -> [(a,Int)]` que remove um elemento a um multi-conjunto. Se o elemento não existir, deve ser retornado o multi-conjunto recebido. 

```ghci title:Exemplo
> removeMSet ’c’ [(’b’,2), (’a’,4), (’c’,1)]
[(’b’,2),(’a’,4)]
```

```haskell title:"Remove M set"
removeMSet :: (Eq a) => a -> [(a, Int)] -> [(a, Int)]
removeMSet _ [] = []
removeMSet obj ((x, n) : t)
  | n > 1 = if obj == x then (x, n - 1) : t else (x, n) : removeMSet obj t
  | otherwise = if obj == x then t else (x, n) : removeMSet obj t
```

43. Considere que se usa o tipo `[(a,Int)]` para representar multi-conjuntos de elementos de a. Considere ainda que nestas listas não há pares cuja primeira componente coincida, nem cuja segunda componente seja menor ou igual a zero.

Defina a função `constroiMSet :: Ord a => [a] -> [(a,Int)]` que, dada uma lista ordenada por ordem crescente, calcula o multi-conjunto dos seus elementos.

```ghci title:Exemplo
> constroiMSet "aaabccc"
[(’a’,3), (’b’,1), (’c’,3)]
```

```haskell title:"Constroi M set"
constroiMSet :: (Ord a) => [a] -> [(a, Int)]
constroiMSet [] = []
constroiMSet (h : t) = insereMSet (h) (constroiMSet t)
```

44. Apresente uma definição recursiva da função pré-definida `partitionEithers :: [Either a b] -> ([a],[b])` que divide uma lista de Either em duas listas.

```ghci title:Exemplo
> partitionEithers [Left 1, Right 2, Left 3, Right 4, Left 5]
([1,3,5],[2,4])
```

```haskell title:"Partition eithers"
partitionEithers :: [Either a b] -> ([a], [b])
partitionEithers [] = ([], [])
partitionEithers ((Left x) : t) = (x : a, b)
  where
    (a, b) = partitionEithers t
partitionEithers ((Right x) : t) = (a, x : b)
  where
    (a, b) = partitionEithers t
```

45. Apresente uma definição recursiva da função pré-definida `catMaybes :: [Maybe a] -> [a]` que coleciona os elementos do tipo a de uma lista.

```ghci title:Exemplo
> catMaybes [Just 1, Just 2, Nothing, Just 3, Nothing, Just 4, Just 5, Nothing]
[1,2,3,4,5]
```

```haskell title:"Cat maybes"
catMaybes :: [Maybe a] -> [a]
catMaybes [] = []
catMaybes (h : t) =
  case h of
    Just x -> x : catMaybes t
    Nothing -> catMaybes t
```

46. Considere o seguinte tipo para representar movimentos de um robot.

`data Movimento = Norte | Sul | Este | Oeste deriving Show`

Defina a função `caminho :: (Int,Int) -> (Int,Int) -> [Movimento]` que, dadas as posições inicial e final (coordenadas) do robot, produz uma lista de movimentos suficientes para que o robot passe de uma posição para a outra.

```ghci title:Exemplo
> caminho (0,0) (3,4)
[Este,Este,Este,Norte,Norte,Norte,Norte]
```

```haskell title:Caminho
caminho :: (Int, Int) -> (Int, Int) -> [Movimento]
caminho (xi, yi) (xf, yf)
  | xi < xf = Este : caminho (xi + 1, yi) (xf, yf)
  | xi > xf = Oeste : caminho (xi - 1, yi) (xf, yf)
  | yi < yf = Norte : caminho (xi, yi + 1) (xf, yf)
  | yi > yf = Sul : caminho (xi, yi - 1) (xf, yf)
  | otherwise = []
```

47. Considere o seguinte tipo para representar movimentos de um robot.

`data Movimento = Norte | Sul | Este | Oeste deriving Show`

Defina a função `hasLoops :: (Int,Int) -> [Movimento] -> Bool` que, dada uma posição inicial e uma lista de movimentos (correspondentes a um percurso), verifica se o robot alguma vez volta a passar pela posição inicial ao longo do percurso correspondente. Pode usar a função `posicao` definida acima.

```ghci title:Exemplo
> hasLoops (0,0) [Norte, Norte, Este, Sul, Oeste, Sul, Este, Norte, Este]
True
> hasLoops (2,1) [Sul, Este, Sul, Oeste, Norte, Este, Sul]
False
```

```haskell title:"Has loops?"
hasLoops :: (Int, Int) -> [Movimento] -> Bool
hasLoops inicio movimientos = aux [inicio] inicio movimientos
  where
    aux _ _ [] = False
    aux visitados (x, y) (m : ms) =
      let proxima = case m of
            Norte -> (x, y + 1)
            Sul -> (x, y - 1)
            Este -> (x + 1, y)
            Oeste -> (x - 1, y)
       in if proxima `elem` visitados then True else aux (proxima : visitados) proxima ms
```

48. Considere os seguintes tipos para representar pontos e retângulos, respectivamente. Assuma que os retângulos têm os lados paralelos aos eixos e são representados apenas por dois dos pontos mais afastados.

`type Ponto = (Float,Float) data Rectangulo = Rect Ponto Ponto`

Defina a função `contaQuadrados :: [Rectangulo] -> Int` que, dada uma lista com retângulos, conta quantos deles são quadrados.

```ghci title:Exemplo
> contaQuadrados [Rect (0,0) (2,2), Rect (1,3) (7,4), Rect (5,2) (8,5), Rect (1,2) (2,4)]
2
```

```haskell title:"Conta quadrados"
contaQuadrados :: [Rectangulo] -> Int
contaQuadrados [] = 0
contaQuadrados ((Rect (x, y) (a, b)) : t)
  | abs (x - a) == abs (y - b) = 1 + contaQuadrados t
  | otherwise = contaQuadrados t
```

49. Considere os seguintes tipos para representar pontos e retângulos, respectivamente. Assuma que os retângulos têm os lados paralelos aos eixos e são representados apenas por dois dos pontos mais afastados.

`type Ponto = (Float,Float) data Rectangulo = Rect Ponto Ponto`

Defina a função `areaTotal :: [Rectangulo] -> Float` que, dada uma lista com retângulos, determina a área total que eles ocupam.

```ghci title:Exemplo
> areaTotal [Rect (0,0) (2,2), Rect (1,3) (7,4), Rect (5,2) (8,5), Rect (1,2) (2,4)]
21.0
```

```haskell title:"Area total"
areaTotal :: [Rectangulo] -> Float
areaTotal lista = sum (map (\(Rect (x, y) (z, w)) -> abs (x - z) * abs (y - w)) lista)
```

50. Considere o seguinte tipo para representar o estado de um equipamento.

`data Equipamento = Bom | Razoavel | Avariado deriving Show`

Defina a função `naoReparar :: [Equipamento] -> Int` que determina a quantidade de equipamentos que não estão avariados

```ghci title:Exemplo
> naoReparar [Bom, Avariado, Bom, Razoavel, Avariado]
3
```

```haskell title:"Não reparar"
naoReparar :: [Equipamento] -> Int
naoReparar [] = 0
naoReparar (h : t) =
  case h of
    Avariado -> naoReparar t
    _ -> 1 + naoReparar t
```
