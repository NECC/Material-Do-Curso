library(gapminder)

gapminder
dim(gapminder)
summary(gapminder)

length(unique(gapminder$country))
tapply(gapminder$lifeExp, gapminder$continent, mean)

#Evolução da esperança média de vida em portugal

gapminder_pt<-gapminder[gapminder$country=="Portugal",]

ggplot(data=gapminder_pt, aes(x=year, y=lifeExp))+geom_line()


#Comparação entre a evolução da esperança média de vida nos diferentes países (da Europa)

gapminder_europe<-gapminder[gapminder$continent=="Europe",]

ggplot(data=gapminder_europe, aes(x=year, y=lifeExp, color=country))+geom_line()


#comparar diferentes continentes no ultimo ano

gapminder_2007<-gapminder[gapminder$year==2007,]

ggplot(data=gapminder_2007, aes(x=continent,y=lifeExp))+geom_boxplot()

ggplot(data=gapminder_2007, aes(x=continent,y=gdpPercap))+geom_boxplot()


#relação entre lifeExp e GDP

ggplot(data=gapminder, aes(x=gdpPercap, y=lifeExp, color=continent))+geom_point()




## video Hans Rosling Ted Talk- minuto 2.28

# install.packages(c("ggplot2","gapminder","gganimate","gifski","png"))
library(ggplot2)
library(gapminder)
library(gganimate)

# base ggplot
p <- ggplot(gapminder, 
            aes(x = gdpPercap, 
                y = lifeExp, 
                size = pop, 
                color = continent,
                frame = year)) +
  geom_point(alpha = 0.7, show.legend = TRUE) +
  scale_x_log10() +
  scale_size(range = c(2, 12), guide = "none") +
  labs(title = 'Year: {frame_time}',
       x = 'GDP per capita (log scale)',
       y = 'Life Expectancy (years)',
       color = 'Continent') +
  theme_minimal(base_size = 15) +
  theme(plot.title = element_text(face = "bold")) +
  transition_time(year) +
  ease_aes('linear')

# render the animation
anim <- animate(p, 
                fps = 10, 
                duration = 12, 
                width = 800, 
                height = 600,
                renderer = gifski_renderer())

anim
# save to file
anim_save("gapminder_lifeExp_gdp.gif", animation = anim)



# install.packages(c("ggplot2","gapminder","gganimate","gifski","png"))
library(ggplot2)
library(gapminder)
library(gganimate)

# Animated scatterplot: lifeExp vs GDP per capita
p <- ggplot(gapminder,
            aes(x = gdpPercap,
                y = lifeExp,
                size = pop,
                color = continent)) +
  geom_point(alpha = 0.7) +
  transition_time(year)

+
  scale_x_log10(
    name = "GDP per Capita (log scale)"
  ) +
  scale_y_continuous(
    name = "Life Expectancy (years)"
  ) +
  scale_color_brewer(
    palette = "Set1",
    name = "Continent"
  ) +
  scale_size_continuous(
    range = c(2, 12),
    name = "Population"
  ) +
  labs(
    title = "Year: {frame_time}"
  ) +
  theme_minimal(base_size = 15) +
  theme(
    plot.title     = element_text(face = "bold", size = 20),
    legend.position = "right"
  ) +
  transition_time(year) +
  ease_aes('linear')

# Render the animation
anim <- animate(
  p,
  fps      = 10,
  duration = 12,
  width    = 800,
  height   = 600,
  renderer = gifski_renderer()
)

anim
# Save to file
anim_save("gapminder_lifeExp_gdp.gif", animation = anim)


