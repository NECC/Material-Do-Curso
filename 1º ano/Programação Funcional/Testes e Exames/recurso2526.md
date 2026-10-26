

1. Define a função `descomprime :: [(a, Int)] -> [a]` que replica cada elemento da lista de entrada 
o número de vezes especificado. Por exemplo `descomprime [('a', 2), ('b', 4)] == "aabbbb"`

```hs
descomprime :: [(a, Int)] -> [a]
descomprime [] = []
descomprime ((x, n):t) = replicate n x ++ descomprime t 
```

2. Defina `remove :: [a] -> Int -> [a]` que remove o elemento da lista que se encontra na
posição especificada. Por exemplo, `remove [10, 20, 30, 40] 2 == [10, 20, 40]`

```hs
remove :: [a] -> Int -> [a] 
remove [] _ = []
remove (h:t) 0 = t
remove (h:t) x = h : remove t (x - 1)

```

3. Defina a função `diferentes :: Eq a => [a] -> Bool` que testa se todos os elementos de uma lista são diferentes entre sí.

```hs
diferentes :: Eq a => [a] -> Bool 
diferentes [] = True 
diferentes (x:t) = not (x `elem` t) && diferentes t 
```

4. Pretendemos calcular a frequência com que cada elemento aparece numa lista, e apresentar essa 
informação graficamente.

a) Defina a função `freq :: (Eq a) => [a] -> [(a, Int)]` que calcula o número de ocorrências 
de cada elemento na lista.

b) Defina a função `grafico :: String -> IO ()` que apresenta graficamente 
o número de ocorrências dos caracteres de uma string, de forma a que `grafico "babcbba"` 
se apresente da seguinte forma
(pode ser por outra ordem): 

a(2) **
b(4) ****
c(1) * 

```hs
freq :: (Eq a) => [a] -> [(a, Int)] 
freq [] = []
freq [x] = [(x, 1)]
freq (h:t) = aux h : freq (delete h t)
    where 
        aux p (x:xs) = if p == x then (p, 1 + aux p (xs)) else (p, 1)
        delete y (l:ls) = if y == l then ls else l : delete y ys 
```

5. Considere o tipo Exp a para representar expressões aritméticas e uma expressão aritmética de inteiros e1. 

```hs
data Exp a = 
    Const a 
    | Var String 
    | Add (Exp a) (Exp a)
    | Mul (Exp a) (Exp a)
```

```hs
e1 :: Exp Int 
e1 = Mul (Add (Const 3) (Var "x")) (Add (Var "y") (Const 1))
```

a) Declare o tipo Exp a como instância da classe `Show`, de forma a que as expressões sejam 
apresentadas em notação prefixa, como se apresenta a seguir. 
Por exemplo, `e1` será apresentada da seguinte forma: `((*) ((+) 3 x) ((+) y 1))` 

b) Defina o tipo e a função eval que dada uma expressão aritmética e uma valoração de cada 
váriavel que ocorre na expressão calcula o valor da expressão aritmética.
Por exemplo, `eval e1 [("x", 8), ("y", 4)] == 55` 

```hs
instance Show a => Show (Exp a) where
    Const a  show a 
    Var x = x
    Add x y = "((+)" ++ show x ++ " " ++ show y ++ ")"
    Mul x y = "((*)" ++ show x ++ " " ++ show y ++ ")"
```

```hs
eval :: Exp Int -> [(String, Int)] -> Int 
eval (Var x) ((y, z):t) = if x == y then z else eval (Var x) t
eval (Const x) _ = x
eval (Add x y) vars = eval x vars + eval y vars
eval (Mul x y) vars = eval x vars * eval y vars
```


6. Considere a seguinte definição de árvores generalizadas 
`LRTree` e uma árvore `lrt` que armazena números inteiros nas suas folhas 

```hs
data LRTree a = 
    Leaf a
    | Node [LRTree a]
    deriving (Show)
```

```hs
lrt :: LRTree Integer 
lrt = Node [Leaf 3, Node [Leaf 6, Node [Leaf 7]], Leaf 8, Node [Node [Leaf 12], Leaf 10]]
```

a) Defina a função `altura :: LRTree -> Int` que calcula a altura de uma árvore generalizada.
Por exemplo altura `lrt == 4` 

b) Considere a seguinte definição da função 

```hs
profundas :: LRTree a -> [a]
profundas t = folhasDeUmNivel t (altura t) 
```

que calcula as folhas mais profundas de uma árvore generalizada.
Por exemplo `profundas lrt == [7, 12]`
Escreva a função `folhasDeUmNivel` de modo a completar a função profundas 

```hs
altura :: LRTree a -> Int
altura (Leaf _) = 1 
altura (Node []) = 1
altura (Node tree) = 1 + maximum (map altura tree)
```


       
