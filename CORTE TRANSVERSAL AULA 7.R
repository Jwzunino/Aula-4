# Carregar bibliotecas
library(WDI)
library(tidyverse)
library(gganimate)

# Ajustar notação científica
options(scipen = 999)

# Países da América do Sul
paises_sul_america <- c("AR", "BO", "BR", "CL", "CO", "EC", "GY", "PY", "PE", "SR", "UY", "VE")

# Dados de taxa de natalidade em 2000
dados_natalidade <- WDI(country = paises_sul_america,
                        indicator = "SP.DYN.CBRT.IN",
                        start = 2000, end = 2000)

# Converter pra "nascimentos por milhão" (multiplicar por 1.000 pra escalar de "por mil" pra "por milhão")
dados_natalidade <- dados_natalidade %>%
  mutate(SP.DYN.CBRT.IN_milhao = SP.DYN.CBRT.IN * 1000)

# Identificar os 5 países com maiores taxas
top_natalidade <- dados_natalidade %>%
  arrange(desc(SP.DYN.CBRT.IN_milhao)) %>%
  head(5) %>%
  pull(country)

# Adicionar cores pros top 5
dados_natalidade <- dados_natalidade %>%
  mutate(cor_pais = case_when(
    country == top_natalidade[1] ~ "red",
    country == top_natalidade[2] ~ "blue",
    country == top_natalidade[3] ~ "green",
    country == top_natalidade[4] ~ "yellow",
    country == top_natalidade[5] ~ "pink",
    TRUE ~ "grey"
  ))

# Gráfico de corte transversal
graf_natalidade <- ggplot(dados_natalidade,
                          mapping = aes(x = country, y = SP.DYN.CBRT.IN_milhao, fill = cor_pais)) +
  geom_bar(stat = "identity", width = 0.7) +  # Barras pra destacar
  scale_fill_identity(guide = "legend", 
                      breaks = c("red", "blue", "green", "yellow", "pink", "grey"),
                      labels = c(top_natalidade, "Outros")) +
  scale_y_continuous(breaks = seq(0, 50000, by = 10000), labels = scales::comma) +
  labs(title = "Taxa de Nascimentos (2000)",
       x = "País",
       y = "Nascimentos por milhão de pessoas") +
  theme_minimal() +
  theme(legend.title = element_blank(),
        axis.text.x = element_text(angle = 45, hjust = 1, size = 12),
        axis.text.y = element_text(size = 12),
        plot.title = element_text(size = 16, face = "bold")) +
  transition_states(country, transition_length = 2, state_length = 1)

# Renderizar animação
animate(graf_natalidade, nframes = 50, fps = 5, width = 800, height = 600)
anim_save("natalidade_corte_transversal.gif")
