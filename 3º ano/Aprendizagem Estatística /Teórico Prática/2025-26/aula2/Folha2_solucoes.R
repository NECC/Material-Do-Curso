
### Exercício 1 — `select`, `filter`, `mutate`, `arrange`

mtcars |>
  as_tibble(rownames = "modelo") |>
  select(modelo, mpg, cyl, hp) |>
  filter(mpg > 25, cyl %in% c(4, 6)) |>
  mutate(
    kmpl = mpg * 0.4251,
    potencia = case_when(
      hp < 100 ~ "baixa",
      hp < 150 ~ "média",
      TRUE     ~ "alta"
    )
  ) |>
  arrange(desc(kmpl)) |>
  head(8)


### Exercício 2 — `summarise` + `group_by` + `across`

library(nycflights13)

# sumários por companhia
flights |>
  group_by(carrier) |>
  summarise(
    n_voos = n(),
    atraso_med_part = mean(dep_delay, na.rm = TRUE),
    atraso_med_cheg = mean(arr_delay, na.rm = TRUE)
  ) |>
  arrange(desc(n_voos)) |>
  head(10)

# across() para média e sd
flights |>
  group_by(carrier) |>
  summarise(
    across(c(dep_delay, arr_delay),
           list(media = ~mean(.x, na.rm = TRUE),
                sd    = ~sd(.x,   na.rm = TRUE)),
           .names = "{.col}_{.fn}")
  )


### Exercício 3 — `pivot_longer` / `pivot_wider` e `separate` / `unite`


vendas <- tibble(
  id = 1:4,
  Jan = c(10, 12, 9, 11),
  Fev = c(11, 8, 13, 10),
  Mar = c(9, 12, 7, 15)
)

# largo -> longo
vendas_long <- vendas |>
  pivot_longer(cols = Jan:Mar, names_to = "mes", values_to = "valor")

# longo -> largo
vendas_long |>
  pivot_wider(names_from = mes, values_from = valor)

# separate / unite
nomes <- tibble(nome_completo = c("Ana Silva","Bruno Costa","C. Rocha"))
nomes |>
  separate(nome_completo, into = c("primeiro","apelido"),
           sep = " ", extra = "merge", fill = "right") |>
  unite(nome_compacto, primeiro, apelido, sep = "_", remove = TRUE)


### Exercício 4 — Junções I (`left` / `inner` / `full`)

# contagem por destino
voos_dest <- flights |>
  count(dest, name = "n_voos")

# left_join com airports
tbl_left <- left_join(voos_dest, airports, by = c("dest" = "faa")) |>
  select(dest, n_voos, name, lat, lon) |>
  arrange(desc(n_voos))
tbl_left |> head(10)

# inner_join e comparar dimensões
inner_join(voos_dest, airports, by = c("dest" = "faa")) |>
  nrow()

# full_join e sumarizar lacunas
full_join(voos_dest, airports, by = c("dest" = "faa")) |>
  summarise(
    sem_meta = sum(is.na(name)),
    sem_voos = sum(is.na(n_voos))
  )


