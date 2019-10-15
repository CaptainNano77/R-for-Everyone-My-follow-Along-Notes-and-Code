#########################################################################################################
#                                               CHAPTER 9
#                                          CONTROL STATEMENTS
########################################################################################################
#
# The main control statements are 'if', 'else', 'ifelse' and 'switch'

#########################################################################################################
#                                           if and else: 9.1
########################################################################################################

as.numeric(TRUE)
as.numeric(FALSE)
1==1
1<1

# we can now apply this inside an 'if' statement
# First, set up a variable to hold:
toCheck <- 1
#if toCheck is equal to 1, print 'hello'
if(toCheck == 1){
  print('Hello')
}

if(toCheck == 0){
  print('Hello')
}

#                                       IF ELSE STATEMENTS

check.bool <- function(x){
  if(x==1){
    print('Hello')
  } else {
    print('Goodbye')
  }
}
check.bool(2)
check.bool(1)
check.bool('k')
check.bool(TRUE)
check.bool(FALSE)

#                                     ELSE IF STATEMENTS
check.bool <- function(x) {
  if (x==1) {
    print('hello') 
  } else if (x==0) {
    print('goodbye')
    } else {
      print('confused...')
    }
}
check.bool(1)
check.bool(0)
check.bool(5)

#########################################################################################################
#                                           switch: 9.2
########################################################################################################
#
ifelse(1==1, 'yes', 'no')
ifelse(1==0, 'yes', 'no')

toTest <- c(1,1,0,1,0,1)
ifelse(toTest==1, 'yes', 'no')

ifelse(toTest==1, toTest*3, 'no')

#########################################################################################################
#                                      Compound Tests: 9.4
########################################################################################################
#
# We compare things with 'and' and 'or' we can use '&' or '&&' for 'and'
# We can use | or || for 'or'
#It's best to use the double && and || in if statements and the single form % and | in ifelse statements
# THE DOUBLE FORM COMPARES ONLY ONE ELEMENT FROM EACH SIDE WHILE THE SINGLE FORM COMPARES EACH
# ELEMENT OF EACH SIDE.

a <- c(1,1,0,1)
b <- c(2,1,0,1)
ifelse(a--1 & b==1, 'yes', 'no')

# this one only checks the first elelent since the double and is used
ifelse(a ==1 && b == 1, 'yes', 'no')
