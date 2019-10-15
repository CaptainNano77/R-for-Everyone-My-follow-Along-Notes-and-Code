###################################################################################################
#                                      R FOR EVERYONE: CHAPTER 5

#                        This is my code and notes as I work through Chapter 5

###################################################################################################
#                                           DATA FRAMES: 5.1

x <- 10:1
y <- -4:5
q <- c('Hockey', 'Football', 'Baseball', 'Curling', 'Rugby', 'Lacrosse', 'Basketball', 'Tennis', 'Cricket', 'Soccer')
DataFrame <- data.frame(x, y, q)
DataFrame

# Rename the data columns
DataFrame <- data.frame(First=x, Second=y, Sport=q)
DataFrame

# Check number of columns and rows
nrow(DataFrame)
ncol(DataFrame)
dim(DataFrame)

# Check column names
names(DataFrame)
names(DataFrame[2])

# We can also check and assign row names of a data frame
rownames(DataFrame)
rownames(DataFrame) <- c('one', 'two', 'three', 'four', 'five', 'six', 'seven', 'noble', 'nine', 'ten')
DataFrame
rownames(DataFrame)

# print out the first few rows of the start or end of the data frame
head(DataFrame)
tail(DataFrame)

head(DataFrame, n=7)

#check the class of the data frame
class(DataFrame)

#                                   SELECTING COLUMNS
# with the '$' or '[ ]'
DataFrame$Sport

DataFrame[1,3]
DataFrame[1:4, 3]
DataFrame[,3]
DataFrame[c(1,3,5), 3]
DataFrame[1:3,]
DataFrame[,c('First', 'Sport')]

# with the names
DataFrame[,'Sport']
class(DataFrame[,'Sport'])

DataFrame[,'Sport']
DataFrame['Sport']
class(DataFrame['Sport'])

DataFrame[, 'Sport']
DataFrame[, 'Sport', drop=FALSE]
DataFrame['Sport']

#                           CREATE DUMMY VARIABLES
# use model.matrix to create a set of indicator/dummy variables. That is one column 
# for each level of a factor, with a 1 if a row CONTAINS the level and a 0 if it does NOT. 
Dummy <- factor(c('PA', 'NY', 'NJ', 'NY', 'TN', 'MA', 'PA', 'NY'))
model.matrix(~ Dummy - 1)

####################################################################################################
#                          LISTS: 5.2

# Lists can contain mixed types at the same time. They can contan numerics, characters, data.frames,
# and other lists.

# creates a 3-element list
list(1,2,3)

#creates a single element list
list(c(1,2,3))

# or create multiples...
list3 <- list(c(1,2,3), 3:7)
list3

list(DataFrame, 1:10)

list5 <- list(DataFrame, 1:10, list3)
list5

# We can name lists just like data.frames
names(list5)
names(list5) <- c('dataframe', 'vector', 'list')
names(list5)
list5

# ELEMENTS in a list can also be named DURING creation using name-value pairs.
list6 <- list(TheDataFrame=DataFrame, TheVector=1:10, TheList=list3)
list6

# To create an empty list, confusingly...you use a vector...
(emptyList <- vector(mode='list', length=4))

#Access individual elements of a list
list5[[1]]
list5[[1]]$Sport
list5[[1]][,'Second', drop=FALSE]

#Append an element to list
length(list5)

list5[4] <- 2
list5
length(list5)

#####################################################################################################
#                           5.3: Matrices
#