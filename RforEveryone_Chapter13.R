#########################################################################################################
#                                       CHAPTER 13
#                                  ITERATING WITH PURRR
#########################################################################################################
# 

#########################################################################################################
#                                       map: 13.1
#########################################################################################################
# 'map' is main function of purrr and works the same as 'lapply' except works with pipes

theList <- list(A=matrix(1:9, 3), B=1:5, C=matrix(1:4, 2), D=2)
lapply(theList, sum)

library(purrr)
theList %>%  map(sum)
identical(lapply(theList, sum), theList %>% map(sum))

# we can deal with missing values like we have before with the 'na.rm=TRUE' statement
theList2 <- theList
theList2[[1]][2,1] <- NA

theList2 %>%  map(sum)
theList2 %>%  map(sum, na.rm=TRUE)

#########################################################################################################
#                             map with Specified Types: 13.2 
#########################################################################################################
# 'map' always results in a list as the returned result
# you can specify the type of the returned result though using 'map_*' , where the '*'
# specifies the type of return.
# examples: 'map', 'map_int', 'map_dbl' (numeric), 'map_chr', 'map_lgl', 'map_df'

theList %>% map_int(NROW)
theList %>% map_dbl(mean)
theList %>% map_chr(class)
theList %>% map(class)
theList %>% map_lgl(function(x) NROW(x) <3)

buildDF <- function(x)
{
  data.frame(A=1:x, B=x:1)
}
 listOfLengths <- list(3,4,1,5)

 listOfLengths %>% map(buildDF) 
# now we can make this into a dataframe with 'map_df'
 listOfLengths %>% map_df(buildDF)

 # There are times when elements of a list should only be modified IF a logical
 # condition holds true...
 theList %>% map_if(is.matrix, function(x) x*2)
 
 #########################################################################################################
 #                        Iterating over a data.frame: 13.3
 #########################################################################################################
 #
 data(diamonds, package='ggplot2')

diamonds %>% map_dbl(mean) 

# the above operation can also be calculated with 'summarize_each' in dplyr
library(dplyr)

diamonds %>% summarize_each(funs(mean)) 
 
#########################################################################################################
#                        map with Multiple Inputs: 13.4
#########################################################################################################
# in purrr, we can use 'pmap' (like we did mapply) with 'map2' when a function needs
# 2 arguments.

# build 2 lists
firstList <- list(A=matrix(1:16, 4), B=matrix(1:16, 2), C=1:5)
secondList <- list(A=matrix(1:16, 4), B=matrix(1:16, 8), C=15:1) 

#adds the # of rows (or length) of corresponding elements
simpleFunc <- function(x,y)
{
  NROW(x) + NROW(y)
}

# apply the function to the two lists...
map2(firstList, secondList, simpleFunc)
map2_int(firstList, secondList, simpleFunc) 
pmap(list(firstList, secondList), simpleFunc) 
pmap_int(list(firstList, secondList), simpleFunc) 
 
 
 