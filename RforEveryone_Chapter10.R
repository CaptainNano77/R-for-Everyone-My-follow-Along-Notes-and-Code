#########################################################################################################
#                                             CHAPTER 10
#                                   LOOPS, THE UN-R WAY TO ITERATE
########################################################################################################
# Although most languages rely heavily on loops, R generally uses vectorization. However, loops
# are still useful in R

#########################################################################################################
#                                           for loops: 10.1
########################################################################################################
#
for (i in 1:10){
  print(i)
}

# notice this could have just been done with the vectorization of the print function
print(1:10)

fruit <- c('apple', 'banana', 'pomegranate')
fruitlength <- rep(NA, length(fruit))
fruitlength
names(fruitlength) <- fruit
fruit

for (a in fruit){
  fruitlength[a] <- nchar(a)
}
fruitlength

# Again, R's built in vectorization could have made this a lot easier...
fruitlength2 <- nchar(fruit)
names(fruitlength2) <- fruit
fruitlength2

# Also can get identical results with this...
identical(fruitlength, fruitlength2)

#########################################################################################################
#                                        while loops : 10.2
########################################################################################################
#
# while loops are even less frequent in R. However, they are a way to run the code inside the 
# braces repeatedly as long as the tested condition proves true. 

x <- 1
while (x <= 5){
  print(x)
  x <- x + 1
}

#########################################################################################################
#                                     Controlling Loops: 10.3
########################################################################################################
#
# Sometimes we need to skip to the next iteration of the loop and completely break out of it.
# This is accomplished with 'next' and 'break'

for (i in 1:10)
{
  if (i == 3)
  {
    next
  }
  print (i)
}
# notice that '3' was not printed

for (i in 1:10)
{
  if (i == 4)
  {
    break
  }
  print (i)
}

# NOTE: IT IS BEST TO NOT USE LOOPS IN R. IT IS VERY IMPORTANT TO NOT USED NESTED LOOPS. (LOOPS IN 
# LOOPS) AS THESE ARE VERY SLOW IN R.
#
#finish
