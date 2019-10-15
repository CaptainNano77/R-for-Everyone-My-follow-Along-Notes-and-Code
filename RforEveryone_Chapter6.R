#######################################################################################################
#                                              CHAPTER 6
#######################################################################################################
#
#                                         Reading CSVs: 6.1
#
# Can read csv files with 'read.table' or 'read.csv'
# 'read.csv' has sep argument preset to a comma ','
url1 <- "http://www.jaredlander.com/data/TomatoFirst.csv"
tomato <- read.table(file=url1, header=TRUE, sep=',')
head(tomato)

tomato1 <- read.csv(file=url1, header=TRUE)
tomato1

#'read_delim' will show column names and type
tomato2 <- read_delim(file=url1, delim=',')

#######################################################################################################
#                                       Excel Data: 6.2
#######################################################################################################
#
# download file at url='http://www.jaredlander.com/data/ExcelExample.xlsx'
install.packages('readxl')
library(readxl)
excel_sheets('ExcelExample.xlsx')

tomatoXL <- read_excel('ExcelExample.xlsx')
tomatoXL

# Use position to open specific sheets
wineXL1 <- read_excel('ExcelExample.xlsx', sheet=2)
head(wineXL1)

# Use name to open specific sheet
wineXL2 <- read_excel('ExcelExample.xlsx', sheet='Wine')
head(wineXL2)

#######################################################################################################
#                                    Reading from Databases: 6.3
#######################################################################################################
#
library(utils)
download.file('http://www.jaredlander.com/data/diamonds.db', destfile='diamonds.db',
              mode='wb')
install.packages('RSQLite')
library(RSQLite)

drv <- dbDriver('SQLite')
class(drv)
# we then establish a connection to the database with dbConnect.
con <- dbConnect(drv, 'diamonds.db')
class(con)
# Now that we are connected, we can learn more about the database with the DBI package.
dbListTables(con)
dbListFields(con, name='diamonds')
dbListFields(con, name='DiamondColors')
# We are now ready to run a query using dbGetQuery. 
diamondsTable <- dbGetQuery(con, 'SELECT * FROM diamonds', 
                            stringsAsFactors=FALSE)
diamondsTable

colorTable <- dbGetQuery(con, 'SELECT * FROM diamonds',
                         stringsAsFactors=FALSE)
colorTable

longQuery <- 'SELECT * FROM diamonds, DiamondColors WHERE diamonds.color = DiamondColors.Color'
diamondsJoin <- dbGetQuery(con, longQuery, stringAsFactors=FALSE)
diamondsJoin

head(diamondsTable)
head(colorTable)
head(diamondsJoin)

#######################################################################################################
#                                 Data from Other Statistical Tools: 6.4
#######################################################################################################
#
#
# See book for common package reading types such as 'read.spss'

#######################################################################################################
#                                            R Binary Files: 6.5
#######################################################################################################
#
#"When working with other R programmers, good way to pass around data or R objects is an RData file
# "These are binary files that represent R objects of any kind"
# "They can store a single or multiple objects and can be passed with Windows, mac, or linux

save(tomato, file='tomato.rdata')
rm(tomato)
head(tomato)
load('tomato.rdata')
head(tomato)

# now we will create a few objects in an RData file, remove them, and load them again
n <- 20
r <- 110
w <- data.frame(n, r)
n
r
w

save(n, r, w, file='multiple.rdata')
rm (n, r, w)
n
load('multiple.rdata')
n
r
w
r

#######################################################################################################
#                                      Data Included with R: 6.6
#######################################################################################################
# see book. In general you have diamonds, iris, etc.

data(diamonds, package='ggplot2')
diamonds


#######################################################################################################
#                                    EXTRACT DATA FROM WEB SITES: 6.7
#######################################################################################################
# 
#





