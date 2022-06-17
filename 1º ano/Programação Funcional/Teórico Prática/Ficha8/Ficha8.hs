module Ficha8 where

import Data.List
import Data.Char

--1. Considere o seguinte tipo de dados para representar frações

data Frac = F Integer Integer

{- (a) Defina a função normaliza :: Frac -> Frac, que dada uma fração calcula uma
fração equivalente, irredutível, e com o denominador positivo. Por exemplo,
normaliza (F (-33) (-51)) deve retornar F 11 17 e normaliza (F 50 (-5))
deve retornar F (-10) 1. Sugere-se que comece por definir primeiro a função
mdc :: Integer -> Integer -> Integer que calcula o máximo divisor comum
entre dois números, baseada na seguinte propriedade (atribuida a Euclides):
mdc x y == mdc (x+y) y == mdc x (y+x) -}

normaliza :: Frac -> Frac
normaliza (F 0 x) = F 0 1
normaliza (F x y) = let md = mdc (abs x) (abs y)
                        sinal = if x * y > 0 then 1 else (-1)
                    in  F (sinal * (div (abs x) md)) (div (abs y) md)


mdc :: Integer -> Integer -> Integer
mdc x y | x == y = x
        | x > y = mdc (x-y) y
        | x < y = mdc x (y-x)

--(b) Defina Frac como instância da classe Eq.

instance Eq Frac where
    (==) (F n1 n2) (F n3 n4) = n1*n2 == n3*n4 

--(c) Defina Frac como instância da classe Ord.

instance Ord Frac where
    compare (F n1 n2) (F n3 n4) | n1*n2 == n3*n4 = EQ
                                | n1*n2 < n3*n4 = LT
                                | n1*n2 > n3*n4 = GT

{- (d) Defina Frac como instância da classe Show, de forma a que cada fração seja
apresentada por (numerador/denominador). -}

instance Show Frac where
    show (F x 1) = show x
    show (F x y) = show x ++ "/" ++ show y

{- (e) Defina Frac como instância da classe Num. Relembre que a classe Num tem a
seguinte definição:

class (Eq a, Show a) => Num a where
(+), (*), (-) :: a -> a -> a
negate, abs, signum :: a -> a
fromInteger :: Integer -> a -}

instance Num Frac where
    (+) (F n1 n2) (F n3 n4) = normaliza (F ((n1*n4) + (n2*n3)) (n2*n4))
    (*) (F n1 n2) (F n3 n4) = normaliza (F (n1*n3) (n2*n4))
    (-) (F n1 n2) (F n3 n4) = normaliza (F ((n1*n4) - (n2*n3)) (n2*n4))
    negate (F n1 n2) =normaliza (F (-n1) n2)
    abs (F n1 n2) = F (abs n1) (abs n2)
    signum (F n1 n2) | n1 == 0 = F 0 1
                     | n1*n2 > 0 = F 1 1
                     | n1*n2 < 0 = F (-1) 1
    fromInteger n1 = F n1 1 

{- (f) Defina uma função que, dada uma fração f e uma lista de frações l, selecciona
de l os elementos que são maiores do que o dobro de f. -}

maisQdobros :: Frac -> [Frac] -> [Frac]
maisQdobros f l = filter (\j -> j > 2*f) l

{- 2. Relembre o tipo definido na Ficha 7 para representar expressões inteiras. Uma possível
generalização desse tipo de dados, será considerar expressões cujas constantes são de
um qualquer tipo numérico (i.e., da classe Num). -}

data Exp a = Const a | Simetrico (Exp a) | Mais (Exp a) (Exp a) | Menos (Exp a) (Exp a) | Mult (Exp a) (Exp a)

--Vou utilizar as funções da Ficha 7 a única coisa que tenho de mudar são os tipos para poderem encaixar neste problema.

calcula :: Num a => Exp a -> a
calcula (Const x) = x
calcula (Simetrico x) = - calcula x
calcula (Mais x y) = calcula x + calcula y
calcula (Menos x y) = calcula x - calcula y
calcula (Mult x y) = calcula x * calcula y

infixa :: Show a => Exp a -> String
infixa (Const x) = show x
infixa (Simetrico x) = '-' : '(' :  infixa x ++ ")"
infixa (Mais x y) = '(' : infixa x ++ " + " ++ infixa y ++ ")"
infixa (Menos x y) = '(' : infixa x ++ " - " ++ infixa y ++ ")"
infixa (Mult x y) = '(' : infixa x ++ " * " ++ infixa y ++ ")"

--(a) Declare Exp a como uma instância de Show.

instance Show a=>Show (Exp a) where
    show e = infixa e

--(b) Declare Exp a como uma instância de Eq.

instance (Eq a,Num a)=>Eq (Exp a) where
    (==) e1 e2 = calcula e1 == calcula e2

--(c) Declare Exp a como instância da classe Num.

instance Num a=>Num (Exp a) where
    (+) e1 e2 = Const (calcula e1 + calcula e2)
    (-) e1 e2 = Const (calcula e1 - calcula e2)
    (*) e1 e2 = Const (calcula e1 * calcula e2)
    abs e = Const (abs (calcula e))
    negate e = Const (negate (calcula e))
    signum e = Const (signum (calcula e))
    fromInteger n = Const (fromInteger n)

{- 3. Relembre o exercício da Ficha 3 sobre contas bancárias, com a seguinte declaração de
tipos: -}

data Movimento = Credito Float | Debito Float
data Data = D Int Int Int
data Extracto = Ext Float [(Data, String, Movimento)]

--(a) Defina Data como instância da classe Ord.

instance Eq Data where
    (==) e1 e2 = e1 == e2

instance Ord Data where
    compare (D d1 m1 a1) (D d2 m2 a2) | (a1,m1,d1) == (a2,m2,d2) = EQ
                                      | (a1,m1,d1) > (a2,m2,d2) = GT
                                      | (a1,m1,d1) < (a2,m2,d2) = LT

--(b) Defina Data como instância da classe Show.

instance Show Data where
    show (D d m a) = show a ++ "/" ++ show m ++ "/" ++ show d

 {- (c) Defina a função ordena :: Extracto -> Extracto, que transforma um extracto de modo a que a lista de movimentos apareça 
 ordenada por ordem crescente de data. -}

ordena::Extracto->Extracto
ordena (Ext vi l) = let lf = sortOn (\(d,_,_)->d) l
                    in (Ext vi lf)

{- Nota: Sort a list by comparing the results of a key function applied to each element. sortOn f is equivalent to sortBy (comparing f), 
but has the performance advantage of only evaluating f once for each element in the input list. This is called the decorate-sort-undecorate 
paradigm, or Schwartzian transform. -}

{- (d) Defina Extracto como instância da classe Show, de forma a que a apresentação do
extracto seja por ordem de data do movimento com o seguinte, e com o seguinte
aspecto:

Saldo anterior: 300
---------------------------------------
Data        Descricao  Credito  Debito
---------------------------------------
2010/4/5    DEPOSITO   2000
2010/8/10   COMPRA              37,5
2010/9/1    LEV                 60
2011/1/7    JUROS      100
2011/1/22   ANUIDADE            8
---------------------------------------
Saldo actual: 2294,5

-}

saldo :: Extracto -> Float
saldo (Ext valor lm) = foldl(\ini (_,_,mov) -> case mov of Credito x -> x + ini
                                                           Debito x -> ini - x ) valor lm

instance Show Extracto where
    show (Ext n l) = "Saldo anterior: " ++ show n ++
                     "\n---------------------------------------" ++
                     "\nData       Descricao   Credito   Debito" ++
                     "\n---------------------------------------\n" ++ concatMap (\(dat,str,mov) -> show dat ++ replicate (11 - (length (show dat))) ' ' ++ map (toUpper) str ++ "    \n") l ++
                     "---------------------------------------" ++
                     "\nSaldo actual: " ++ show (saldo (Ext n l))