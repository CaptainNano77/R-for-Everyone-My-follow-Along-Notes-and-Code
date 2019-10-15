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
