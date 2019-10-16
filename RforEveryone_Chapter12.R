#########################################################################################################
#                                              CHAPTER 12
#                               FASTER GROUP MANIPULATIONS WITH DPLYR
#########################################################################################################
#
# 'dplyr' is the second iteration of plyr and is for data.frames (hence the 'd' in the name)
# much faster
# Uses function verbs such as 'select' to select columns, 'filter' to select rows,
# 'group_by to group and 'mutate' to change or add columns.
# MUST LOAD PLYR FIRST AND THEN DPLYR!!!!!!! (can explicity state which with plyr::summarize, or
# dplyr::summarize)

#########################################################################################################
#                                             Pipes: 12.1
#########################################################################################################
#The pipe operator is '%>%'

library(magrittr)
data(diamonds, package='ggplot2')

dim(head(diamonds, n=4))
# or...
diamonds %>% head(4) %>% dim

#########################################################################################################
#                                             tbl: 12.2
#########################################################################################################
# Just as data.table extends the data.frames, 'tbl' does similar
# Feature: tbl only prints what will fit on screen
# Feature: tbl shows the data type under each column name
# the diamonds dataset from ggplot2 is actually a tbl 
# the tbl features only show if you have dplyr or similar package loaded. Otherwise it will be d.frame
# refered to as 'tibbles'

class(diamonds)
head(diamonds)

library(dplyr)
head(diamonds)

# since tbl only prints a few rows we do NOT have to use 'head'
diamonds

#########################################################################################################
#                                           select: 12.3
#########################################################################################################
#
select(diamonds, carat, price)
diamonds %>% select(carat, price)
diamonds %>% select('carat', 'price')

theCols <- c('carat', 'price')
diamonds %>% select(theCols)
select(diamonds, 1,7)
diamonds %>% select(1,7)

diamonds %>% select(starts_with('c'))
diamonds %>% select(ends_with('t'))
diamonds %>% select(contains('i'))

# Regular Expressions (regex) can be used with 'matches'. Regex will be explained in Chapter 16.4
# This particular examples searches for an 'r' followed by any number of wildcards and then 't'
diamonds %>% select(matches('r.+t'))

# You can also denote that columns should NOT be included...
diamonds %>% select(-carat, -price)
diamonds %>% select(-'carat', -'price')

#########################################################################################################
#                                          filter: 12.4
#########################################################################################################
#Specifying rows is done with 'filter'
diamonds %>% filter(cut == 'Ideal')
diamonds %>% filter(clarity == 'SI2')

#If we were to use the base R it would be longer and look like this
diamonds[diamonds$cut == 'Ideal', ]
diamonds %>% filter(cut == 'Ideal')

# select several row levels
d1=diamonds %>% filter(cut %in% c('Ideal', 'Good'))

# All the standard equality operators can be used with filter
diamonds %>%  filter(price >= 1000)
diamonds %>%  filter(price != 1000)

# compound expressions can be separated with ',' or '&'
diamonds %>%  filter(carat > 2, price < 14000)
diamonds %>%  filter(carat >2 & price < 14000)

# or expressions use '|'
diamonds %>% filter(carat <1 | carat > 5)

#Both examples below need the underscored filter ('filter_')
# note example 1:  the extra quotes 
# note example 2: use the tilda (~) instead of quotes
diamonds %>%  filter_("cut == 'Ideal'")
diamonds %>%  filter_(~cut == 'Ideal')

# store in a variable...
theCut <- 'Ideal'
diamonds %>% filter_(~cut == theCut)

# if you want to store multiple variables for the filter you must use 'sprintf'
theCol <- 'cut'
diamonds %>% filter_(sprintf("%s == '%s'", theCol, theCut))

#########################################################################################################
#                                         slice: 12.5
#########################################################################################################
# 'slice' is used to select rows by row number (filter was by row name)
diamonds %>%  slice(1:5)

diamonds %>%  slice(1:5, 8, 15:20)
# Note that the row numbers selected are not the same as after the slice

# '-' denotes rows not to include
diamonds %>%  slice(-1)
slice(diamonds, -1)

#########################################################################################################
#                                         mutate: 12.6
#########################################################################################################
# creating new columns or modifying existing ones is done with 'mutate'

diamonds %>% mutate(price/carat)
mutate(diamonds, price/carat)

# There may be too many columns for the new column to display on the console.
# To ensure you see the new column, you can specify a few columns of interest using 'select'
# and then piping the result into 'mutate'
diamonds %>%  select(carat, price) %>%  mutate(price/carat)

# The resulting column is unnamed. we can easily add a name inside the 'mutate'
diamonds %>%  select(carat, price) %>%  mutate(Ratio = price/carat)

# columns made with mutate can immediately be used in the same mutate call...
diamonds %>% 
  select(carat, price) %>% 
  mutate(Ratio=price/carat, Double=Ratio*2)

# This has NOT changed the diamonds data.
# To SAVE the new data must be assigned to the object diamonds.
# in 'magrittr' we can use the ASSIGNMENT PIPE %<>% 

library(magrittr)

diamonds2 <- diamonds
diamonds2

diamonds2 %<>% 
  select(carat, price) %>% 
  mutate(Ratio=price/carat, Double=Ratio*2)
diamonds2

#########################################################################################################
#                                        summarize: 12.7
#########################################################################################################
# summarize is used to apply functions such as mean, max, median, etc
summarize(diamonds, mean(price))

diamonds %>%  summarize(mean(price))

diamonds %>%  
  summarize (AvgPrice=mean(price),
             MedianPrice=median(price),
             AvgCarat=mean(carat))

#########################################################################################################
#                                       group_by: 12.8
#########################################################################################################
#the 'summarize' function really shines when paired with the 'group_by' function
diamonds %>%
  group_by(cut) %>% 
  summarize(AvgPrice=mean(price))

diamonds %>%
  group_by(cut, carat) %>% 
  summarize(AvgPrice=mean(price))

diamonds %>%
  group_by(cut) %>% 
  summarize(AvgPrice=mean(price),
            AvgCarat=mean(carat))

diamonds %>%
  group_by(cut, color) %>% 
  summarize(AvgPrice=mean(price),
            AvgCarat=mean(carat))
View(diamonds %>%
       group_by(cut, color) %>% 
       summarize(AvgPrice=mean(price),
                 AvgCarat=mean(carat)))

#########################################################################################################
#                                       arrange: 12.9
#########################################################################################################
#sorting is performed with the 'arrange' function
diamonds %>% 
  group_by(cut) %>% 
  summarize(AvgPrice=mean(price), 
            SumCarat=sum(carat)) %>% 
  arrange(AvgPrice)

diamonds %>% 
  group_by(cut) %>% 
  summarize(AvgPrice=mean(price), 
            SumCarat=sum(carat)) %>% 
  arrange(desc(AvgPrice))

#########################################################################################################
#                                       do: 12.10
#########################################################################################################
#'do' enables any arbitrary function on the data
#
# create a function
topN <- function(x, N=5)
{
  x %>% 
    arrange(desc(price)) %>% 
    head(N)
}

diamonds %>% 
  group_by(cut) %>% 
  do(topN(., N=3))

#########################################################################################################
#                                   dplyr with Databases: 12.11
#########################################################################################################
# 'dplyr' works with PostgreSQL, MySQL, SQLite, MonetDB, Google Big Query, and Spark Dataframes 
# (as of the writing of the book in 2017) 
install.packages('dbplyr')
library(dbplyr)
# Step 1: download file
download.file("http://www.jaredlander.com/data/diamonds.db", 
              destfile = 'diamonds.db', mode='wb')

# Step 2: make a connection
diamDBSource <- src_sqlite('diamonds.db')
diamDBSource

# Step 3: now that we have a connection, point to a specific table
diaTab <- tbl(diamDBSource, 'diamonds')
diaTab

diaTab %>% 
  group_by(cut) %>% 
  dplyr::summarize(Price=mean(price))

