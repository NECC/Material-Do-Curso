# Executar estas linhas de código para instalar os packages necessários
req <- c("tidyverse","broom","gapminder","glmnet","janitor", "car", "nycflights13")
new <- setdiff(req, rownames(installed.packages()))
if(length(new)) install.packages(new)

