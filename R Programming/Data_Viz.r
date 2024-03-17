library(tidyverse)

## basic plot (base R)
hist(mtcars$mpg)

## analyzing hp
## Histogram - One Quantitative Variable
hist(mtcars$hp)
mean(mtcars$hp)
median(mtcars$hp)
mtcars$am <- factor(mtcars$am,
                    levels = c(0,1),
                    labels = c("Auto", "Manual"))

str(mtcars)


## bar plot - One Quantitative Variable
barplot(table(mtcars$am))

## Box plot 
boxplot(mtcars$hp)
fivenum(mtcars$hp)

## whisker cal
Q3 <- quantile(mtcars$hp, probs = 0.75)
Q1 <- quantile(mtcars$hp, probs = 0.25)
IQR_hp <- Q3 - Q1

Q3 + 1.5*IQR_hp
Q1 - 1.5*IQR_hp

boxplot.stats(mtcars$hp,coef = 1.5)

## Boxplot 2 variable
boxplot(mpg ~ am, data = mtcars,col = c("gold","green"))


## scatter plot

plot(mtcars$hp, mtcars$mpg)

## First plot
ggplot(data = mtcars, mapping = aes(x = hp, y = mpg)) + 
  geom_point(size = 2, col = "red") + 
  geom_smooth() + 
  geom_rug()


ggplot(mtcars,aes(hp))+
  geom_histogram(bins = 12,fill = "blue")


ggplot(diamonds,aes(cut))+
  geom_bar(fill = "lightblue")

ggplot(diamonds,aes(cut,fill = color))+
  geom_bar()

ggplot(diamonds,aes(cut,fill = color))+
  geom_bar(position = "dodge")

ggplot(diamonds,aes(cut,fill = color))+
  geom_bar(position = "fill")

## Scatter plot
set.seed(45)
small_diamonds <- sample_n(diamonds,5000)

ggplot(small_diamonds,aes(carat,price)) + 
  geom_point()

## Facet : small multiple

ggplot(small_diamonds,aes(carat,price)) + 
  geom_point()+
  geom_smooth(method = "lm",col = "red")+
  facet_wrap(~color, ncol = 2) +
  theme_minimal()+
  labs(title = "Relationship",
       x = "Carat",
       y = "Price USD",
       caption = "Diamonds from ggplot package")



