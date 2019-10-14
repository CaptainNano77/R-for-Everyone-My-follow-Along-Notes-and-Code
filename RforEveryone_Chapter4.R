######################################################################################
#R FOR EVERYONE!
#THIS IS MY WORK AND NOTES AS I WORK THROUGH THE ENTIRE SECOND EDITION OF
#R FOR EVERYONE by Jared Lander.
#Date: 191012         ROBERT M. TAYLOR, PHD

titanic <- read.csv('/Users/rmtaylor/ML/bootcamp/Titanic/datasciencedojo-capstone/train.csv', 
                    header=TRUE, sep=',')
head(titanic)
dim(titanic)
summary(titanic$Age)

#CHAPTER 4: BASICS OF R
1+1
1+2+3
3*7*2
4/2
4/3

##Variables
a <- 1
a

a <- b <- c <- 1.000
a
b
c
a == b
print (a,b,c)
a+b+c

assign("b", 4)
b
a+b+c
b <- 1
b
a+b+c

#remove variables
b
rm(b)
b

#Data types
#numeric(float/integer), character(string), Date/POSIXct(time based), and logical(T/F)
c
class(c)
is.numeric(c)
is.character(c)

c <- 1.000
c
class(c)
c <- 1L
c
class(c)
is.integer(c)
is.numeric(c)
is.character(c)

#R will promote an integer to a numeric when needed...
d <- c + 1L
e <- c + 1
f <- c + 1.0987
d
e
f
class(d)
class(e)
class(f)

rm(c,d,e,f)

#Character Data
x <- 'data'
x
y <- c('data', 'science')
y
y <- factor(c('data', 'science'))
y

#find length of character (does not work for factor data though)
nchar(x)
nchar('hello')

#Logical TRUE=1 and FALSE=0
TRUE*5
FALSE*5
is.logical(TRUE)
is.logical(T)
is.logical(1)
k <- TRUE
class(k)

2 == 1
2 == 2
2 != 1
2 != 2

#Vectors
#Vectors cannot be mixed type. Must be same type. Create vector w/ 'c'
v <- c(1,2,3,4,5)
v

#Performing an operation on a vector performs the operation on each element of 
#the vector w/out the need for a loop on your part
v*3

v-3

v/3

v/v

# a short cut to create the vector we just did, is to instead use :
vv <- 1:5
vv
1:5

#If 2 vectors are of THE SAME LENGTH, then they can perform operation on each other
rm(v, vv)

x <- c(2,4,6,8,10)
y <- c(1,3,5,7,9)

x+y
x*y

length(x)
length(y)
length(x+y)

#If 2 vectors are of UNEQUAL LENGTH, the smaller is recycled in order until all elements
#of the longer vector have been matched. If longer is not a multiple of smaller, a 
#warning will be given.

x <- c(1,2,3,4)
y <- c(1,2)
x+y
x*y

x <- c(1,2,3,4,5)
x+y

#You can compare vectors of the SAME LENGTH.
x <- c(1,2,3,4,5)
y <- c(6,7,8,9,10)
x>y
x<y

x==5
x!=5

#Find individual elements of the vector with square brackets []
x[2]
y[2]
#For a series of elements w/in the vector...
x[1:2]
y[1:2]
#For non-consecutive elements in the vector...
x[c(1,3)]
y[c(1,3)]

#Giving names to a vector can be done during or after creation
#1)Provide a name for each element of an array ...
c(One='a', Two='y', Last='r')

#2)creat a vector
w <- 1:3

#3)name the elements in the vector 
names(w) <- c('a', 'b', 'c')
w

# FACTOR Vectors 4.4.2
# The levels of a factor are the unique values of that factor variable. 
q = c('data', 'science', 'machine', 'learning', 'science', 'learning', 'learning', 'data',
      'machine', 'data', 'science')
q
qFactor = as.factor(q)
qFactor
as.numeric(qFactor)

#You can also set the ordering of the levels if needed. Such as education..
factor(x=c('High School', 'Masters', 'Doctorate', 'College'), 
       levels = c('High School', 'College', 'Masters', 'Doctorate'),
       ordered = TRUE)

# Calling Functions
x <- c(1,2,3,3.5,4)
x
mean(x)

#Any function in R has documentation. Place a question mark. 
?'+'
?'=='
?'mean'

# If we only know some of what we want, we can search part of it with 'apropos'
apropos('mea')
apropos('stand')

# Missing Data 4.7
#NA = missing data
z <- c(1,2,NA, 8, 3, NA, 3)
z
is.na(z)

#notice that if we take the mean of 'z' we will get the answer 'NA'. However, 
# we can use 'na.rm=TRUE' to remove the NA and then calculate the mean.
mean(z)
mean(z, na.rm=TRUE)
sum(z, na.rm=TRUE)
sd(z, na.rm=TRUE)
round(sd(z, na.rm=TRUE), 2)

#NULL
#NULL is the absence of anything. It isn't 'emptiness' it is 'nothingness'. 
# THE DIFFERENCE IN 'NA' AND 'NULL' IS THAT 'NULL' CAN NOT EXIST WITHIN A VECTOR! 
#It will simply disapear inside a vector...
a = c(1, NULL, 3)
a

#PIPES 4.8
# PIPES: The pipe works by taking the object on the left-hand side and inserting it
#  into the first argument of the function on the righ-hand side of the pipe. 
library(magrittr)
x <- 1:10
x
mean(x)
x %>% mean

# pipe example
# Given a vector z that contains numbers and NAs, we want to find out how many NAs 
# are present. Traditionally, this would be done by nesting functions. (Top example below).
# However, this can also be done using pipes (bottom example below).

z <- c(1, 2, NA, 8, 3, NA, 3)
z
sum(is.na(z))

z %>% is.na %>% sum

z %>% mean(na.rm=TRUE)
