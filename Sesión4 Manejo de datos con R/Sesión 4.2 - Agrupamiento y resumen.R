

#######################################################
#             Agrupamiento y resumen
#######################################################

library("datasets")
library("tidyverse")


# lectura de datos
iris <- read.csv('./datasets/iris.csv')
head(iris)

# número de especies
unique(iris$Species)


# ¿Cúantas observaciones hay por especie?
df01 <- iris %>% 
  group_by(Species) %>% 
  summarize('n'=n())
df01


# ¿Cúal es el promedio de cada medición por especie?
df02 <- iris %>% 
  group_by(Species) %>% 
  summarize('Sepal_length'=mean(Sepal.Length),
            'Petal_length'=mean(Petal.Length),
            'Sepal_Width'=mean(Sepal.Width), 
            'Petal_Width'=mean(Petal.Width))

df02

# ¿Cúal es la desviación estándar de cada medición por especie?
df03 <- iris %>% 
  group_by(Species) %>% 
  summarize('Sepal_length'=sd(Sepal.Length),
            'Petal_length'=sd(Petal.Length),
            'Sepal_Width'=sd(Sepal.Width), 
            'Petal_Width'=sd(Petal.Width))

df03


####################################################
#            Pivot tables
####################################################

url <- 'https://raw.githubusercontent.com/JulioCesarMartinez-00/S1-Introduccion-a-R/main/Sesi%C3%B3n4%20Manejo%20de%20datos%20con%20R/datsets/df_DownJones.csv'

# read dataset
down <- read.csv(url) %>% 
  mutate(Date = as.Date(Date, "%Y-%m-%d"))

head(down)

#  Obtener el promedio del precio por mes y año de cada activo

# vamos poner las variables de los activos en formato long
down_longer <- down %>% 
  mutate(year = substring(Date,1,4),
         month = substring(Date,6,7),
         day = substring(Date, 9,10)) %>%
  select(-Date) %>%
  pivot_longer(cols=WMT:BA, names_to='name', values_to='price') 

head(down_longer)

# código completo
down_avg <- down %>% 
  mutate(year = substring(Date,1,4),
         month = substring(Date,6,7),
         day = substring(Date, 9,10)) %>%
  select(-Date) %>%
  pivot_longer(cols=WMT:BA, names_to='name', values_to='price') %>%
  group_by(year, month, name) %>%
  summarize(mean_price = mean(price)) %>% 
  pivot_wider(names_from=name, values_from=mean_price)

down_avg

