library(gganimate)
library(tidyverse)
install.packages("gganimate")
install.packages("gifski")
# Dados de mortalidade em painel
dados_mortalidade <- WDI(country = paises_sul_america,
                         indicator = "SP.DYN.CDRT.IN",
                         start = 1960, end = 2000)

# Converter pra "mortes por mil" (já vem assim, mas mantive claro)
dados_mortalidade <- dados_mortalidade %>%
  mutate(SP.DYN.CDRT.IN_mil = SP.DYN.CDRT.IN)

# Identificar os 5 países com maiores taxas médias
medias_mortalidade <- dados_mortalidade %>%
  group_by(country) %>%
  summarise(media_mortalidade = mean(SP.DYN.CDRT.IN_mil, na.rm = TRUE)) %>%
  arrange(desc(media_mortalidade))
top_mortalidade <- head(medias_mortalidade$country, 5)

# Adicionar cores pros top 5
dados_mortalidade <- dados_mortalidade %>%
  mutate(cor_pais = case_when(
    country == top_mortalidade[1] ~ "red",
    country == top_mortalidade[2] ~ "blue",
    country == top_mortalidade[3] ~ "green",
    country == top_mortalidade[4] ~ "yellow",
    country == top_mortalidade[5] ~ "pink",
    TRUE ~ "grey"
  ))

# Gráfico de painel
graf_mortalidade <- ggplot(dados_mortalidade,
                           mapping = aes(x = year, y = SP.DYN.CDRT.IN_mil, color = cor_pais, group = country)) +
  geom_line(size = 1.2) +
  scale_x_continuous(breaks = seq(1960, 2000, by = 10)) +
  scale_y_continuous(breaks = seq(0, 20, by = 5)) +
  scale_color_identity(guide = "legend", 
                       breaks = c("red", "blue", "green", "yellow", "pink", "grey"),
                       labels = c(top_mortalidade, "Outros")) +
  labs(title = "Taxa de Mortes",
       x = "Ano",
       y = "Mortes por mil pessoas") +
  theme_minimal() +
  theme(legend.title = element_blank(),
        axis.text = element_text(size = 12),
        plot.title = element_text(size = 16, face = "bold")) +
  transition_reveal(year)

# Renderizar animação
animate(graf_mortalidade, nframes = 100, fps = 10, width = 800, height = 600)

