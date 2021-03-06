####################################
# Laboratorio 05 post Evaluaci�n 2 #
####################################

# Vamos a retomar la estad�stica descriptiva 
# Y la aplicaremos a una variable aleatoria discreta:
# HIPERGEOM�TRICA.
# En R la hipergeom�trica se describe diferente a clases:

# En clases la hipergeom�trica se define por un lote de tama�o N
# donde m son defectuosos y en consecuencia 'N-m' son no defectuosos.
# luego se toma una muestra aleatoria de tama�o n y 
# la probabilidad que x sean defectuosos esta dada por 
# la funci�n de probabilidad de la distribuci�n hipergeom�trica

# Aqu�, en R, la hipergeom�trica se define por una urna con 
# m bolas blancas y n bolas negras. 
# Se realiza una extracci�n de tama�o k y 
# x representa el n�mero de bolas blancas extra�das 

# Sus funciones son:
# dhyper(x, m, n, k, log = FALSE)
# phyper(q, m, n, k, lower.tail = TRUE, log.p = FALSE)
# qhyper(p, m, n, k, lower.tail = TRUE, log.p = FALSE)
# rhyper(nn, m, n, k)

# Su media te�rica es k*p con p = m/(m+n).
# y varianza  k*p*(1 - p) * (m+n-k)/(m+n-1)


# Hay una urna con 17 bolas blancas y 23 negras, 
# si se extraen 15 bolas al azar, 
# �cu�l es la distribuci�n de las bolas blancas extra�das?

# X ~ Hypergeom(17,23,15) EN LENGUAJE R

# Simule una muestra de tama�o 120 de la v.a. anterior.

set.seed(1113)
m = 17
n = 23
k = 15
X = rhyper(120,m,n,k)

# Visualizamos
barplot(table(X))

# Medidas centrales muetrales

# media muestral
mean(X)

# media te�rica k * p, con p = m/(m+n)
p = m/(m+n)
k * p

# moda
filtro = (table(X) == max(table(X)))
table(X)[filtro]

# mediana
median(X) 
 # En algunos procedimientos es preferible elegir
 # la mediana en vez de la media, porque la mediana 
 # pertenece a dominio de la variable aleatoria, 
 # en este caso los enteros desde 0 hasta m  


# Esperanza g(X) = X^2
g = function(X){X^2}
mean(g(X))

# < Forma corta, qu�dense con esa, 
# pero hay otra m�s larga y es bueno que la entiendan

x=as.numeric(names(table(X))) # los valores que toma x
x
px=as.numeric(table(X))/120 # sus probabilidades
px
# Luego, aplicando la materia para v.a. discreta: sumatoria x^2 * px
sum(x^2*px)

# percentiles 10%, 20%,...
 # muestrales
quantile(X,1:10/10)

# percentiles te�ricos:
qhyper(1:10/10,m,n,k)

# Varianza
# Muestral directa con R
var(X)

# Mediante sumatoria
mediaX = mean(X)
sum((x-mediaX)^2*px)

# �No da igual!
# R realiza una correci�n a la varianza
# Sea largoX el largo del vector X, entonces 
# varianza = sumatoria *largoX/(largo-X) debe dar lo mismo que la sumatoria
largoX = length(X)
sum((x-mediaX)^2*px)*largoX/(largoX-1) 
var(X)

# Te�rica, porque sabemos los verdaderos valores de los par�metros:
k*p*(1 - p) * (m+n-k)/(m+n-1)

# rango
range(X) # no entrega el rango, solo min y max
max(X)-min(X)

# Rango intercuantil
IQR= quantile(X, 0.75) - quantile(X, 0.25)
# podr�an crear una funci�n para esto.

# desviaci�n est�ndar
sd(X)
sqrt(var(X))

# Coeficiente de variacion
sd(X)/mean(X)

# Asimetr�a y curtosis, ejecuten las funciones:
Skewness = function(x){
n = length(x)
sum((x - mean(x))^3/n)/sd(x)^3
}
Kurtosis = function(x){
n = length(x)
sum((x - mean(x))^4/n)/sd(x)^4-3
}

Skewness(X)
Kurtosis(X)

# Obvio que ya existen packages que lo calculan,
# pero as� practican crear funciones y usarlas.


# Para la covarianzas y correlaci�n necesitamos dos variables
# Sea Y ~ Binomial(k,p) 
# Simulemos una muestra de tama�o 120 con los mismos k y p anteriores.

set.seed(1113)
Y = rbinom(120,k,p)
# Visualicemos
barplot(table(Y))
plot(X,Y)

# Covarianza
cov(X,Y)

 # camino largo
mediaY=mean(Y)
mean((X-mediaX)*(Y-mediaY))
 # corrigiendo 
mean((X-mediaX)*(Y-mediaY))*largoX/(largoX-1) 
 # da igual a cov(X,Y)

# Correlaci�n
cor(X,Y)

cov(X,Y)/(sd(X)*sd(Y))