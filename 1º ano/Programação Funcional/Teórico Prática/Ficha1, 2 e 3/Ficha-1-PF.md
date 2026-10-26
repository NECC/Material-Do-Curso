# Ficha 1
[[ficha1-PF.pdf]]
Usando as seguintes funções pré-definidas do Haskell:

- `length l`: o número de elementos da lista `l`
- `head l`: a cabeça da lista (não vazia) `l`
- `tail l`: a cauda da lista (não vazia) `l`
- `last l`: o último elemento da lista (não vazia) `l`
- `sqrt x`: a raiz quadrada de `x`
- `div x y`: a divisão inteira de `x` por `y`
- `mod x y`: o resto da divisão inteira de `x` por `y`

### Defina as seguintes funções e os respetivos tipos:

 a) `perimetro` - que calcula o perímetro de uma circunferência, dado o comprimento do seu raio.
```hs 
perimetro :: Double -> Double
perimetro x = 2 * pi * x
```

b) `dist` - que calcula a distância entre dois pontos no plano Cartesiano. Cada ponto é um par de valores do tipo `Double`.

```hs 
dist :: (Double, Double) -> (Double, Double) -> Double
dist (x1, y1) (x2, y2) = sqrt(dx ^ 2 + dy ^ 2) 
    where dx = x1 - x2
          dy = y1 - y2
```

c) `primUlt` - que recebe uma lista e devolve um par com o primeiro e o último elemento dessa lista.

```hs
primUlt :: [a] -> (a, a)
primUlt l = (head l, last l)
```

d) `multiplo` - tal que `multiplo m n` testa se o número inteiro `m` é múltiplo de `n`.

```hs
multiplo :: Int -> Int -> Bool
multiplo x y = mod x y == 0
```

e) `truncaImpar` – que recebe uma lista e, se o comprimento da lista for ímpar, retira-lhe o primeiro elemento, caso contrário devolve a própria lista.

```hs
truncaImpar :: [a] -> [a]
truncaImpar l = if even (length l) then l else tail l 
```

f) `max2` – que calcula o maior de dois números inteiros.

```hs
max2 :: Ord p => p -> p -> p
max2 x y = if x > y then x else y
```

g) `max3` – que calcula o maior de três números inteiros, usando a função `max2`.

```hs
max3 :: Ord p => p -> p -> p -> p
max3 x y z = max2 (max2 x y) z
```

### 2) Defina as seguintes funções sobre polinómios de 2º grau:

a) A função nRaizes que recebe os (3) coeficientes de um polinómio de 2º grau e que calcula o número de raízes (reais) desse polinómio.

```hs
nRaizes :: Double -> Double -> Double -> Int
nRaizes a b c 
    | delta > 0 = 2 
    | delta == 0 = 1
    | delta < 0 = 0 
    where delta = b^2 - 4*a*c
```

b) A função raizes que, usando a função anterior, recebe os coeficientes do polinómio e calcula a lista das suas raízes reais.

```hs
raizes :: Double -> Double -> Double -> [Double]
raizes a b c 
    | n == 2 = [x1, x2] 
    | n == 1 = [x1] -- Neste caso x1 e x2 são iguais, por isso podemos devolver apenas um dos valores
    | n == 0 = [] 
    where n = nRaizes a b c
          delta = b^2 - 4*a*c
          (x1,x2) = (((-b) + sqrt delta)/ (2*a), ((-b) - sqrt delta)/ (2*a))
```

### 3) Vamos representar horas por um par de números inteiros:

 `type Hora = (Int,Int)`

Assim o par `(0,15)` significa _meia noite e um quarto_ e `(13,45)` _duas menos um quarto. Defina funções para:

 a) testar se um par de inteiros representa uma hora do dia válida;

```hs
horaValida :: Hora -> Bool
horaValida (h, m) = elem h [0..23] && elem m [0..59]
```

b) testar se uma hora é ou não depois de outra (comparação);

```hs
horaDepois :: Hora -> Hora -> Bool
horaDepois (h1, m1) (h2, m2) = h1 > h2 || (h1 == h2 && m1 > m2)
```

c) converter um valor em horas (par de inteiros) para minutos (inteiro);

```hs
hour2min :: Hora -> Int
hour2min (h, m) = 60 * h + m
```

 d) converter um valor em minutos para horas;

```hs
min2hour :: Int -> Hora
min2hour min = (div min 60, mod min 60)
```

e) calcular a diferença entre duas horas (cujo resultado deve ser o número de minutos);

```hs
hourDiff :: Hora -> Hora -> Int
hourDiff h1 h2 = abs (hour2min h1 - hour2min h2)
```

 f) adicionar um determinado número de minutos a uma dada hora;

```hs
addMins :: Hora -> Int -> Hora
addMins (h, m) min = min2hour (hour2min (h, m) + min)
```

### 4) Repita o exercício anterior assumindo agora que as horas são representadas por um novo tipo de dados:

`data Hora = H Int Int deriving (Show,Eq)`

 Com este novo tipo a hora _meia noite e um quarto_ é representada por `H 0 15` e a hora _duas menos um quarto_ por `H 13 45`.

 a) testar se um par de inteiros representa uma hora do dia válida;

```hs
horaValida :: Hora -> Bool
horaValida (H h m) = elem h [0..23] && elem m [0..59]
```

 b) testar se uma hora é ou não depois de outra (comparação);

```hs
horaDepois :: Hora -> Hora -> Bool
horaDepois (H h1 m1) (H h2 m2) = h1 > h2 || (h1 == h2 && m1 > m2)
```

 c) converter um valor em horas (par de inteiros) para minutos (inteiro);

```hs
hour2min :: Hora -> Int
hour2min (H h m) = 60 * h + m
```

 d) converter um valor em minutos para horas;

```hs
min2hour :: Int -> Hora
min2hour min = H (div min 60) (mod min 60)
```

 e) calcular a diferença entre duas horas (cujo resultado deve ser o número de minutos);

```hs
hourDiff :: Hora -> Hora -> Int
hourDiff h1 h2 = abs (hour2min h1 - hour2min h2)
```

 f) adicionar um determinado número de minutos a uma dada hora;

```hs
addMins :: Hora -> Int -> Hora
addMins (h, m) min = min2hour (hour2min (h, m) + min)
```

### 5) Considere o seguinte tipo de dados para representar os possíveis estados de um semáforo:

 `data Semaforo = Verde | Amarelo | Vermelho deriving (Show, Eq)`

 a) Defina a função `next :: Semaforo -> Semaforo` que calcula o próximo estado de um semáforo.

```hs
next :: Semaforo -> Semaforo
next s = case s of Verde -> Amarelo
                   Amarelo -> Vermelho
                   Vermelho -> Verde
```

 b) Defina a função `stop :: Semaforo -> Bool` que determina se é obrigatório parar num semáforo.

```hs
stop :: Semaforo -> Bool
stop s = s == Vermelho
```

 c) Defina a função `safe :: Semaforo -> Semaforo -> Bool` que testa se o estado de dois semáforos num cruzamento é seguro.

```hs
safe :: Semaforo -> Semaforo -> Bool
safe s1 s2 = s1 == Vermelho || s2 == Vermelho
```

### 6) Um ponto num plano pode ser representado por um sistema de coordenadas Cartesiano (distâncias aos eixos vertical e horizontal) ou por um sistema de coordenadas Polar (distância à origem e ângulo do respetivo vector com o eixo horizontal).

 `data Ponto = Cartesiano Double Double | Polar Double Double deriving (Show,Eq)`

Com este tipo o ponto Cartesiano (-1) 0 pode alternativamente ser representado por Polar 1 pi. Defina as seguintes funções:

a) `posx :: Ponto -> Double` que calcula a distância de um ponto ao eixo vertical.

```hs
posx :: Ponto -> Double
posx ponto = case ponto of Cartesiano x _ -> x
                           Polar d a -> if a == pi/2 then 0 else d * cos a
-- Utilizamos aqui um `if` porque `cos (pi/2)` não dá exatamente 0, devido à forma como os valores do tipo Double são armazenados no computador.
```

 b) `posy :: Ponto -> Double` que calcula a distância de um ponto ao eixo horizontal.

```hs
posy :: Ponto -> Double
posy ponto = case ponto of Cartesiano _ y -> y
                           Polar d a -> if a == pi then 0 else d * sin a
```

 c) `raio :: Ponto -> Double` que calcula a distância de um ponto à origem.

```hs
raio :: Ponto -> Double
raio ponto = case ponto of Cartesiano x y -> sqrt (x^2 + y^2)
                           Polar d _ -> d
```

d) `angulo :: Ponto -> Double` que calcula o ângulo entre o vector que liga a origem a um ponto e o eixo horizontal.

```hs
angulo :: Ponto -> Double
angulo ponto = case ponto of Cartesiano x y -> if x < 0 && y == 0 then pi else
                                               if x < 0 then pi + atan (y/x) else
                                               atan (y/x)
                             Polar _ a -> a
```

e) `dist :: Ponto -> Ponto -> Double` que calcula a distância entre dois pontos.

```hs
dist :: Ponto -> Ponto -> Double
dist ponto1 ponto2 = sqrt (((posx ponto1 - posx ponto2) ^ 2) + (posy ponto1 - posy ponto2) ^ 2)
```

### 7) Considere o seguinte tipo de dados para representar figuras geométricas num plano.

```hs
data Figura = Circulo Ponto Double
            | Rectangulo Ponto Ponto
            | Triangulo Ponto Ponto Ponto
              deriving (Show,Eq)
```

 Uma figura pode ser um círculo centrado um determinado ponto e com um determinado raio, um retângulo paralelo aos eixos representado por dois pontos que são vértices da sua diagonal, ou um triângulo representado pelos três pontos dos seus vértices. Defina as seguintes funções:

 a) Defina a função `poligono :: Figura -> Bool` que testa se uma figura é um polígono.

```hs
poligono :: Figura -> Bool
poligono (Circulo c r) = False
poligono (Retangulo p1 p2) = posx p1 /= posx p2 && posy p1 /= posy p2 -- Verifica que os pontos não têm o mesmo valor de x ou y
poligono (Triangulo p1 p2 p3) = (posy p2 - posy p1) / (posx p2 - posx p1) /= (posy p3 - posy p2) / (posx p3 - posx p2) -- Verifica que os pontos não pertencem todos à mesma reta
```

b) Defina a função `vertices :: Figura -> [Ponto]` que calcula a lista dos vertices de uma figura.

```hs
vertices :: Figura -> [Ponto]
vertices (Circulo _ _) = []
vertices retang@(Retangulo p1 p2) = if poligono retang then [p1, Cartesiano (posx p1) (posy p2), Cartesiano (posx p2) (posy p1), p2] else []
vertices triang@(Triangulo p1 p2 p3) = if poligono triang then [p1, p2, p3] else []
```

c) Complete a seguinte definição cujo objectivo é calcular a área de uma figura:

```hs
area :: Figura -> Double
area (Triangulo p1 p2 p3) =
    let a = dist p1 p2
        b = dist p2 p3
        c = dist p3 p1
        s = (a+b+c) / 2 -- semi-perimetro
    in sqrt (s*(s-a)*(s-b)*(s-c)) -- formula de Heron
```

```hs
area :: Figura -> Double
area (Triangulo p1 p2 p3) =
    let a = dist p1 p2
        b = dist p2 p3
        c = dist p3 p1
        s = (a+b+c) / 2 -- semi-perimetro
    in sqrt (s*(s-a)*(s-b)*(s-c)) -- fórmula de Heron
area (Circulo _ r) = pi * (r ^ 2)
area (Retangulo p1 p2) = abs (posx p2 - posx p1) * abs (posy p2 - posy p1) 
```

d) Defina a função `perimetro :: Figura -> Double` que calcula o perímetro de uma figura.

```hs
perimetro :: Figura -> Double
perimetro (Circulo _ r) = 2 * pi * r
perimetro (Retangulo p1 p2) = 2 * abs (posx p2 - posx p1) + 2 * abs (posy p2 - posy p1)
perimetro (Triangulo p1 p2 p3) = dist p1 p2 + dist p2 p3 + dist p1 p3
```

### 8) Utilizando as funções `ord :: Char -> Int` e `chr :: Int -> Char` do módulo Data.Char, defina as seguintes funções (note que todas estas funções já estão também pré-definidas nesse módulo):

 a) `isLower :: Char -> Bool`, que testa se um `Char` é uma minúscula.

```hs
isLower :: Char -> Bool
isLower ch = ord ch >= ord 'a' && ord ch <= ord 'z'

-- Pode ser simplificado para:

isLower' :: Char -> Bool
isLower' ch = ch `elem` ['a'..'z']
```

 b) `isDigit :: Char -> Bool`, que testa se um `Char` é um dígito.

```hs
isDigit :: Char -> Bool
isDigit d = ord ch >= ord '0' && ord ch <= ord '9'
```

 c) `isAlpha :: Char -> Bool`, que testa se um `Char` é uma letra.

```hs
isAlpha :: Char -> Bool
isAlpha ch = isLower ch || isUpper ch
    where isUpper ch = ord ch >= ord 'A' && ord ch <= ord 'Z'
```

 d) `toUpper :: Char -> Char`, que converte uma letra para a respectiva maiúscula.

```hs
toUpper :: Char -> Char
toUpper ch = if isLower ch then chr (ord ch - 32) else ch
-- 32 é o resultado de `ord 'a' - ord 'A'`
```

 e) `intToDigit :: Int -> Char`, que converte um número entre 0 e 9 para o respetivo dígito.

```hs
intToDigit :: Int -> Char
intToDigit n = chr (n + 48)
-- 48 é o resultado de `ord '0' - 0`
```

 f) `digitToInt :: Char -> Int`, que converte um dígito para o respetivo inteiro.

```hs
digitToInt :: Char -> Int 
digitToInt ch = ord ch - 48
```
