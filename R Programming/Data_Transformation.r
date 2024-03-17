
library(tidyverse)
library(glue)
library(lubridate)

# glue messages
my_name <- "New"
my_age <- 22
glue("Hi! my name is {my_name}. I,m {my_age} years old.")


# library tidyverse
# data transformation => dplyr

# 1. select
# 2. filter
# 3. arrange
# 4. mutate => create new column
# 5. summarise


mtcars <- rownames_to_column(mtcars,"model")


m2 <- mtcars %>%
  select(model,mpg,hp,wt,am) %>%
  filter(between(hp,100,200)) %>%
  arrange(am,desc(hp))
  
write.csv(m2,"result.csv")

mtcars %>%
  filter(mpg >= 20) %>%
  select(model,mpg,hp,wt) %>%
  mutate(hp_halve = hp/2)
  
# summarize



## random sampling
 sample_mtcar <- mtcars %>% 
   sample_n(5)

## 
library(nycflights13)
data("fights")
data("flights" )

library(RSQLite)
con <- dbCanConnect(SQLite(),"chinook.db")
dbListTables(con)

