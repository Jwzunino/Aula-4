install.packages('WDI')
library(WDI)
COD_GDP <- WDIsearch('gdp')
options(scipen = 999)
basepib <- WDI(country = 'all',
               indicator = 'NY.GDP.MKTP.CD')

dadospib2023 <- WDI(country = 'all',
                    indicator = 'NY.GDP.MKTP.CD',
                    start = 2023, end = 2023)


dadospibbr <- WDI(country = 'BR',
                  indicator = 'NY.GDP.MKTP.CD')

#SÉRIE TRANSVERSAL
dadospopulaçãototal <- WDI(country = 'BR',
    indicator = 'SP.POP.TOTL')

#CORTE TRANSVERSAL
DADOSINDUSTRIA <- WDI(country = 'all',
                      indicator = 'NV.IND.TOTL.ZS',
                      start = 2022, end = 2023)


Gravidas_na_adolescencia <- WDI(country = 'all',
                       indicator = 'SP.ADO.TFRT')
