module Ficha1 where

import Data.Char
import Data.List

{- 1. Usando as seguintes funções pré-definidas do Haskell:
• length l: o número de elementos da lista l
• head l: a cabeça da lista (não vazia) l
• tail l: a cauda lista (não vazia) l
• last l: o último elemento da lista (não vazia) l
• sqrt x: a raiz quadrada de x
• div x y: a divisão inteira de x por y
• mod x y: o resto da divisão inteira de x por y
Defina as seguintes funções e os respectivos tipos:-}

--(a) perimetro – que calcula o perímetro de uma circunferência, dado o comprimento do seu raio.

perimetro :: Float -> Float
perimetro x = 2*pi*x

--(b) dist – que calcula a distância entre dois pontos no plano Cartesiano. Cada ponto é um par de valores do tipo Double.

dist :: (Double,Double) -> (Double,Double) -> Double 
dist (x,y) (xs,ys) = sqrt((x - xs)^2 + (y - ys)^2 )

--(c) primUlt – que recebe uma lista e devolve um par com o primeiro e o último elemento dessa lista.

primUlt:: [a] -> (a,a)
primUlt l = (head l, last l)

--(d) multiplo – tal que multiplo m n testa se o número inteiro m é múltiplo de n.

multiplo :: Int -> Int -> Bool
multiplo x xs = if mod x xs == 0 then True else False

--(e) truncaImpar – que recebe uma lista e, se o comprimento da lista for ímpar retiralhe o primeiro elemento, caso contrário devolve a própria lista.

truncaImpar:: [a] -> [a]
truncaImpar l = if mod (length l) 2 == 0 then l else tail l

--(f) max2 – que calcula o maior de dois números inteiros.

max2 :: Int -> Int -> Int
max2 x y = if x >= y then  x else y

--(g) max3 – que calcula o maior de três números inteiros, usando a função max2

max3 :: Int -> Int -> Int -> Int
max3 x y z = max2 (max2 x y) z

--2. Defina as seguintes funções sobre polinómios de 2a grau:

--(a) A função nRaizes que recebe os (3) coeficientes de um polinómio de 2o grau e que calcula o número de raízes (reais) desse polinómio.

nRaizes :: Float->Float->Float->Int
nRaizes x y z | delta1 < 0 = 0
              | delta1 == 0 = 1 
              | delta1 > 0 = 2
              where delta1 = (y^2)-4*x*z


--(b) A função raizes que, usando a função anterior, recebe os coeficientes do polinómio e calcula a lista das suas raízes reais.

nRaizes2 :: Float->Float->Float->[Float]
nRaizes2 x y z |delta2 < 0 = []
               | delta2 == 0 = [r]
               | delta2 > 0 = [r1,r2]
               where
                delta2 = (y^2-4*x*z) 
                r= (-y)/(2*x)
                r1= ((-y)+sqrt delta2)/(2*x)
                r2= ((-y)-sqrt delta2)/(2*x)

--3. Vamos representar horas por um par de números inteiros:

type Hora = (Int,Int)

--Assim o par (0,15) significa meia noite e um quarto e (13,45) duas menos um quarto.
--Defina funções para:
--(a) testar se um par de inteiros representa uma hora do dia válida;

hValida :: Hora -> Bool
hValida (x,y) = if x < 24 && y < 60 then True else False

--(b) testar se uma hora é ou não depois de outra (comparação);

hDepois :: Hora -> Hora -> Bool
hDepois (x1,y1) (x2,y2) | x1 > x2 = True
                        | x1 < x2 = False
                        | x1 == x2 && y1 > y2 = True
                        |otherwise = False  

--(c) converter um valor em horas (par de inteiros) para minutos (inteiro);

convH :: Hora -> Int
convH (x,y) = x*60 + y

--(d) converter um valor em minutos para horas;

convM :: Int -> Hora
convM h = (div h 60, mod h 60) 

--(e) calcular a diferença entre duas horas (cujo resultado deve ser o número de minutos)

difM :: Hora -> Hora -> Int
difM (x1,y1) (x2,y2) = (abs(x1-x2)*60) + abs(y1-y2)

--(f) adicionar um determinado número de minutos a uma dada hora.

sumH :: Int -> Hora -> Hora
sumH x (h1,m1) = (h1 + (div (x+m1) 60), mod (x+m1) 60)

--4. Repita o exercício anterior assumindo agora que as horas são representadas por um novo tipo de dados:

data Hora' = H Int Int deriving (Show,Eq)

--Com este novo tipo a hora meia noite e um quarto é representada por H 0 15 e a hora duas menos um quarto por H 13 45.

hValida' :: Hora' -> Bool
hValida' (H x y) = if x < 24 && y < 60 then True else False

hDepois' :: Hora' -> Hora' -> Bool
hDepois' (H x1 y1) (H x2 y2) | x1 > x2 = True
                             | x1 < x2 = False
                             | x1 == x2 && y1 > y2 = True
                             |otherwise = False  

convH' :: Hora' -> Int
convH' (H x y) = x*60 + y

convM' :: Int -> Hora'
convM' h = (H (div h 60)  (mod h 60)) 

difM' :: Hora' -> Hora' -> Int
difM' (H x1 y1) (H x2 y2) = (abs(x1-x2)*60) + abs(y1-y2)

sumH' :: Int -> Hora' -> Hora'
sumH' x (H h1 m1) = (H (h1 + (div (x+m1) 60))  (mod (x+m1) 60))

--5. Considere o seguinte tipo de dados para representar os possíveis estados de um semáforo:

data Semaforo = Verde | Amarelo | Vermelho deriving (Show,Eq)

--(a) Defina a função next :: Semaforo -> Semaforo que calcula o próximo estado de um semáforo.

next :: Semaforo -> Semaforo
next x | x == Verde = Amarelo
       | x == Amarelo = Vermelho
       | x == Vermelho = Verde

--(b) Defina a função stop :: Semaforo -> Bool que determina se é obrigatório parar num semáforo.

stop :: Semaforo -> Bool
stop x = if x == Vermelho then True else False 

--(c) Defina a função safe :: Semaforo -> Semaforo -> Bool que testa se o estado de dois semáforo num cruzamento é seguro

safe :: Semaforo -> Semaforo -> Bool
safe s1 s2 = if s1 == Vermelho || s2 == Vermelho then False else True

{-6. Um ponto num plano pode ser representado por um sistema de coordenadas Cartesiano
(distâncias aos eixos vertical e horizontal) ou por um sistema de coordenadas Polar
(distância à origem e ângulo do respectivo vector com o eixo horizontal).-}

data Ponto = Cartesiano Double Double | Polar Double Double deriving (Show,Eq)

{- Com este tipo o ponto Cartesiano (-1) 0 pode alternativamente ser representado por
Polar 1 pi. Defina as seguintes funções:-}

--(a) posx :: Ponto -> Double que calcula a distância de um ponto ao eixo vertical.

posx :: Ponto -> Double
posx (Cartesiano x1 y1) = x1
posx (Polar d a) = d * (cos a)

--(b) posy :: Ponto -> Double que calcula a distância de um ponto ao eixo horizontal.

posy :: Ponto -> Double
posy (Cartesiano x1 y1) = y1
posy (Polar d a) = d + (sin a)

--(c) raio :: Ponto -> Double que calcula a distância de um ponto à origem.

raio :: Ponto -> Double
raio (Cartesiano x1 y1) = sqrt (x1^2 + y1^2)
raio (Polar d a) = d

--(d) angulo :: Ponto -> Double que calcula o ângulo entre o vector que liga a origem a um ponto e o eixo horizontal.

angulo :: Ponto -> Double
angulo (Cartesiano x1 y1) |x1==0 && y1==0 =0
                          |x1==0 && y1>0 = pi/2
                          |x1==0 && y1<0 = -pi/2
                          |x1>0 = atan (y1/x1)
                          |x1<0 && y1>=0 = atan (y1/x1) + pi
                          |x1<0 && y1<0 = atan (y1/x1) - pi
angulo (Polar d a) = a

--(e) dist :: Ponto -> Ponto -> Double que calcula a distância entre dois pontos

dist' :: Ponto -> Ponto -> Double
dist' (Cartesiano x1 y1) (Cartesiano x2 y2) = sqrt ((x1-x2)^2+(y1-y2)^2)
dist' (Polar d1 a1) (Polar d2 a2) = sqrt((px1-px2)^2+(py1-py2)^2)
                                   where 
                                   px1 = d1 * cos a1
                                   px2 = d2 * cos a2
                                   py1 = d1 * sin a1
                                   py2 = d2 * sin a2

--7. Considere o seguinte tipo de dados para representar figuras geométricas num plano.

data Figura = Circulo Ponto Double | Rectangulo Ponto Ponto | Triangulo Ponto Ponto Ponto deriving (Show,Eq)

{- Uma figura pode ser um círculo centrado um determinado ponto e com um determinado
raio, um rectângulo paralelo aos eixos representado por dois pontos que são vértices da
sua diagonal, ou um triângulo representado pelos três pontos dos seus vértices. Defina
as seguintes funções: -}

{-(a) Defina a função poligono :: Figura -> Bool que testa se uma figura é um
polígono.-}

poligono :: Figura -> Bool
poligono (Circulo a r) = if r > 0 then True else False
poligono (Rectangulo a b) = if (posx a) /= (posx b) && (posy a) /= (posy b) then True else False
poligono (Triangulo a b c) = ((x+y)>z) || ((x+z)>y) || ((y+z)>x)
                           where 
                           x = dist' a b
                           y = dist' a c
                           z = dist' b c

{-(b) Defina a função vertices :: Figura -> [Ponto] que calcula a lista dos vertices
de uma figura.-}

vertices :: Figura -> [Ponto]
vertices (Circulo a r) = []
vertices (Rectangulo a b) = [Cartesiano x1 y1, Cartesiano x1 y2, Cartesiano x2 y1, Cartesiano x2 y2]
                            where 
                            x1 = (posx a)
                            x2 = (posx b)
                            y1 = (posy a)
                            y2 = (posy b)
vertices (Triangulo a b c) = [a,b,c]

{-(c) Complete a seguinte definição cujo objectivo é calcular a área de uma figura: -}

area :: Figura -> Double
area (Triangulo p1 p2 p3) = let a = dist' p1 p2
                                b = dist' p2 p3
                                c = dist' p3 p1
                                s = (a+b+c) / 2 -- semi-perimetro
                                in sqrt (s*(s-a)*(s-b)*(s-c)) -- formula de Heron
area (Circulo a r) = pi * (r)^2
area (Rectangulo a b) = if posx a > posy b then (posx a - posx b) * (posy a - posy b) else (posx b - posx a) * (posy b - posy a)  

{-(d) Defina a função perimetro :: Figura -> Double que calcula o perímetro de
uma figura.-}

perimetro' :: Figura -> Double
perimetro' (Circulo a r) = 2 * pi * r
perimetro' (Rectangulo a b) = 2 * (((abs (posx a)) + (abs(posx b))) + ((abs (posy a)) + (abs(posy b))))
perimetro' (Triangulo a b c) = let p1 = dist' a b
                                   p2 = dist' b c
                                   p3 = dist' c a
                               in  p1 + p2 + p3 

{-8. Utilizando as funções ord :: Char -> Int e chr :: Int -> Char do módulo Data.Char,
defina as seguintes funções:-}

--(a) isLower :: Char -> Bool, que testa se um Char é uma minúscula.

isLower' :: Char -> Bool
isLower' x = if ord(x) >= 95 && ord(x) <= 122 then True else False

--(b) isDigit :: Char -> Bool, que testa se um Char é um dígito.

isDigit' :: Char -> Bool
isDigit' x = if elem x ['0'..'9'] then True else False

--(c) isAlpha :: Char -> Bool, que testa se um Char é uma letra.

isAlpha' :: Char -> Bool
isAlpha' x = if isLower x || elem x ['A'..'Z'] then True else False

--(d) toUpper :: Char -> Char, que converte uma letra para a respectiva maiúscula.

toUpper' :: Char -> Char
toUpper' x = if isLower x == True then chr (ord(x) - 32) else x

--(e) intToDigit :: Int -> Char, que converte um número entre 0 e 9 para o respectivo dígito.

intToDigit' :: Int -> Char
intToDigit' x = if elem x [0..9] then chr( ord('0') + x) else error ""

--(f) digitToInt :: Char -> Int, que converte um dígito para o respectivo inteiro.

digitToInt' :: Char -> Int
digitToInt' x = if isAlpha x == True then (ord x - ord '0') else error ""

-------------------------------------------------------------------- 2º Ficha --------------------------------------------------------------------

{- 1. Indique como é que o interpretador de haskell avalia as expressões das alíneas que se
seguem, apresentando a cadeia de redução de cada uma dessas expressões (i.e., os vários
passos intermédios até se chegar ao valor final). -}

--(a) Considere a seguinte definição:

funA :: [Double] -> Double
funA [] = 0
funA (y:ys) = y^2 + (funA ys)

--Diga, justificando, qual é o valor de funA [2,3,5,1].

{- A funA vai pegar individualmente no valor de cada elemento da lista e vai somando os quadrados de todos os elementos da lista.
Logo funA [2,3,5,1] = 4+9+25+1 = 39. -} 

--(b) Considere seguinte definição:

funB :: [Int] -> [Int]
funB [] = []
funB (h:t) = if (mod h 2)==0 then h : (funB t)
else (funB t)

--Diga, justificando, qual é o valor de funB [8,5,12]

{- A funB vai retirar os valores impares da lista e devolve uma lista com apenas os pares.
Logo funB [8,5,12] = [8,12]. -}

--(c) Considere a seguinte definição:

funC (x:y:t) = funC t
funC [x] = []
funC [] = []

--Diga, justificando, qual é o valor de funC [1,2,3,4,5].

{- A funC vai transformar qualquer lista de valores numa lista vazia.
Logo funC [1,2,3,4,5] = []. -}

--(d) Considere a seguinte definição:

funD l = g [] l
g l [] = l
g l (h:t) = g (h:l) t

--Diga, justificando, qual é o valor de funD "otrec".

{- A funD vai fazer o reverse de uma string.
Logo funD "otrec" = "certo"-}

--2. Defina recursivamente as seguintes funções sobre listas:

{-(a) dobros :: [Float] -> [Float] que recebe uma lista e produz a lista em que
cada elemento é o dobro do valor correspondente na lista de entrada.-}

dobros :: [Float] -> [Float]
dobros [] = []
dobros (h:t) = 2*h: dobros t

{-(b) numOcorre :: Char -> String -> Int que calcula o número de vezes que um
caracter ocorre numa string.-}

numOcorre :: Char -> String -> Int
numOcorrex x [] = 0
numOcorre x (h:t) = if x == h then 1 + numOcorre x t else numOcorre x t

--(c) positivos :: [Int] -> Bool que testa se uma lista só tem elementos positivos.

positivos :: [Int] -> Bool
positivos [] = True
positivos (h:t) = if h > 0 then positivos t else False

{-(d) soPos :: [Int] -> [Int] que retira todos os elementos não positivos de uma
lista de inteiros. -}

soPos :: [Int] -> [Int]
soPos [] = []
soPos (h:t) = if h < 0 then soPos t else h: soPos t

--(e) somaNeg :: [Int] -> Int que soma todos os números negativos da lista de entrada.

somaNeg :: [Int] -> Int
somaNeg [] = 0
somaNeg (h:t) = if h < 0 then h + somaNeg t else somaNeg t

{- (f) tresUlt :: [a] -> [a] devolve os últimos três elementos de uma lista. Se a
lista de entrada tiver menos de três elementos, devolve a própria lista.  -}

tresUlt :: [a] -> [a]
tresUlt (x1:x2:x3:x4:t) = tresUlt (x2:x3:x4:t)
tresUlt l = l

-- (g) segundos :: [(a,b)] -> [b] que calcula a lista das segundas componentes dos pares.

segundos :: [(a,b)] -> [b]
segundos [] = []
segundos ((a,b):t) = [b] ++ segundos t


{- (h) nosPrimeiros :: (Eq a) => a -> [(a,b)] -> Bool que testa se um elemento
aparece na lista como primeira componente de algum dos pares. -}

nosPrimeiros :: (Eq a) => a -> [(a,b)] -> Bool
nosPrimeiros x [] = False
nosPrimeiros x ((a,b):t) = if x == a then True else nosPrimeiros x t

{- (i) sumTriplos :: (Num a, Num b, Num c) => [(a,b,c)] -> (a,b,c) soma uma
lista de triplos componente a componente.
Por exemplo, sumTriplos [(2,4,11), (3,1,-5), (10,-3,6)] = (15,2,12) -}

sumTriplos :: (Num a, Num b, Num c) => [(a,b,c)] -> (a,b,c)
sumTriplos [] = (0,0,0)
sumTriplos ((a1,b1,c1):t) = (a1+x,b1+y,c1+z)
                            where (x,y,z) = sumTriplos t

{- 3. Recorrendo a funções do módulo Data.Char, defina recursivamente as seguintes funções
sobre strings: -}

{- (a) soDigitos :: [Char] -> [Char] que recebe uma lista de caracteres, e selecciona
dessa lista os caracteres que são algarismos. -}

soDigitos :: [Char] -> [Char]
soDigitos [] = []
soDigitos (h:t) = if isDigit' h then [h] ++ soDigitos t else soDigitos t

--(b) minusculas :: [Char] -> Int que recebe uma lista de caracteres, e conta quantos desses caracteres são letras minúsculas.

minusculas :: [Char] -> Int
minusculas [] = 0
minusculas (h:t) = if elem h ['a'..'z'] then 1 + minusculas t else minusculas t

{- (c) nums :: String -> [Int] que recebe uma string e devolve uma lista com os
algarismos que occorem nessa string, pela mesma ordem.-}

nums :: String -> [Int]
nums [] = []
nums (h:t) = if elem h ['0'..'9'] then (ord h - ord '0') : nums t else nums t

--4. Uma forma de representar polinómios de uma variável é usar listas de monómios representados por pares (coeficiente, expoente)

type Polinomio = [Monomio]
type Monomio = (Float,Int)

{-Por exemplo, [(2,3), (3,4), (5,3), (4,5)] representa o polinómio 2 x^3 + 3 x^4 + 5 x^3 + 4 x^5
Defina as seguintes funções: -}

--(a) conta :: Int -> Polinomio -> Int de forma a que (conta n p) indica quantos monómios de grau n existem em p.

conta :: Int -> Polinomio -> Int
conta x [] = 0
conta x ((n,g):t) = if x == g then 1 + conta x t else conta x t

--(b) grau :: Polinomio -> Int que indica o grau de um polinómio.

grau :: Polinomio -> Int
grau [] = 0
grau [(n1,g1)] = g1
grau ((n1,g1):(n2,g2):t) = if g1 < g2 then grau ((n2,g2):t) else grau ((n1,g1):t)

{- (c) selgrau :: Int -> Polinomio -> Polinomio que selecciona os monómios com
um dado grau de um polinómio.  -}

selgrau :: Int -> Polinomio -> Polinomio
selgrau n [] = []
selgrau sg ((n1,g1):t) = if sg == g1 then (n1,g1):selgrau sg t else selgrau sg t

--(d) deriv :: Polinomio -> Polinomio que calcula a derivada de um polinómio.

deriv :: Polinomio -> Polinomio
deriv [] = []
deriv ((n1,g1):t) = if g1 > 0 then (n1 * (fromIntegral g1),g1 - 1): deriv t else  (n1,g1) : deriv t

{- (e) calcula :: Float -> Polinomio -> Float que calcula o valor de um polinómio
para uma dado valor de x. -}

calcula :: Float -> Polinomio -> Float
calcula x [] = 0
calcula x ((n1,g1):t) = if g1 > 0 then (n1 * (x^g1) + calcula x t) else calcula x t

{- (f) simp :: Polinomio -> Polinomio que retira de um polinómio os monómios de
coeficiente zero. -}

simp :: Polinomio -> Polinomio
simp [] = []
simp ((n1,g1):t) = if g1 == 0 then simp t else (n1,g1) : simp t

--(g) mult :: Monomio -> Polinomio -> Polinomio que calcula o resultado da multiplicação de um monómio por um polinómio.

mult :: Monomio -> Polinomio -> Polinomio
mult _ [] = []
mult (n1,g1) ((n2,g2):t) = (n1*n2, g1*g2) : mult (n1,g1) t

{- (h) normaliza :: Polinomio -> Polinomio que dado um polinómio constrói um
polinómio equivalente em que não podem aparecer varios monómios com o mesmo
grau. -}

normaliza :: Polinomio -> Polinomio
normaliza [] = []
normaliza ((n1,g1):t) = let lgi = selgrau g1 t
                            lgd = selgrau g1 t
                            x2 = sumRep ((n1,g1):lgi)
                            in if(x2==0) then normaliza lgd else (x2,g1):(normaliza lgd)

sumRep :: Polinomio -> Float
sumRep [] = 0
sumRep ((n1,g1):t) = n1 + sumRep t

{- Outra maneira de fazer:

selgrau :: Int -> Polinomio -> (Polinomio,Polinomio)
selgrau n [] = ([],[])
selgrau sg ((n1,g1):t) =  if sg == g1 then (((n1,g1):a),b) else (a, ((n1,g1):b))
                            where (a,b) = selgrau sg t

-- soma todos os coeficientes de um polinomio
sumRep :: Polinomio -> Float
sumRep [] = 0
sumRep ((n1,g1):t) = n1 + sumRep t


normaliza :: Polinomio -> Polinomio
normaliza [] = []
normaliza ((c,g) : t) = ((sumRep a),g) : normaliza b
                        where (a,b) = selgrau g ((c,g) : t)
-}

{- (i) soma :: Polinomio -> Polinomio -> Polinomio que faz a soma de dois polinómios
de forma que se os polinómios que recebe estiverem normalizados produz também
um polinómio normalizado. -}

soma::Polinomio->Polinomio->Polinomio
soma p1 p2 = normaliza(p1++p2)

--(j) produto :: Polinomio -> Polinomio -> Polinomio que calcula o produto de dois polinómios

produto :: Polinomio -> Polinomio -> Polinomio
produto [] _ = []
produto _ [] = []
produto (p1:t) p2 = mult p1 p2 ++ produto t p2

--(k) ordena :: Polinomio -> Polinomio que ordena um polonómio por ordem crescente dos graus dos seus monómios.

ordena :: Polinomio -> Polinomio
ordena [] = []
ordena ((n1,g1):t) = insertP (n1,g1) (ordena t)
                     where insertP :: Monomio -> Polinomio -> Polinomio
                           insertP (n1,g1) [] = [(n1,g1)]
                           insertP (n1,g1) ((n2,g2):t) = if g1 < g2 then (n1,g1):((n2,g2):t) else (n2,g2) : insertP (n1,g1) t

--(l) equiv :: Polinomio -> Polinomio -> Bool que testa se dois polinómios são equivalentes

equiv :: Polinomio -> Polinomio -> Bool
equiv p1 p2 = ordena(normaliza p1) == ordena(normaliza p2)


-------------------------------------------------------------------- 3º Ficha --------------------------------------------------------------------

{- 1. Assumindo que uma hora é representada por um par de inteiros, uma viagem pode ser representada por uma sequência de etapas, onde cada 
etapa é representada por um parde horas (partida, chegada): -}

type Etapa = (Hora',Hora')
type Viagem = [Etapa]

{- Por exemplo, se uma viagem for
[(H 9 30, H 10 25), (H 11 20, H 12 45), (H 13 30, H 14 45)] significa que teve três etapa:
• a primeira começou às 9 e meia e terminou às 10 e 25;
• a segunda começous 11 e 20 e terminou  uma menos um quarto;
• a terceira começou às 1 e meia e terminou às 3 menos um quarto;
Para este problema, vamos trabalhar apenas com viagens que come¸cam e acabam no
mesmo dia. Utilizando as funções sobre horas que definiu na Ficha 1, defina as seguintes
funções:
(a) Testar se uma etapa está bem construída (i.e., o tempo de chegada é superior ao de partida e as horas são válidas). -}

verificaEtapa :: Etapa -> Bool
verificaEtapa (h1,h2) = hDepois' h1 h2

{- (b) Testa se uma viagem está bem construída (i.e., se para cada etapa, o tempo de chegada é superior ao de partida, e se a etapa 
seguinte começa depois da etapa anterior ter terminado). -}

valiViagem :: Viagem -> Bool
valiViagem [] = True
valiViagem [x] = verificaEtapa x
valiViagem (e1:e2:t) = verificaEtapa e1 && verificaEtapa (snd e1, fst e2) && valiViagem (e2:t) 

--(c) Calcular a hora de partida e de chegada de uma dada viagem.

startEnd :: Viagem -> Etapa
startEnd [x] = x
startEnd x = (fst (head x), snd (last x))

--(d) Dada uma viagem válida, calcular o tempo total de viagem efectiva.

vValida :: Viagem -> Int
vValida [] = 0
vValida ((h1,h2) :t) = difM' h2 h1 + vValida t

--(e) Calcular o tempo total de espera.

tempoEspera :: Viagem -> Int
tempoEspera ((a,b):(c,d):t) = difM' b a + tempoEspera ((c,d):t)
tempoEspera _ = 0

--(f) Calcular o tempo total da viagem (a soma dos tempos de espera e de viagem efectiva).

tempoTotal :: Viagem -> Int
tempoTotal x = vValida x + tempoEspera x

-- 2. Considere as seguinte definição de um tipo para representar linhas poligonais.

type Poligonal = [Ponto]
-- Relembrar: data Ponto = Cartesiano Double Double | Polar Double Double deriving (Show,Eq)

{-- O tipo Ponto é idêntico ao definido na Ficha 1. Nas resolução das alíneas seguintes
pode utilizar funções definidas nessa ficha. -}

--(a) Defina a função para calcular o comprimento de uma linha poligonal.

lenPoligonal :: Poligonal -> Double
lenPoligonal (x:y:xs) = dist' x y + lenPoligonal (y:xs) 
lenPoligonal _ = 0

--(b) Defina uma função para testar se uma dada linha poligonal é ou não fechada.

closePoligonal :: Poligonal -> Bool
closePoligonal l = if (dist' (head l) (last l)) == 0 then True else False

{-(c) Defina a função triangula :: Poligonal -> [Figura] que, dada uma linha
poligonal fechada e convexa, calcule uma lista de triângulos cuja soma das áreas
seja igual à área delimitada pela linha poligonal. O tipo Figura é idêntico ao
definido na Ficha 1. -}

formaTri :: Poligonal -> [Figura]
formaTri (x:y:z:xs) = (Triangulo x y z) : formaTri (x:z:xs)
formaTri _ = []


--(d) Defina uma função para calcular a área delimitada por uma linha poligonal fechada e convexa.

areaPoligonal :: Poligonal -> Double
areaPoligonal l = aux (formaTri l)
                  where aux::[Figura]->Double
                        aux [] = 0
                        aux (x:xs) = area  x + aux xs

{- (e) Defina a função mover :: Poligonal -> Ponto -> Poligonal que, dada uma
linha poligonal e um ponto, dá como resultado uma linha poligonal idêntica à
primeira mas tendo como ponto inicial o ponto dado. -}

mover :: Poligonal -> Ponto -> Poligonal
mover pol p = p:pol

{- (f) Defina a função zoom :: Double -> Poligonal -> Poligonal que, dada um
factor de escala e uma linha poligonal, dê como resultado uma linha poligonal
semelhante e com o mesmo ponto inicial mas em que o comprimento de cada
segmento de recta é multiplicado pelo factor dado. -}

zoom :: Double -> Poligonal -> Poligonal
zoom z [p1@(Cartesiano x y),p2@(Cartesiano a b)] = p1:(Cartesiano (z*a) (z*b)):[]
zoom z (p1@(Cartesiano x y):p2@(Cartesiano a b):pol) = p1:zoom z (p3:pol)
    where p3 = (Cartesiano (z*a) (z*b))

{- Nota ::

There's also a thing called as patterns. Those are a handy way of breaking something up according to a pattern and binding it to names whilst still
keeping a reference to the whole thing. You do that by putting a name and an @ in front of a pattern. For instance, the pattern xs@(x:y:ys). This 
pattern will match exactly the same thing as x:y:ys but you can easily get the whole list via xs instead of repeating yourself by typing 
out x:y:ys in the function body again. Here's a quick and dirty example:

capital :: String -> String  
capital "" = "Empty string, whoops!"  
capital all@(x:xs) = "The first letter of " ++ all ++ " is " ++ [x]

ghci> capital "Dracula"  
"The first letter of Dracula is D"  

-}

{- 3. Para armazenar uma agenda de contactos telefónicos e de correio electrónico definiramse os seguintes tipos de dados. Não existem nomes 
repetidos na agenda e para cada nome existe uma lista de contactos. -}

data Contacto = Casa Integer | Trab Integer | Tlm Integer | Email String deriving Show
type Nome' = String
type Agenda = [(Nome', [Contacto])]

--(a) Defina a função acrescEmail :: Nome' -> String -> Agenda -> Agenda que, dado um nome, um email e uma agenda, acrescenta essa informação à agenda.

acrescEmail :: Nome' -> String -> Agenda -> Agenda
acrescEmail nome email agenda = agenda ++ [(nome,[Email email])]

{- (b) Defina a função verEmails :: Nome' -> Agenda -> Maybe [String] que, dado
um nome e uma agenda, retorna a lista dos emails associados a esse nome. Se esse
nome não existir na agenda a função deve retornar Nothing. -}

verEmails :: Nome' -> Agenda -> Maybe [String]
verEmails nome [(nom, cont)] = if nome == nom then Just (map (\x -> case x of Email e -> e) cont) else Nothing
verEmails nome ((nom,cont): agenda) = if nome == nom then verEmails nome [(nom,cont)] else verEmails nome agenda

{- (c) Defina a função consTelefs :: [Contacto] -> [Integer] que, dada uma lista
de contactos, retorna a lista de todos os números de telefone dessa lista (tanto
telefones fixos como telemóveis). -}

consTelefs :: [Contacto] -> [Integer]
consTelefs [] = []
consTelefs (c:cs) = case c of Casa x -> x : consTelefs cs
                              Trab x -> x : consTelefs cs
                              Tlm x -> x : consTelefs cs
                              otherwise -> consTelefs cs

--(d) Defina a função casa :: Nome' -> Agenda -> Maybe Integer que, dado um nome e uma agenda, retorna o número de telefone de casa (caso exista).

casa :: Nome' -> Agenda -> Maybe Integer
casa nome [(n,(c:cs))] = if nome == n then case c of Casa x -> Just x
                                                     otherwise -> casa nome [(n,cs)] 
                                      else Nothing
casa nome ((n,c):agenda) = if nome == n then casa nome [(n,c)] else casa nome agenda

{- 4. Pretende-se guardar informação sobre os aniversários das pessoas numa tabela que
associa o nome de cada pessoa à sua data de nascimento. Para isso, declarou-se a
seguinte estrutura de dados: -}

type Dia = Int
type Mes = Int
type Ano = Int
type Nome = String
data Data' = D' Dia Mes Ano deriving Show
type TabDN = [(Nome,Data')]

--(a) Defina a função procura :: Nome -> TabDN -> Maybe Data', que indica a data de nascimento de uma dada pessoa, caso o seu nome exista na tabela.

procura :: Nome -> TabDN -> Maybe Data'
procura nome ((nom,dat):tabDn) = if nome == nom then Just dat else procura nome tabDn

--(b) Defina a função idade :: Data' -> Nome -> TabDN -> Maybe Int, que calcula a idade de uma pessoa numa dada data.

idade :: Data' -> Nome -> TabDN -> Maybe Int
idade (D' d1 m1 a1) nome ((nom,(D' d2 m2 a2 )):t) | nome /= nom = idade (D' d1 m1 a1) nome t
                                                  | a1 < a2 || (a1 == a2 && m1 < m2) = Just 0
                                                  | m1 < m2 || (m1 == m2 && d1 < d2) = Just (a1-a2-1)
                                                  | otherwise = Just (a1-a2)

--(c) Defina a função anterior :: Data' -> Data' -> Bool, que testa se uma data é anterior a outra data.

anterior :: Data' -> Data' -> Bool
anterior (D' d1 m1 a1) (D' d2 m2 a2) = if  (a1<a2) || (a1 == a2 && m1 < m2) || (a1 == a2 && m1 == m2 && d1 < d2) then True else False

--(d) Defina a função ordena :: TabDN -> TabDN, que ordena uma tabela de datas de nascimento, por ordem crescente das datas de nascimento.

ordena' :: TabDN -> TabDN
ordena' [] = []
ordena' ((nom,dat):t) = aux (nom,dat)  (ordena' t)
                       where aux (no,da) [] = [(no,da)]
                             aux (no,da) ((n,d):t) = if (anterior da d) == False then (n,d) : aux (no,da) t else (no,da) : aux (n,d) t       

--(e) Defina a função porIdade:: Data' -> TabDN -> [(Nome,Int)], que apresenta o nome e a idade das pessoas, numa dada data, por ordem crescente da idade das pessoas.

porIdade:: Data' -> TabDN -> [(Nome,Int)]
porIdade _ [] = []
porIdade (D' d1 m1 a1) tabDn = (nom,idade) : porIdade (D' d1 m1 a1) tabDn
                                where ((nom,(D' d' m' a')):t) = ordena' tabDn
                                      idade = if (m1 < m' || (m1 == m' && d1 < d')) then (a1-a'-1) else (a1-a')

{- 5. Considere o seguinte tipo de dados que descreve a informação de um extracto bancário.
Cada valor deste tipo indica o saldo inicial e uma lista de movimentos. Cada movimento
é representado por um triplo que indica a data da operação, a sua descrição e a quantia
movimentada (em que os valores são sempre números positivos). -}

data Movimento = Credito Float | Debito Float deriving Show
data Data = D Int Int Int deriving Show
data Extracto = Ext Float [(Data, String, Movimento)] deriving Show

--(a) Construa a função extValor :: Extracto -> Float -> [Movimento] que produz uma lista de todos os movimentos (créditos ou débitos) superiores a um determinado valor.

extValor :: Extracto -> Float -> [Movimento]
extValor (Ext si []) val = []
extValor (Ext si ((_,_,Credito x):t)) val = if x > val then (Credito x) : extValor (Ext si t) val else extValor (Ext si t) val 
extValor (Ext si ((_,_,Debito x):t)) val = if x > val then (Debito x) : extValor (Ext si t) val else extValor (Ext si t) val 

{-(b) Defina a função filtro :: Extracto -> [String] -> [(Data,Movimento)] que retorna informação relativa apenas aos movimentos cuja descrição esteja incluída
na lista fornecida no segundo parâmetro. -}

filtro :: Extracto -> [String] -> [(Data,Movimento)]
filtro (Ext si []) _ = []
filtro (Ext si ((d,s,mov):t)) st = if elem s st then (d,mov) : filtro (Ext si t) st else  filtro (Ext si t) st

{- (c) Defina a função creDeb :: Extracto -> (Float,Float), que retorna o total de créditos e de débitos de um extracto no primeiro e segundo elementos de um par,
respectivamente. -}

creDeb :: Extracto -> (Float,Float)
creDeb (Ext si resto) = (cred resto, deb resto)
                                where cred :: [(Data, String, Movimento)] -> Float
                                      cred [] = 0
                                      cred ((d,s,Credito x):t) = x + cred t
                                      cred ((d,s,Debito x):t) = cred t
                                      deb :: [(Data, String, Movimento)] -> Float
                                      deb [] = 0
                                      deb ((d,s,Debito x):t) = x + deb t
                                      deb ((d,s,Credito x):t) = deb t

--(d) Defina a função saldo :: Extracto -> Float que devolve o saldo final que resulta da execução de todos os movimentos no extracto sobre o saldo inicial.

saldo :: Extracto -> Float
saldo (Ext si resto) = si + d - c
                       where (d,c) = creDeb (Ext si resto)