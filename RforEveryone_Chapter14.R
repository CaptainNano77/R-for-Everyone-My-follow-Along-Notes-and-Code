#########################################################################################################
#                                       CHAPTER 14
#                                     DATA RESCHAPING
#########################################################################################################
# We will use functions contained in 'plyr', 'reschape2', and 'data.table' in this
# chapter to reshape data. However, Chapter 15 will cover similar functions in the 
# Tidyverse (dplyr, and tidyr) that can be used with pipeing and are faster. 

#########################################################################################################
#                                   cbind and rbind: 14.1
#########################################################################################################
# If we have 2 datasets with either identical columns (both the # and names) or the same
# number of rows, we can use cbind or rbind.
sport <- c('Hockey', 'Baseball', 'Football')
league <- c('NHL', 'MLB', 'NFL')
trophy <- c('Stanley Cup', "Commissioner's Trophy", 'Vince Lombardi Trophy')

trophies1 <- cbind(sport, league, trophy)
trophies2 <- data.frame(sport=c('Basketball', 'golf'),
                        league=c('NBA', 'PGA'),
                        trophy=c('Larry OBrien Championship Trophy', 'Wanamaker Trophy'),
                        stringsAsFactors=FALSE)

trophies <- rbind(trophies1, trophies2)
trophies1
trophies2
trophies

#########################################################################################################
#                                     Joins: 14.2
#########################################################################################################
# Not all datasets will have equal rows and/or columns and must be joined on a common
# key (column, etc). 
# 3 most common methods are: 'merge' (base R), 'join' (plyr), or merge w/ data.table
download.file(url='http://jaredlander.com/data/US_Foreign_Aid.zip',
              destfile='ForeignAid.zip')
unzip('ForeignAid.zip', exdir='data')

library(stringr)
#first get a list of all the files
theFiles <- dir('data/', pattern='//.csv')
# loop through those files
for (a in theFiles)
{
  nameToUse <- str_sub(string=a, start=12, end=18)
  temp <- read.table(file=file.path('data', a),
                     header=TRUE, sep=',', stringsAsFactors=FALSE)
  assign(x=nameToUse, value=temp)
}

#                               merge
# to merge 2 data.frames
Aid90s00s <- merge(x=Aid_90s, y=Aid_00s,
                   by.x=c('Country.Name', 'Program.Name'),
                   by.y=c('Country.Name', 'Program.Name'))

# I'm skipping ahead to Chapter 15 now to learn the tidyverse instead...