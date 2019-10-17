#########################################################################################################
#                                       CHAPTER 15
#                             Reshaping Data in the Tidyverse
#########################################################################################################
#
#########################################################################################################
#                              `Binding Rows and Columns: 15.1
#########################################################################################################
# 'bind_rows' and 'bind_cols' Only work with data.frames
# load libraries
library(dplyr)
library(tibble)

sportLeague <- tibble(sport=c('Hockey', 'Baseball', 'Football'),
                      league=c('NHL', 'MLB', 'NFL'))
trophy <- tibble(trophy=c('Stanley Cup', 'Commissioners Trophy', 'Vince Lombardi Trophy'))

trophies1 <- bind_cols(sportLeague, trophy)
trophies1

trophies2 <- tribble(
  ~sport, ~league, ~trophy,
  'Basketball', 'NBA', 'Larry OBrien Championship Trophy',
  'Golf', 'PGA', 'Wanamaker Trophy'
  )

trophies <- bind_rows(trophies1, trophies2)
trophies

#########################################################################################################
#                              `Joins with dplyr: 15.2
#########################################################################################################
# DPLYR: left_join, right_join, inner_join, outer_join, semi_join, and anti_join
library (readr)
colorsURL <- 'http://www.jaredlander.com/data/DiamondColors.csv'
diamondColors <- read_csv(colorsURL)
diamondColors

data(diamonds)
unique(diamonds$color)

#we will perform a LEFT join that will result in a combined tribble (data.frame) that 
# has ALL the info from BOTH datasets.

library(dplyr)
left_join(diamonds, diamondColors, by=c('color'='Color'))
left_join(diamonds, diamondColors, by=c('color'='Color')) %>% 
  select(carat, color, price, Description, Details)

# We can see the distinct colors....
left_join(diamonds, diamondColors, by=c('color'='Color')) %>% 
  distinct(color, Description)

diamondColors %>% distinct(Color, Description)

# A RIGHT join keeps all rows on the right and only the matching rows on left.
right_join(diamonds, diamondColors, by=c('color'='Color')) %>% 
  nrow

diamonds %>% nrow

# An INNER join returns rows from BOTH tables that MATCH (have matching keys)
all.equal(
  left_join(diamonds, diamondColors, by=c('color'='Color')),
  inner_join(diamonds, diamondColors, by=c('color'='Color'))
)

# A FULL join (outer join) returnss ALL rows on both tables even if they don't match
all.equal(
  right_join(diamonds, diamondColors, by=c('color'='Color')),
  full_join(diamonds, diamondColors, by=c('color'='Color'))
)

# A semi_join does not join 2 tables together but rather returns the 1st rows in the
# left that have matches on the right. 

semi_join(diamondColors, diamonds, by=c('Color'='color'))

# An anti_join is the opposite of the semi_join and returns first rows that are NOT matched

anti_join(diamondColors, diamonds, by=c('Color'='color'))

#########################################################################################################
#                             Converting Data Formats: 15.3
#########################################################################################################
## 'tidyr' will be used to covert data between long and wide formats.
## 'reshape2' does this in base R but does not work with pipes

emotion <- read_tsv('http://www.jaredlander.com/data/reaction.txt')
emotion

# This is a long form. We can shorten it by gathering the 'age, react, and regulate, and ' 
# bmi' columns into a single column named 'Measurement'. and the column names. Another
# column 'type' holds the original column names.

library(tidyr)
emotion %>% 
  gather(key=Type, value=Measurement, Age, BMI, React, Regulate)

# The new data are sorted by the 'type' column which makes it hard to see what happened
# To make it easier to see, we can sort by ID. 
emotionLong <- emotion %>% 
  gather(key=Type, value=Measurement, Age, BMI, React, Regulate) %>% 
  arrange(ID)

head(emotionLong, 20)

# the opposite of 'gather' is 'spread'

emotionLong %>% 
  spread(key=Type, value=Measurement)

# Neat!!





