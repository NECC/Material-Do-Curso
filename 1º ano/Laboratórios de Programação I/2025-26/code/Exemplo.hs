module Exemplos where 

type Matriz a = [[a]]

type Posicao = (Int, Int)

type Dimensao = (Int, Int)

data Direcao = Norte | Nordeste | Este | Sudeste | Sul | Sudoeste | Oeste | Noroeste
    deriving (Eq, Ord, Show, Read, Enum)

data Nat = Zero 
        | Succ Nat 
        deriving (Show) 


fromInt :: Int -> Nat 
fromInt 0 = Zero 
fromInt n = Succ (fromInt (n-1))

toInt :: Nat -> Int 
toInt Zero = 0 
toInt (Succ n) = toInt n + 1 

soma :: Nat -> Nat -> Nat 
soma Zero y = y
soma (Succ n) y = Succ (soma n y)  

comprimento :: [a] -> Nat
comprimento [] = Zero 
comprimento (x:xs) = Succ (comprimento xs) 

movePosicao :: Direcao -> Posicao -> Posicao
movePosicao d (l, c) 
    | d == Norte = (l - 1, c) 
    | d == Nordeste = (l -1, c + 1) 
    | d == Este = (l, c + 1)
    | d == Sudeste = (l + 1, c + 1)
    | d == Sul = (l + 1, c) 
    | d == Sudoeste = (l + 1, c - 1) 
    | d == Oeste = (l, c - 1)
    | d == Noroeste = (l - 1, c - 1) 

movePosicaojanela :: Dimensao -> Direcao -> Posicao -> Posicao 
movePosicaoJanela (nl nc) d (x, y) = 
        let (x', y') = movePosicao d (x, y)
        in (min (nl - 1) (max  x' 0), min (nc - 1) (max y' 0)) 
