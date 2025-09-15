### P&A 2021/2022 LCC
### Exercícios 
### (código R)


################################
##########  EXERC. 1  ##########
################################

### (a) uma simulação de totoloto (6 extracções sem reposição; 49 bolas):

sample(1:49,6)

### (b) simul. meses de nascimento (numerados 1:12, equiprov.) 
###	    e género (F/M, na proporção de 5 para 4). 
###         No comando "sample": "prob" podem ser proporções (não têm que somar 1)

sample(1:12, 100, rep=T)
sample(c("F","M"), 100, rep=T, prob=c(5,4))

	# (b+) organizar os dados (bivariados) numa tabela de dupla entrada:
	mes <- sample(1:12, 100, rep=T)
	gen <- sample( c("F","M"), 100, rep=T, prob=c(5,4) )
	table(gen,mes)

	# (b++) corresp. gráfico de barras com freq.absol. dos meses por género
	barplot(table(gen,mes),beside=T,col=c(5,7),xlab="mês",ylab="freq. absol.",las=1)
	legend("topright", c("F","M"), inset=0.05, fill=c(5,7))

### (c) simul. n lanç de dado equil.; tabela de freq. relat. (nº pintas)

n <- 60; table(sample(1:6, n, rep=T))/n
n <- 6000; table(sample(1:6, n, rep=T))/n
n <- 600000; table(sample(1:6, n, rep=T))/n
# compare as freq. relat. com o valor 1/6 = 0.1666667 para as 3 simulações

### (d) soma de pintas no lanç. de 2 dados equil.; distr. prob. teórica;
###     r simul., freq. relat. (comparar com probs)

r <- 100; table(sample(1:6,r,rep=T)+sample(1:6,r,rep=T))/r
d.teor <- c(1:6/36,5:1/36); names(d.teor) <- 2:12; d.teor

# repetir para r <- 1000, r <- 10^5, e depois comparar com d.teor acima:
r <- 10^5; t <- table(sample(1:6,r,rep=T)+sample(1:6,r,rep=T))/r ; t
# o mesmo, usando a função "replicate":
r <- 10^5; t <- table(replicate(10^5, sum(sample(1:6,2,rep=T))))/r ; t

# diferença entre as freq. relat. obtidas na simulação e as probs exactas:
t-d.teor
# a maior das discrepâncias absolutas (tende a diminuir quando r aumenta):
max(abs(t-d.teor))

### (e) simul. sequência de símbolos A,G,T,C c/ probs dadas, por ex. na 
###	    proporção 1:3:2:1, ou seja, com probs 1/7, 2/7, 3/7, 1/7.
 
bases <- sample(c("A","G","T","C"),100,rep=T,prob=c(1,3,2,1))
	
	# (e+) tabela e gráfico de freq. relat.:
	table(bases)/100
	barplot(table(bases)/100,col=5)


################################
##########  EXERC. 2  ##########
################################

########  Estimar 1) P("soma dos 6 nºs num totoloto ser < 50"); bolas 1 a 49
########          2) a distribuição dessa soma (ambas usando simulação).
### 	fazer com r=10^4 simulações, com r=10^6 simulações e comparar resultados
### 	(a precisão é maior quando o nº réplicas r aumenta)

soma <- 0 ; r <- 10^6
for (i in 1:r) soma[i] <- sum(sample(1:49,6))
sum(soma<50)/r  
# o resultado anterior deverá ser aprox. 0.00045 
	
plot(table(soma))
## variante com histograma (de área unitária):
hist(soma,60,freq=F)
# E a verdadeira probabilidade? Dá para calcular? Sim... 

# gráfico de freq. relativas:
plot(table(soma)/r)
## variante com histograma:
hist(soma,60,freq=F)

	# (2+) qual a prob de que a soma seja 21 (note que 21 = 1+2+3+4+5+6)?
	1/choose(49,6)      # o resultado é 7.151124e-08
	# e a estimativa? Executar table(soma)[1:5] e concluir... (ooops!)


#################################
##########  EXERC. 3  ########### 
#################################
 
### opinar sobre soma de duas uniformes no intervalo [0,1], usando simulação.

r <- 10^5; hist(runif(r)+runif(r), 50, freq=F, xlab="soma",cex.main=1,
   main= "histograma da soma de dois nºs uniformes em [0,1] (100 mil réplicas)")
# ficamos com uma distribuição aproximadamente "triangular";
# conclui-se ainda que "a soma de duas uniformes (independentes) não é uniforme".

# Em alternativa, pode usar-se a função "replicate":
hist(replicate(10^5, sum(runif(2))), 50, freq=F, xlab="soma",cex.main=1,
   main= "histograma da soma de dois nºs uniformes em [0,1] (100 mil réplicas)")


#################################
##########  EXERC. 4  ########### 
#################################

# passeio aleatório simétrico (cara:+1, coroa:-1) e trajectória em 200 passos: 
n <- 200  
moed <- sample(c(-1,1), n, replace=T) 	# versão 1 (simulação com sample)
moed <- 2*rbinom(n,1,0.5)-1		# versão 2 (simulação com rbinom)
plot(0:n,cumsum(c(0,moed)),type="l",col=2,xlab="nº jogos", ylab="fortuna")
abline(h=0, col=8)

# com uma única linha de comando, para fazer várias traject. mais rapidamente:
n <- 2000; plot(0:n,cumsum(c(0,2*rbinom(n,1,0.5)-1)),type="l",col=2,
		xlab="nº jogos", ylab="fortuna");abline(h=0, col=8)
 

#################################
##########  EXERC. 5  ########### 
#################################

# cotação de empresa (desce 1, mantém-se, sobe 1, com probs 0.39, 0.2, 0.41)

### (a) simular variação da cotação ao fim de 20 dias:
sum( sample(-1:1, 20, rep=T, prob=c(0.39, 0.20, 0.41)) )

### (b) estimar prob 
##      (i) de ao fim de 20 dias a cotação subir mais que 5 euros
##     (ii) dos diferentes valores da alteração ao fim de 20 dias; gráfico

s20 <- 0;  p <- c(0.39, 0.20, 0.41); r <- 10^5
for (i in 1:r) s20[i] <- sum( sample(-1:1, 20, rep=T, prob=p) )
sum(s20>5)/r  # estimativa para (i) foi 0.10185
table(s20)/r
plot(table(s20)/r)
## comentar: curva aprox. normal?


#################################
##########  EXERC. 6  ########### 
#################################

### estimar, no problema dos encontros, a prob p_n de, em n extr. s/
### repos. de uma urna c/ bolas 1:n, haver pelo menos 1 encontro; 
### e também a prob de haver j enc. (j=1, 2, ..., n)

# estimativas das prob de haver j encontros (j=1,2,...,n):
n <- 20 ; r <- 10^5
enc <- 0; for (i in 1:r)  enc[i] <- sum(1:n - sample(1:n,n) == 0)
table(enc)/r
# estimativa da prob p_n (n fixado acima) de haver pelo menos um encontro:
1-table(enc)[1]/r

# obter estimativas de p_n para n = 5, 10, 15, repetindo o código anterior.

# verdadeiro p_n (cf. fórmula obtida pela regra de inclusão/excusão):
sum( (-1)^(1:n+1) / factorial(1:n) )
# o limite em n é 1-exp(-1) = 0.6321206 (ver slides T: slide 26)
# probs p_n até n=12:
n <- 12; cumsum( 1/factorial(1:n)*(-1)^(2:(n+1)) ) # probs p_n










