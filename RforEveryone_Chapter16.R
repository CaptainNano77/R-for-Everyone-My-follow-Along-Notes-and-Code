#########################################################################################################
#                                       `CHAPTER 16
#                                  MANIPULATING STRINGS
#########################################################################################################
# strings are character data. We may need to build them, deconstruct them ('paste', 'sprintf')
# We may also want to examine, search, find, text which we can do with (Regular Expressions).
# Although the 'stringr' package can be better for that.

#########################################################################################################
#                                     paste: 16.1
#########################################################################################################
#
paste('Hello', 'Robert', 'and others')
paste(c('Hello', 'Hey', 'Howdy'), c('Robert', 'Bob', 'Rob'))
paste('Hello', c('Robert', 'Bob', 'Rob'))
paste('Hello', c('Robert', 'Bob', 'Rob'), c('Goodbye', 'See ya'))

# paste can also be used to join strings together by anything using 'collapse'
vectorOfText <- c('Hello', 'Everyone', 'out there', '.')
paste(vectorOfText, collapse = '')
paste(vectorOfText, collapse = ' ')
paste(vectorOfText, collapse = '*')

#########################################################################################################
#                                    sprintf: 16.2
#########################################################################################################
# In the examples above, 'paste' could only add a single "spacer character" between the
# strings. (i.e. a space or * in the example above). 
# If we want to add multiple different things into strings, then 'sprintf' will be 
# much more useful.

install.packages('sprintf')
library(sprintf)

#sprintf doesn't seem to be working. I get an error that it is no longer available
# in version 3.6.1, which is what I have.?
# I'm guessing I can use 'stringr' to do what sprintf did??

#########################################################################################################
#                                Extracting Text: 16.3
#########################################################################################################
#                                     'stringr'
#

# First we need to scrape the table data from a wikipedia page...
library(XML)
load('presidents.rdata')
theURL <- 'http://www.loc.gov/rr/print/list/057_chron.html'
presidents <- readHTMLTable(theURL, which=3, as.data.frame=TRUE, 
                            skip.rows=1, header=TRUE,
                            stringsAsFactors=FALSE)
head(presidents)
tail(presidents)

# Next, we need to remove the emptyp rows
presidents <- presidents[1:65, ]
tail(presidents)

#                       Make 2 columns from the single Year Column
# To start, we want to make 2 columns out of the 'year' column. 1 for the start and 1
# for the end of each president's term.

library(stringr)
#split the string
yearList <- str_split(string=presidents$YEAR, pattern='-')
head(yearList)

# We now combine the split into one matrix
yearMatrix <- data.frame(Reduce(rbind, yearList))
head(yearMatrix)

# give the columns better names
names(yearMatrix) <- c('Start', 'Stop')
head(yearMatrix)

# bind the new columns onto the data.frame
presidents <- cbind(presidents, yearMatrix)

# convert the start and stop columns into numeric
# NOTE: since 'start' and 'stop' are factors, they must be turned into characters 
# before numerics

class(presidents$Start)
presidents$Start <- as.numeric(as.character(presidents$Start))
presidents$Stop <- as.numeric(as.character(presidents$Stop))
head(presidents)
tail(presidents)

# We can select specified characters from text using 'str_sub'

# get the 1st 3 characters
str_sub(string=presidents$PRESIDENT, start=1, end=3)
# get the 4th through 8th characters
str_sub(string=presidents$PRESIDENT, start=4, end=8)

#########################################################################################################
#                                Regular Expressions: 16.4
#########################################################################################################
# This does not have an exhaustive lesson in regular expression, but illustrates how
# to use them. 

# Let's find the word "John" wherever it occurs using str_detect
johnPos <- str_detect(string=presidents$PRESIDENT, pattern='John')
goodSearch <- presidents[johnPos, c('YEAR', 'PRESIDENT', 'Start', 'Stop')]
goodSearch
nrow(goodSearch)

# Example 2: Let's scrape a table of U.S. Wars from the web. We are only interested
# in 1 column in the table so we will make an rdata file with just that column ...

# make connection, load, and close...
con <- url('http://www.jaredlander.com/data/warTimes.rdata')
load(con)
close(con)

head(warTimes, 10)

# Wikipedia encodes a column separater with 'ACAEA'. 
# We now want to create a column for the start date.
theTimes <- str_split(string=warTimes, pattern="(ACAEA) | -", n=2)
theTimes

#Let's just get the start dates (1st date)
theStart <- sapply(theTimes, FUN=function(x) x[1])
head(theStart)

# the original text sometimes had white space around it and sometimes didn't. To fix this, we use str_trim
theStart <- str_trim(theStart)
head(theStart)

# We can extract the word 'January' everywhere it occurs
str_extract(string=theStart, pattern='January')

#If we want to extract the other data with 'january' then we say...
theStart[str_detect(string=theStart, pattern='January')]

# To extract just the year from this, we need occurances of 4 numbers together. We don't know specific numbers 
# so we write '[0-9]' four times...
head(str_extract(string=theStart, "[0-9][0-9][0-9][0-9]"), 20)
head(str_extract(string=theStart, "[0-9]{4}"), 20)
head(str_extract(string=theStart, "\\d{4}"), 20)
# in the 3rd example above, the '\\d' is shorthand for '[0-9]' (think d for digit)

head(str_extract(string=theStart, "\\d{1,3}"), 20)

#                             Beginning and ending of lines ^ and $
# extract 4 digits at the beginning of the text
head(str_extract(string=theStart, "^\\d{4}"), 30)

# extract 4 digits at the end of the text
head(str_extract(string=theStart, "\\d{4}$"), 30)

# extract 4 digits at the beginning AND end of the text
head(str_extract(string=theStart, "^\\d{4}$"), 30)

# We can also selectively replace text

# replace the first digit seen with 'x'
head(str_replace(string=theStart, pattern='\\d', replacement='x'), 30)

# replace all digits seen with 'x'
head(str_replace_all(string=theStart, pattern='\\d', replacement='x'), 30)

# replace any strings of digits from 1 to 4 in length with 'x'
head(str_replace(string=theStart, pattern='\\d{1,4}', replacement='x'), 30)

#   Others...
# '.' indicates a search for ANYTHING
# '+' means to search for it 1 or more times
# '?' means it is not a greedy search. Because we do not know what the text will be. 
# '\\1' means reference back to the previous substitution

# create a vector of HTML commands
commands <- c("<a href=index.html>The Link is here</a>",
              "<b.This is bold text</b>")
# get the text between the HTML tags
str_replace(string=commands, pattern="<.+?>(.+?)<.+>",
            replacement='\\1')
?regex
