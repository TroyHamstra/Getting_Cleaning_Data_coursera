## fread url requires curl package on mac
## install.package("curl")

## Question 1:
quiz1data <- download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv",
                           destfile = "quiz1data.csv", method = "curl")

data <- read.csv("quiz1data.csv")

## Check code book for variable names in file
## https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FPUMSDataDict06.pdf

## VAL says how much property is worth,
## VAL == 24 means more than $1,000,000

nrow(data[which(data$VAL == 24), ])
        ## Answer: 53

#-------------------------------------------------------------------------------
## Question 2:

## based on code book above what "tidy data" principle
## does the variable FES violate?
        ## Answer: Tidy data has one variable per column

#-------------------------------------------------------------------------------
## Question 3:

## Download the Excel spreadsheet on Natural Gas Acquisition Program here:
##   "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx"

## Read rows 18-23 and columns 7-15 into R
## assign the result to a variable called "dat"
## What is the value of sum(dat$Zip*dat$Ext,na.rm=T)

require(xlsx)
## load req package: xlsx
## load req package: rJava
## load req package: xlsxjars

download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx",
              destfile = "natural_gas_data.csv", method = "curl")

## specify rows and columns of interest
row <- 18:23
col <- 7:15

## assign variable dat
dat <- read.xlsx("natural_gas_data.csv", sheetIndex = 1, colIndex = col, 
                 rowIndex = row, header = TRUE)

## determine value of sum(dat$Zip*dat$Ext,na.rm=T)
sum(dat$Zip*dat$Ext, na.rm = TRUE)
        ##Answer: 36534720

#-------------------------------------------------------------------------------
## Question 4:

## Read the XML data on Baltimore restaurants from here:
## "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"
## How many restaurants have zipcode 21231?

library(XML)

fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"
doc <- xmlTreeParse(sub("s", "", fileURL), useInternal = TRUE)
rootNode <- xmlRoot(doc)
xmlName(rootNode)    # should give "response" as output

## how many restaurants have zipcode?

zips <- xpathApply(rootNode, "//zipcode", xmlValue)
length(zips[which(zips == "21231")])
        ## Answer: 127


#-------------------------------------------------------------------------------
## Question 5:

## Download the 2006 microdata survey about housing for the state of Idaho
## using download.file() from here:

## "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"

## using the fread() command, load the data into an R object
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv",
              destfile = "Idaho_housing_2006.csv", method = "curl")

## Broken down by sex. Using the data.table package,
## which will deliver the fastest user time?

library(data.table)
DT <- fread(input = "Idaho_housing_2006.csv", sep = ",")

system.time(mean(DT$pwgtp15, by = DT$SEX))

system.time(tapply(DT$pwgtp15, DT$SEX, mean))

system.time(sapply(split(DT$pwgtp15, DT$SEX), mean))

system.time(DT[, mean(pwgtp15), by = SEX])

system.time(mean(DT[DT$SEX == 1, ]$pwgtp15)) + 
    system.time(mean(DT[DT$SEX == 2, ]$pwgtp15))

system.time(rowMeans(DT[DT$SEX == 1] + rowMeans(DT[DT$SEX == 2])))
