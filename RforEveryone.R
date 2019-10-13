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

