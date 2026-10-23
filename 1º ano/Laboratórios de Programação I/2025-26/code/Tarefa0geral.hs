module Tarefa0geral where

type Matriz a = [[a]]

type Posicao = (Int, Int)

type Dimensao = (Int, Int)

data Direcao = Norte | Nordeste | Este | Sudeste | Sul | Sudoeste | Oeste | Noroeste
  deriving (Eq, Ord, Show, Read, Enum)

eIndiceListaValido :: Int -> [a] -> Bool
eIndiceListaValido n l = elem n [0 .. (length l - 1)]

encontraIndiceLista :: Int -> [a] -> Maybe a
encontraIndiceLista i l =
  if eIndiceListaValido i l
    then Just (l !! i)
    else Nothing

atualizaIndiceLista :: Int -> a -> [a] -> [a]
atualizaIndiceLista 0 x [] = []
atualizaIndiceLista 0 x (h : t) = x : t
atualizaIndiceLista n x (h : t)
  | n <= length (h : t) = h : atualizaIndiceLista (n - 1) x t
  | otherwise = (h : t)

dimensaoMatriz :: Matriz a -> Dimensao
dimensaoMatriz [] = (0, 0)
dimensaoMatriz (l : ls) = (nl, nc)
  where
    nl = 1 + length ls
    nc = length l

ePosicaoMatrizValida :: Posicao -> Matriz a -> Bool
ePosicaoMatrizValida (nl, nc) [] = False
ePosicaoMatrizValida (nl, nc) (l : ls) =
  eIndiceListaValido nl (l : ls)
    && eIndiceListaValido nc l

movePosicao :: Direcao -> Posicao -> Posicao
movePosicao d (l, c)
  | d == Norte = (l - 1, c)
  | d == Nordeste = (l - 1, c + 1)
  | d == Este = (l, c + 1)
  | d == Sudeste = (l + 1, c + 1)
  | d == Sul = (l + 1, c)
  | d == Sudoeste = (l + 1, c - 1)
  | d == Oeste = (l, c - 1)
  | d == Noroeste = (l - 1, c - 1)

movePosicaoJanela :: Dimensao -> Direcao -> Posicao -> Posicao
movePosicaoJanela (nl, nc) d (l, c)
  | d == Norte =
      if 0 <= fst (movePosicao d (l, c)) && fst (movePosicao d (l, c)) < nl && 0 <= snd (movePosicao d (l, c)) && snd (movePosicao d (l, c)) <= nc
        then movePosicao d (l, c)
        else (l, c)
  | d == Nordeste =
      if 0 <= fst (movePosicao d (l, c)) && fst (movePosicao d (l, c)) < nl && 0 <= snd (movePosicao d (l, c)) && snd (movePosicao d (l, c)) <= nc
        then movePosicao d (l, c)
        else (l, c)
  | d == Este =
      if 0 <= fst (movePosicao d (l, c)) && fst (movePosicao d (l, c)) < nl && 0 <= snd (movePosicao d (l, c)) && snd (movePosicao d (l, c)) <= nc
        then movePosicao d (l, c)
        else (l, c)
  | d == Sudeste =
      if 0 <= fst (movePosicao d (l, c)) && fst (movePosicao d (l, c)) < nl && 0 <= snd (movePosicao d (l, c)) && snd (movePosicao d (l, c)) <= nc
        then movePosicao d (l, c)
        else (l, c)
  | d == Sul =
      if 0 <= fst (movePosicao d (l, c)) && fst (movePosicao d (l, c)) < nl && 0 <= snd (movePosicao d (l, c)) && snd (movePosicao d (l, c)) <= nc
        then movePosicao d (l, c)
        else (l, c)
  | d == Sudoeste =
      if 0 <= fst (movePosicao d (l, c)) && fst (movePosicao d (l, c)) < nl && 0 <= snd (movePosicao d (l, c)) && snd (movePosicao d (l, c)) <= nc
        then movePosicao d (l, c)
        else (l, c)
  | d == Oeste =
      if 0 <= fst (movePosicao d (l, c)) && fst (movePosicao d (l, c)) < nl && 0 <= snd (movePosicao d (l, c)) && snd (movePosicao d (l, c)) <= nc
        then movePosicao d (l, c)
        else (l, c)
  | d == Noroeste =
      if 0 <= fst (movePosicao d (l, c)) && fst (movePosicao d (l, c)) < nl && 0 <= snd (movePosicao d (l, c)) && snd (movePosicao d (l, c)) <= nc
        then movePosicao d (l, c)
        else (l, c)

origemAoCentro :: Dimensao -> Posicao -> Posicao
origemAoCentro (l, c) (x, y) = (x + (div l 2), y + (div c 2))

rodaPosicaoDirecao :: (Posicao, Direcao) -> (Posicao, Direcao)
rodaPosicaoDirecao ((x, y), d) =
  let (x', y') = movePosicao d (x, y)
      d' = case d of
        Norte -> Nordeste
        Nordeste -> Este
        Este -> Sudeste
        Sudeste -> Sul
        Sul -> Sudoeste
        Sudoeste -> Oeste
        Oeste -> Noroeste
        Noroeste -> Norte
   in ((x', y'), d')

encontraPosicaoMatriz :: Posicao -> Matriz a -> Maybe a
encontraPosicaoMatriz (x, y) m =
  if ePosicaoMatrizValida (x, y) m
    then Just ((m !! x) !! y) -- va a buscar primero la línea y después la columna
    else Nothing

atualizaPosicaoMatriz :: Posicao -> a -> Matriz a -> Matriz a
atualizaPosicaoMatriz (nl, nc) x m =
  if ePosicaoMatrizValida (nl, nc) m
    then
      let l = m !! nl
          l' = atualizaIndiceLista (nc) x l
       in atualizaIndiceLista (nl) l' m
    else m

moveDirecoesPosicao :: [Direcao] -> Posicao -> Posicao
moveDirecoesPosicao [] p = p

moveDirecoesposicao (d : ds) p =
  moveDirecoesPosicao ds (movePosicao d p)

moveDirecaoPosicoes :: Direcao -> [Posicao] -> [Posicao]
moveDirecaoPosicoes d [] = []
moveDirecaoPosicoes d (p : ps) =
  movePosicao d p : moveDirecaoPosicoes d ps

{-
moveDirecaoPosicoes Norte [(1,1), (2,2), (3,3)]
==
moveDirecaoPosicoes Norte ((1,1): [(2,2), (3,3)])

(0,1) : moveDirecaoPosicoes Norte [(2,2), (3,3)]

(0,1) : (1,2) : moveDirecaoPosicoes Norte [(3,3)]

(0,1) : (1,2) : (2,3) : moveDirecaoPosicoes Norte []

(0,1) : (1,2) : (2,3) : []

[(0,1), (1,2), (2,3)]
-}

eMatrizValida :: Matriz a -> Bool
eMatrizValida [] = True
eMatrizValida (l : ls) =
  let n = length l
   in aux n ls
  where
    aux :: Int -> Matriz a -> Bool
    aux n [] = True
    aux n (x : xs)
      | n == length x = aux n xs
      | otherwise = False

abrevia :: [String] -> String
abrevia ls = head (head ls) : '.' : (last ls)
