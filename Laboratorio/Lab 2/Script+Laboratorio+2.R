##################
# Laboratorio 02 # By Natu
##################

# Cargar base de datos en otro formato: .dta
# Se debe cargar librer�a

library(foreign)
data = read.dta("RentasMunich.dta")

head(data)
dim(data)
summary(data)
cbind(names(data))

 par(mar=c(5.1,5.1,4.1,2.1))
 curve(100*(x^3-x^2)+15, 0, 1,
 	xlab=expression(alpha),
 	ylab=expression(100%*%(alpha^3-alpha^2)+15),
 	main=expression(
 		paste("Funcion: ",
 			f(alpha)==100%*%(alpha^3-alpha^2)+15)))
 sigma1=1.2
 text(0.1,3,bquote(sigma[alpha]==.(sigma1)))
 text(0.8,11,expression(sigma[alpha]==0.25))

plot(data$rent ~ data$area, 
xlab=expression("Tama�o del departamento "*"[m"^2*"]"), 
ylab="Precio de renta [�]",
main="Precio de renta por tama�o, Munich 1999")

# BOXPLOT RENTA
boxplot(data$rentsqm)
boxplot(data$rentsqm,main="Boxplot de Renta por metro cuadrado")

hist(data$rentsqm)
hist(data$rentsqm,main="Histograma de Renta por metro cuadrado",
	xlab="Renta por metro cuadrado",
	ylab="Frecuencia")

boxplot(data$rent~data$location,
xlab="Localizaci�n",
ylab="Renta")
# COMENTARIO: Ah no pero que feo con 1 2 3 �Vamos a cambiar esos nombres!

data$Localizaci�n <- ifelse(data$location == 1, "Promedio",
	ifelse(data$location == 2,"Bueno",
	"Alta"))

# COMENTARIO: �J�! a la data original le a�adimos una nueva variable.

boxplot(data$rent~data$Localizaci�n,
xlab="Localizaci�n",
ylab="Renta")
title("Valor de la renta seg�n la localizaci�n")

data$Ba�o <- ifelse(data$bath == 0, "Estandar","Premium")
barplot(table(data$Ba�o,data$Localizaci�n))
barplot(table(data$Ba�o,data$Localizaci�n),
        beside=TRUE,ylim=c(0,2000),
main="Distribuci�n de Ba�os",
        legend=FALSE)

data$Cocina <- ifelse(data$kitchen == 0, "Estandar","Premium")
barplot(table(data$Cocina,data$Localizaci�n))
barplot(table(data$Cocina,data$Localizaci�n),
beside=TRUE,ylim=c(0,2000),
main="Distribuci�n de Ba�os",
legend=FALSE)

data$Calefaccion <- ifelse(data$cheating == 0, "No tiene","Tiene")
boxplot(data$rentsqm~data$Calefaccion )
boxplot(data$rentsqm~data$Calefaccion , 
	xlab = "Calefacci�n", 
	ylab="Renta por metro cuadrado",
	main="Renta por metro cuadrado vs. presencia de Calefacci�n")
