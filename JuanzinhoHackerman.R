#install.packages("WDI")
library(WDI)
#SEMPRE PROCURAR AS VIGNETTES
# PÁGINAS COM ORIENTAÇÃO DOS PACOTES
WDIsearch('gdp')
WDIsearch(NY.GDP.MKTP.KD.ZG)

#BAIXAR OS DADOS DO PIB(PRUDOTO INTERNO BRUTO)
#TUDO QUE É PRODUZIDO EM UM PAÍS/ESTADO/MUNICIPIO
#DURANTE DETERMINADO PERIODO

#GDP (current US$)(NY.GDP.MKTP.KD.ZG)
#GROSS DOMESTIC PRODUCT (GDP) EM DÓLARES NORTE-AMERICANOS
#CÓDIGO NY.GDP.MKTP.KD.ZG

COD_GDP <- WDIsearch('gdp')
# É IMPORTANTE PROCURAR PELO PRÓPRIO SITE DO BANCO
# MUNDIAL, É MAIS EFICIENTE 

#COM O CÓDIGO BAXAREMOS OS DADOS
options(scipen = 999) #AJUSTAR NUMEROS
basepib <-  WDI(country = 'all',
                indicator = 'NY.GDP.MKTP.CD')
                
basepip2023<-  WDI(country = 'all',
                   indicator = 'NY.GDP.MKTP.CD',
                   start=2023, end=2023)
