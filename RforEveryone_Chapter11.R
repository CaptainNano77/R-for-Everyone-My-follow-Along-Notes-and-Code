#########################################################################################################
#                                                CHAPTER 11
#                                           GROUP MANIPULATIONS
#########################################################################################################
#
#  " A general rule of thumb for data analysis is that manipulating the data (or 'data munging', a 
#  term popularized by Simple founder Josh Reich) consumes about 80% of the effort."

#########################################################################################################
#                                           Apply Family: 11.1
#########################################################################################################
#
# Apply
# MUST be used on a matrix. If used on a data.frame, it will first be transformed to a matrix
# 1 = operate over rows; 2 = operate over columns
theMatrix <- matrix(1:9, nrow=3)
theMatrix
#sum the rows
apply(theMatrix, 1, sum)
#sum the columns
apply(theMatrix, 2, sum)
# this can also be done with rowSums and colSums
rowSums(theMatrix)
colSums(theMatrix)

# Let's add an NA element to the matrix to see how we deal with missing values ('na.rm = TRUE')
theMatrix[2,1] <- NA
theMatrix
apply(theMatrix, 1, sum)
apply(theMatrix, 1, sum, na.rm=TRUE)
apply(theMatrix, 2, sum, na.rm=TRUE)
rowSums(theMatrix)
rowSums(theMatrix, na.rm=TRUE)

#                                       lapply and sapply
# lapply works by applying a function to each element of a list and returning the output in a list
theList <- list(A=matrix(1:9, 3), B=1:5, C=matrix(1:4, 2), D=2)
lapply(theList, sum)

# Dealing with lists can be cumbersome, so return the result as a vector instead with sapply
sapply(theList, sum)

theNames <- c('Jared', 'Deb', 'Paul')
lapply(theNames, nchar)
sapply(theNames, nchar)

#                                           mapply
# mapply applies a function to each element of multiple lists. 
# Often, people will use a loop for this, but it is NOT needed. Use mapply instead

#build 2 lists...
firstList <- list(A=matrix(1:16, 4), B=matrix(1:16, 2), C=1:5)
secondList <- list(A=matrix(1:16, 4), B=matrix(1:16, 8), C=15:1)

#test element-by-element if they are identical
mapply(identical, firstList, secondList)

# another example of mapply
simpleFunc <- function(x,y)
{
  NROW(x) + NROW(y)
}

mapply(simpleFunc, firstList, secondList)

#                                       Other apply functions
# tapply, rapply, eapply, vapply, and by

#########################################################################################################
#                                          Aggregate: 11.2
#########################################################################################################
#
# FORMULAS: Formulas will be used. Formulas have a left side and right side separated by a tilde (~)
# Left side is a variable we want to make a calculation on
# Right side is a variable (or more) that we want to group the calculation by. 

data(diamonds, package='ggplot2')
head(diamonds)

# Let's calculate average price for each type of cut. 
aggregate(price ~ cut, diamonds, mean)

# to group by more than one variable, add an additional value just to the right of the first...
aggregate(price ~ cut + color, diamonds, mean)

# to combine 2 variables we must first combine them on the left with 'cbind'
aggregate(cbind(price, carat) ~ cut, diamonds, mean)

# to apply 2 or more functions, we must use 'plyr' or 'dplyr' packages (Section 11.3 and Chapter 12)

# to supply multiple variables to both sides...
aggregate(cbind(price, carat) ~ cut + color, diamonds, mean)

# aggregate can be slow. plyr, dplyr, and data.table are much faster

#########################################################################################################
#                                          plyr: 11.3
#########################################################################################################
#
# all 'ply-er' commands are 5 letters and end in 'ply'
# the first 2 letters are the type of data (i.e. d = data.frame and l= list)

#                                           ddply
library(plyr)
head(baseball)
# for detailed background, see the book Chapt. 11.3, page 137
# subsetting with [ is faster than using ifelse
baseball$sf[baseball$year < 1954] <- 0
#check that it worked
any(is.na(baseball$sf))

#set NA hbp's to 0
baseball$hbp[is.na(baseball$hbp)] <- 0
any(is.na(baseball$hbp))

# only keep players with at least 50 at bats in a season
baseball <- baseball[baseball$ab >= 50, ]
head(baseball)

# We can now calculate the OBP for a given player in a given year with just vector operations
baseball$OBP <- with(baseball, (h + bb + hbp) / (ab + bb + hbp + sf))
tail(baseball)

# To calculate OBP for a player's ENTIRE career, we can NOT just average his individual years. We
# need to calculate and the numerator and then divide by the sum of the denominator.
# we can do this with ddply...

obp <- function (data)
{
  c(OBP=with(data, sum(h + bb + hbp) / sum(ab + bb + hbp + sf)))
}

# use ddply to calculate career OBP for each player
careerOBP <- ddply(baseball, .variables='id', .fun=obp)

#sort the results by OBP
careerOBP <- careerOBP[order(careerOBP$OBP, decreasing=TRUE), ]
head(careerOBP, 10)

#                                     llply
# for lists...
# the old way with lapply...
theList <- list(A=matrix(1:9, 3), B=1:5, C=matrix(1:4, 2), D=2)
lapply(theList, sum)

#  the new way with llply
llply(theList, sum)

identical(lapply(theList, sum), llply(theList, sum))

# get result as vector instead of list
sapply(theList, sum)
laply(theList, sum)
# notice that 'sapply' gives the names , while 'laply does not

#                                 plyr Helper Functions
# 
# helper functions include 'each' which allows us to add multiple functions to 'aggregate'
aggregate(price ~ cut, diamonds, each(mean, median, sd))
head(aggregate(price ~ carat, diamonds, each(mean, sd)), 10)

# another function is 'idata.frame' which creates a reference to a data.frame so subsetting is faster
# and memory efficient

system.time(dlply(baseball, 'id', nrow))

ibaseball <- idata.frame(baseball)
system.time(dlply(ibaseball, 'id', nrow))
# sometimes it works and sometimes not, however it is a moot point since we will see that 
# we would use 'dplyr' over 'plyr' for this anyway.

#########################################################################################################
#                                         data.table: 11.4
#########################################################################################################
#
# "For speed junkies there is a package called 'data.table', written by Matt Dowle...
# "The syntax is a little different from a regular data.frame which takes getting use to.

install.packages('data.table')
library(data.table)

# create a regular data.frame
theDF <- data.frame(A=1:10,
                    B=letters[1:10],
                    C=LETTERS[11:20],
                    D=rep(c('One', 'Two', 'Three'), length.out=10))
theDF

#create a data.table
theDT <- data.table(A=1:10,
                    B=letters[1:10],
                    C=LETTERS[11:20],
                    D=rep(c('One', 'Two', 'Three'), length.out=10))
theDT
# notice that we get an INDEX when using data.table
# also, data.frame turns characters into factors, wheras data.table does NOT
class(theDF$B)
class(theDT$B)

# You can also turn a data.frame INTO a data.table
diamondsDT <- data.table(diamonds)
diamondsDT
# data.frame would have printed the ENTIRE data.frame, whereas data.table only prints 
# the first and last 5 rows

# We can also access rows...
theDT[1:2, ]
theDT[theDT$A >= 7, ]
theDT[A >=7, ]
# note that the 3rd example above is only in data.table and won't work in data.frame

# Getting individual COLUMNS in a data.table is DIFFERENT than data.frame...
# We must specify columns in a list...
theDT[, list(A,C)]
#Just one column
theDT[, B]
#Just one column and retain data structure..
theDT[, list(B)]

# if the column names must be entered as Characters, (perhaps due to them being passed as
# arguments in functions), the 'with' agrument should be set =FALSE
theDT[, 'B', with=FALSE]
theDT[, c('B', 'C'), with=FALSE]

#                                            Keys
#Now that we have a few data.tables in the memory, we may want info on them..
tables()
# notice there is a 'key' attribute listed in the results...
# we have not assigned any keys so they are all blank
# the key is used to index the data for extra speed
# We start by adding a key to theDT. We will use the D column to index the data.table.
# this is done by using 'setkey'
setkey(theDT, D)
theDT
key(theDT)
tables()

#Now, we can use the key column to access the data
theDT['One', ]
theDT['Two']
theDT[c('One', 'Two')]

#more than one column can be set to 'key'
setkey(diamondsDT, cut, color)
tables()
#To access rows according to BOTH columns, we must now use a special function 'J'
# 'J' takes multiple arguments, each of which is a vector of values to select.
diamondsDT[J('Ideal', 'E'), ]
diamondsDT[J('Ideal', c('E', 'D'))]

#                                     Data Table Aggregation
#
#The primary benefit of indexing is faster aggregation
#data.table has built in aggegation that is faster than 'aggregate' or 'dply'
aggregate(price ~ cut, diamonds, mean)
diamondsDT[, mean(price), by=cut]

#To aggregate on multiple columns, specify them as a list()
diamondsDT[, mean(price), by=list(cut, color)]

#To aggregate multiple arguments, pass them as list.
diamondsDT[, list(price=mean(price), carat=mean(carat)), by=cut]
diamondsDT[, list(price=mean(price), carat=mean(carat), caratSum=sum(carat)), by=cut]
diamondsDT[, list(price=mean(price), carat=mean(carat), caratSum=sum(carat)), by=list(cut, color)]

