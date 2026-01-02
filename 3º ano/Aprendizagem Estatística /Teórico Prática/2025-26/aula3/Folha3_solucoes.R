library(tidyverse)
library(ggplot2)

#1
load("dados_eurostat.RData")

head(dados_eurostat)
dim(dados_eurostat)
View(dados_eurostat)


#2
eurostat_pt<-dados_eurostat |> filter(country=="Portugal")

head(eurostat_pt)

ggplot(eurostat_pt, aes(x=time, y=Total))+
  geom_line()

#3
dados_eurostat |> 
  filter(year==2019) |>
  mutate(diff=Females-Males) |>
  arrange(desc(diff))

dados_diff<-dados_eurostat |> 
  filter(year==2019) |>
  mutate(diff=abs(Females-Males)) |>
  group_by(country) |>
  summarise(media_diff=mean(diff, na.rm=TRUE)) |>
  arrange(desc(media_diff)) |>
  head(5)
  
ggplot(dados_diff, aes(x=country, y=media_diff))+
  geom_bar(stat="identity")



#4

dados_ratio<-dados_eurostat |> 
  filter(year>2014) |>
  mutate(ratio=Under25/Over25) |>
  group_by(country) |>
  summarise(media_ratio=mean(ratio, na.rm=TRUE)) |>
  arrange(desc(media_ratio)) |>
  head(5)

dados_ratio

#5
dados_eurostat2<-dados_eurostat|>
  group_by(country) |>
  summarise(media_taxa=mean(Total, na.rm=TRUE)) |>
  arrange(desc(media_taxa)) |>
  head(5)

eurostat_top<-dados_eurostat |>
  filter(country %in% dados_eurostat2$country)

ggplot(eurostat_top, aes(x=time, y=Total, color=country))+
  geom_line()

#6
dados_eurostat3<-eurostat_top |>
pivot_longer(cols = c(Females, Males), names_to = "Sexo", values_to = "valor")

View(dados_eurostat3)

ggplot(dados_eurostat3, aes(x=time, y=valor, color=Sexo))+
  geom_line()+
  facet_wrap(~country)
