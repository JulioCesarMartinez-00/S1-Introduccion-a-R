
#######################################################
#                   Funciones
#######################################################



#=====================================================
# Ejercicio 1: Escribir una funci�n que nos calcule la 
#              media dado un vector.

# mean = 1/n sum x_i, i = 1:n


# llamar a la funci�n "my_mean"
my_mean <- function(x){
  # cuenta el n�mero de valores de x
  count <- 0 
  # suma los valores de x
  sum <- 0
  # iteraci�n del vector
  for(i in 1:length(x)){
    count <- count +1
    sum <- sum + x[i]
  }
  # salida de la funci�n
  return(sum/count)
}
#=====================================================
# vector
x <- c(2, 3, 4, 5, 6, 7, 8, 9)

mean_x <- my_mean(x)
mean_x

# Supongamos que tenemos un dato faltante en nuestro vector.

# vector
x <- c(1, 2, 3, 4, 5, 6, NA, 7, 8, 9, 10)

# Calculamos la media del vector
my_mean(x)


# Nuestra funci�n my_mean() no nos permite excluir 
# valores faltantes, entonces necesitamos crear una
# que excluya los valores faltantes.

#=====================================================
#  Funci�n para obtener la media con datos faltantes

# Funci�n
my_mean2 <- function(x){
  count <- 0
  sum <- 0
  for(i in 1:length(x)){
    if(is.na(x[i])){
      next
    }else{
      count <- count + 1
      sum <- sum + x[i]
    }
    
  }
  return(sum/count)
}
#=====================================================
# Ejemplo:
# vector
x <- c(1, 2, 3, 4, 5, 6, NA, 7, 8, 9, 10)

# Calculamos la media del vector
my_mean2(x)


#=====================================================
# Funci�n para obtener la media con datos faltantes
# con un argumento adicional
my_mean3 <- function(x, rm.na=TRUE){
  count <- 0
  sum <- 0
  for(i in 1:length(x)){
    # Se ejecuta este if si rm.na=TRUE
    if(rm.na){
      if(is.na(x[i])){
        next
      }else{
        count <- count + 1
        sum <- sum + x[i]
      }
    # de otro modo, si rm.na=FALSE se ejecuta las siguientes l�neas
    }else{
      count <- count + 1
      sum <- sum + x[i]
    }
  }
  return(sum/count)
}
#====================================================

# vector
x <- c(1, 2, 3, 4, 5, 6, NA, 7, 8, 9, 10)

# Calculamos la media del vector
# se remueven datos faltantes
my_mean3(x, rm.na=TRUE)  

# no se remueven los datos faltantes
my_mean3(x, rm.na=FALSE)
