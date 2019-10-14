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


