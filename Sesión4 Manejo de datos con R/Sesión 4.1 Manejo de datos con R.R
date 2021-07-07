
#######################################################
#   Manejo de datos con R
#######################################################

# Lectura de datos.
# %>%       : Operador pip
# select()  : selecciona variables (columnas) por su nombre.
# filter()  : seleccionar (filtrar) filas dada una condición.
# arrange() : ordenar valors de una (varias) varible(s) de forma ascendente o descendente.
# mutate()  : crea nuevas variables a partir de variables existentes.


##########################################################
#          Lectura de archivo csv

df1 <- read.csv('./datasets/iris.csv')
head(df1)

# header para indicar encabezados
df2 <- read.csv('./datasets/iris.csv', header=TRUE)
head(df2)

# agregar nombres de columnas 
df3 <- read.csv('./datasets/iris.csv', 
                header=TRUE, 
                col.names=c('Sepal_Length', 'Sepal_Width', 'Petal_Length', 'Petal_Width', 'Species'))
head(df3)


# para guardar un data frame en formato csv 
write.csv(df3, './datasets/iris2.csv', row.names=FALSE)


##########################################################
#          Lectura de archivo csv

# csv separado por ;
df4 <- read.csv('./datasets/iris2.csv', sep=";")
head(df4)


# csv separado por "-"
df5 <- read.csv('./datasets/iris3.csv', sep="-")
head(df5)

##########################################################
#       Lectura de archivos de excel

library(readxl)

df6 <- read_excel("./datasets/iris.xlsx")
head(df6)


# código para consolidar varias hojas de excel en un sólo data frame
sheets = 1:3

for(i in 1:length(sheets)){
  if(i == 1){
    df_iris_1 <- read_excel("./datasets/iris.xlsx", sheet=i)
  }else{
    df_iris_n <- read_excel("./datasets/iris.xlsx", sheet=i)
    df_iris_1 <- rbind(df_iris_1, df_iris_n)
  }
}

# mostramos los primeros valores
head(df_iris_1)

# verificamos las dimensiones
dim(df_iris_1)

####################################################
#   Lectura de datos de la web 

# La información se encuentra disponible en la siguiente liga: 
#  https://www.gob.mx/salud/documentos/datos-abiertos-152127.

# creación de un archivo temporal
temp <- tempfile()
# descargar archivo .zip al archivo temporal
download.file("http://datosabiertos.salud.gob.mx/gobmx/salud/datos_abiertos/datos_abiertos_covid19.zip",temp)
# lectura del archivo .csv deltro del .zip
covid_mex <- read.csv(unz(temp,'210705COVID19MEXICO.csv'))
# remueve archivos temporales
unlink(temp)

head(covid_mex)


######################################################
#              Manipulación de datos
######################################################

library('nycflights13')
library("tidyverse")


# read dataset
flights = read.csv('./datasets/flights.csv')
head(flights, 3)


# Ejercicio 1: crear varibles año, mes y día, y seleccionar
#             las variables flight , air_time , y distance .
flights2 <- flights %>% 
  mutate(year = as.numeric(substring(time_hour, 7, 10)),
         month = as.numeric(substring(time_hour, 4, 5)),
         day = as.numeric(substring(time_hour, 1, 2))) %>%
  select(time_hour, year, month, day, flight, air_time, distance)

# mostramos los primeros 4 valores
head(flights2, 4)

# Ejercicio 2: Eliminar la variable time_hour.
flights3 <- flights2 %>% select(-time_hour)
flights3

# Ejercicio 3: Filtrar mes de enero.
jan <- flights3 %>% filter(month == 1)
head(jan, 4)

# Ejercicio 4: Filtrar por mes de enero y día primero.
jan1 <- flights3 %>% filter(month == 1, day == 1)
head(jan1, 4)

# Ejercicio 5: Filtrar por los meses de enero a marzo.
jan_feb_mar <- flights3 %>% filter(month %in% c(1,2,3))
head(jan_feb_mar, 4)

# verificamos
unique(jan_feb_mar$month)

# Ejercicio 6: Filtrar por mes de enero a marzo y ordenar 
#              el día de forma descendente.
jan_feb_mar <- flights3 %>% 
  filter(month %in% c(1,2,3)) %>%
  arrange(desc(day))
head(jan_feb_mar, 4)

# Ejercicio 7: Filtrar por los meses de enero a marzo y 
#              ordenar mes y día de forma descendente.
jan_feb_mar <- flights3 %>% 
  filter(month %in% c(1,2,3)) %>%
  arrange(desc(month), desc(day))

head(jan_feb_mar, 4)

