# Dados de fertilidade pro Brasil
dados_fertilidade <- WDI(country = "BR",
                         indicator = "SP.DYN.TFRT.IN",
                         start = 1960, end = 2000)

# Converter pra "nascimentos por milhão de mulheres"
dados_fertilidade <- dados_fertilidade %>%
  mutate(SP.DYN.TFRT.IN_milhao = SP.DYN.TFRT.IN * 1000000)

# Gráfico de série temporal
graf_fertilidade <- ggplot(dados_fertilidade,
                           mapping = aes(x = year, y = SP.DYN.TFRT.IN_milhao)) +
  geom_line(size = 1.5, color = "purple") +
  geom_point(size = 3, color = "purple") +
  scale_x_continuous(breaks = seq(1960, 2000, by = 10)) +
  scale_y_continuous(breaks = seq(0, 8000000, by = 2000000), labels = scales::comma) +
  labs(title = "Taxa de Fertilidade (Brasil)",
       x = "Ano",
       y = "Nascimentos por milhão de mulheres") +
  theme_minimal() +
  theme(axis.text = element_text(size = 12),
        plot.title = element_text(size = 16, face = "bold")) +
  transition_reveal(year)

# Renderizar animação
animate(graf_fertilidade, nframes = 100, fps = 10, width = 800, height = 600)
anim_save("fertilidade_serie_temporal.gif")
