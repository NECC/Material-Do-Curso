# Ficha 3
[[ficha3-PF.pdf]]
1. Assumindo que uma hora é representada por um par de inteiros, uma viagem pode ser representada por uma sequência de etapas, onde cada etapa é representada por um par de horas (partida, chegada):

```hs
data Hora = H Int Int
  deriving (Show, Eq, Ord)

type Etapa = (Hora, Hora)

type Viagem = [Etapa]
```

```hs
v1 :: Viagem
v1 = [(H 9 30, H 10 25), (H 11 20, H 12 45), (H 13 30, H 14 45)]
```

a) Testar se uma etapa está bem construída (i.e., o tempo de chegada é superior ao de partida e as horas são válidas).

```hs
validaHora :: Hora -> Bool
validaHora (H h m) = h >= 0 && h < 24 && m >= 0 && m < 60

validaEtapa :: Etapa -> Bool
validaEtapa (h1, h2) = validaHora h1 && validaHora h2 && h1 < h2
```

b) Testa se uma viagem está bem construída (i.e., se para cada etapa, o tempo de chegada é superior ao de partida, e se a etapa seguinte começa depois da etapa anterior ter terminado).

```hs
validaViagem :: Viagem -> Bool
validaViagem ((h1, h2) : (h3, h4) : t) = validaEtapa (h1, h2) && (h1, h2) < (h3, h4)
```

c) Calcular a hora de partida e de chegada de uma dada viagem.

```hs
calcHoras :: Viagem -> (Hora, Hora)
calcHoras (h1 : t) = (fst h1, snd (last t))
```

d) Dada uma viagem válida, calcular o tempo total de viagem efectiva.

```hs
fromMinToHours :: Int -> Hora
fromMinToHours m = H (div m 60) (mod m 60)

calcViagemEfectiva :: Viagem -> Hora
calcViagemEfectiva [] = H 0 0
calcViagemEfectiva ((H h1 m1, H h2 m2) : t) =
  let difHoras (H h1 m1) (H h2 m2) = (h2 * 60 + m2) - (h1 * 60 + m1)
      difEtapas (H h1 m1, H h2 m2) = difHoras (H h1 m1) (H h2 m2)
      H h m = calcViagemEfectiva t
      minRest = h * 60 + m
   in fromMinToHours (difEtapas (H h1 m1, H h2 m2) + minRest)
```

ou 

```hs
calcViagemEfectiva :: Viagem -> Hora
calcViagemEfectiva v = fromMinToHours (sumMinutes v)
     where
          sumMinutes :: Viagem -> Int
          sumMinutes [] = 0
          sumMinutes ((H h1 m1, H h2 m2):t) =
               let dif = (h2 * 60 + m2) - (h1 * 60 + m1)
               in dif + sumMinutes t

          fromMinToHours :: Int -> Hora
          fromMinToHours m = H (m `div` 60) (m `mod` 60)
```

e) Calcular o tempo total de espera.

```hs
calcTempEsp :: Viagem -> Hora
calcTempEsp [] = H 0 0
calcTempEsp [_] = H 0 0
calcTempEsp v = fromMinToHours (minEspera v)
  where
    minEspera :: Viagem -> Int
    minEspera [] = 0
    minEspera [_] = 0
    minEspera ((_, H h2 m2) : (H h3 m3, _) : t) =
      let dif = (h3 * 60 + m3) - (h2 * 60 + m2)
       in dif + minEspera t
```

f) Calcular o tempo total da viagem (a soma dos tempos de espera e de viagem efectiva).

```hs
calcTempTotal :: Viagem -> Hora
calcTempTotal [] = H 0 0
calcTempTotal v =
  let (H h1 m1, _) = head v
      (_, H hn mn) = last v
      totalMin = (hn * 60 + mn) - (h1 * 60 + m1)
   in fromMinToHours totalMin
```

2. Considere as seguinte definição de um tipo para representar linhas poligonais.

```hs
type Poligonal = [Ponto]
```

O tipo Ponto é idêntico ao definido na Ficha 1. Nas resolução das alíneas seguintes pode utilizar funções definidas nessa ficha.

a) Defina a função para calcular o comprimento de uma linha poligonal

```hs
comprimento :: Poligonal -> Double
comprimento (p1:p2:t) = dist p1 p2 + comprimento (p2:t)
comprimento _ = 0
```

b) Defina uma função para testar se uma dada linha poligonal é ou não fechada.

```hs
linhaFechada :: Poligonal -> Bool
linhaFechada p = length p >= 3 && head p == last p
```

c) Defina a função triangula :: Poligonal -> [Figura] que, dada uma linha poligonal fechada e convexa, calcule uma lista de triângulos cuja soma das áreas seja igual à àrea delimitada pela linha poligonal. O tipo Figura é idêntico ao definido na Ficha 1.

```hs
triangula :: Poligonal -> [Figura]
triangula (p1:p2:p3:ps)
    | p1 == p3 = []
    | otherwise = Triangulo p1 p2 p3 : triangula (p1:p3:ps)
triangula _ = []
```

3. Para armazenar uma agenda de contactos telefónicos e de correio electrónico definiram-se os seguintes tipos de dados. Não existem nomes repetidos na agenda e para cada nome existe uma lista de contactos. 

```hs
data Contacto = Casa Integer
              | Trab Integer
              | Tlm Integer
              | Email String
              deriving Show

type Nome = String
type Agenda = [(Nome, [Contacto])]
```

a) Defina a função `acrescEmail :: Nome -> String -> Agenda -> Agenda` que, dado um nome, um email e uma agenda, acrescenta essa informação à agenda.

```hs
acresEmail :: Nome -> String -> Agenda -> Agenda
acresEmail a b [] = [(a, [Email b])]
acresEmail a b ((x, y) : resto) =
  if (a == x)
    then ((x, (Email b) : y)) : resto
    else (x, y) : (acresEmail a b resto)
```

b) Defina a função `verEmails :: Nome -> Agenda -> Maybe [String]` que, dado um nome e uma agenda, retorna a lista dos emails associados a esse nome. Se esse nome não existir na agenda a função deve retornar `Nothing`.

```hs
verEmails :: Nome -> Agenda -> Maybe [String]
verEmails _ [] = Nothing
verEmails a ((x, y) : resto)
  | a == x = Just [e | Email e <- y]
  | a /= x = verEmails a resto

```

c) Defina a função `consTelefs :: [Contacto] -> [Integer]` que, dada uma lista de contactos, retorna a lista de todos os números de telefone dessa lista (tanto telefones fixos como telemóveis).

```hs
consTelefs :: [Contacto] -> [Integer]
consTelefs [] = [0]
consTelefs contactos = [nums | Tlm nums <- contactos] ++ [telefone | Casa telefone <- contactos]
```

d) Defina a função `casa :: Nome -> Agenda -> Maybe Integer` que, dado um nome e uma agenda, retorna o número de telefone de casa (caso exista).

```hs
casa :: Nome -> Agenda -> Maybe Integer
casa _ [] = Nothing
casa nome ((x, y) : resto)
  | nome == x = case [num | Casa num <- y] of
      [] -> Nothing
      [z] -> Just z
  | otherwise = casa nome resto
```
