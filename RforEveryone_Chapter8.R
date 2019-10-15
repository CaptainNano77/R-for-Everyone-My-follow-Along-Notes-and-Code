########################################################################################################
#                                              CHAPTER 8
#                                          WRITING R FUNCTIONS
########################################################################################################
#
#########################################################################################################
#                                          Hello, World! : 8.1
########################################################################################################
#
# If we write the same code repeatedly, we should turn it into a function instead. We should
# reduce redundancy whenever possible.

# Hello, World! of course...

say.hello <- function() {
  print('Hello, World!')
}

say.hello()

#########################################################################################################
#                                         Function Arguments: 8.2
########################################################################################################
#
# The 'sprintf' function will allow us to substitute '%s' a string or characters
sprintf('Hello %s', 'Robert')
sprintf('Hello %s, today is %s', 'Robert', 'Monday')
# We now use 'sprintf' to build a string to print based on the funtion's argument
hello.person <- function(name){
  print(sprintf('Hello %s', name))
}

hello.person('Robert')

# keep in mind that the argument 'name' was used as a variable INSIDE of the function and it 
# DOES NOT exist OUTSIDE of the function.

# We can add multiple arguments...
hello.person <- function(last, first) {
  print(sprintf('Hello %s %s', first, last))
}

hello.person('Taylor', 'Robert')
hello.person(first='Robert', last='Taylor')
hello.person(last='Taylor', first='Robert')

# DEFAULT ARGUMENTS
# R allows you to set default arguments that can be changed if needed. 
hello.person <- function(first, last='Doe') {
  print(sprintf('Hello %s %s', first, last))
}

hello.person('Robert')
hello.person('Robert', 'Taylor')

# EXTRA ARGUMENTS
# The argument '...' will allow the function to take extra arguments but it should be 
# used VERY carefully. 
hello.person <- function(first, last, ...) {
  print(sprintf('Hello %s %s', first, last))
}

hello.person('Robert', 'Taylor', 'Data Science')

#########################################################################################################
#                                         Return Values: 8.3
########################################################################################################
#
# We can return the value we've calculated by using 'return'
# The last value is always displayed in the console however explicitly state 'return' in functions

double.num <- function(x) {
  return (x*2)
}

double.num(2)
double.num(4)

#########################################################################################################
#                                         do.call : 8.4
########################################################################################################
#
# The 'do.call' function allows us to specify the name of a function either as a character or as an 
# object, and provide arguments as a list.
do.call('hello.person', args=list(first='Robert', last='Taylor'))

# This is useful when building a function that allows the user to specify and action. In this 
# example, the user supplies a vector and a function to be run...

run.this <- function(x, func=mean){
  do.call(func, args=list(x))
}

run.this(1:10)
run.this(1)
run.this(1:100)

run.this(1:10, sum)
run.this(1:10, sd)
run.this(-5:4, abs)

