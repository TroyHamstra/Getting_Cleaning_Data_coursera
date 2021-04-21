        ## Question 1: 
## Apply strsplit() to split all the names of the data frame 
## on the characters "wgtp".

## What is the value of the 123 element of the resulting list?

## Download file 
Q1url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
Q1 <- read.csv(Q1url)
Q1

## Compute solution
Q1_colnames <- names(Q1)
strsplit(Q1_colnames, "wgtp")[[123]]

        ## Answer:
        ## [1] ""   "15"


#-------------------------------------------------------------------------------
        ## Question 2:
## Remove the commas from the GDP numbers in millions of dollars 
## What is the average?

# load packages 
library("dplyr")
library("data.table")

## Download File
Q2url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
Q2path <- "~/Desktop/R projects/Getting_cleaning_data/q2gdp.csv"
download.file(Q2url, Q2path, method = "curl")

## Loading & Tidying data
Q2 <- data.table::fread(Q2path, skip = 5, nrows = 190, select = c(1, 2, 4, 5),
                      col.names = c("CountryCode", "Rank", "Country", "Total"))

Q2$Total <- as.integer(gsub(",", "", Q2$Total))

## Calculating Average (mean)
mean(Q2$Total, na.rm = TRUE)

        ## Answer:
        ## [1] 377652.4


#-------------------------------------------------------------------------------
        ## Question 3:
##  what is a regular expression that would allow you to count the number of
## countries whose name begins with "United"? 
## Assume that the variable with the country names in it is named countryNames.
## How many countries begin with United? 

## Fixing country names
Q2$Country <- as.character(Q2$Country)    # subbed Country for countryNames from
Q2$Country[99] <- "Côte d'Ivoire"         # previous question col.names
Q2$Country[186] <- "São Tomé and Príncipe"

## How many countries begin with "United"?
Q2$Country[grep("^United", Q2$Country)]

        ## Answer:
        ## grep("^United", Country), 3

#-------------------------------------------------------------------------------
        ## Question 4:
## Match the data based on the country shortcode.Of the countries for 
## which the end of the fiscal year is available, how many end in June?

## Load package
library(data.table)

## Download file
GDP_url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
GDP_path <- "~/Desktop/R projects/Getting_cleaning_data/gdp.csv"

Edu_url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
Edu_path <- "~/Desktop/R projects/Getting_cleaning_data/edu.csv"

download.file(GDP_url, GDP_path, method = "curl")
download.file(Edu_url, Edu_path, method = "curl")

## analyze the data 
GDP <- data.table::fread(GDP_path, skip = 5, nrows = 190, select = c(1, 2, 4, 5), col.names
             = c("CountryCode", "Rank", "Economy", "Total"))

EDU <- data.table::fread(Edu_path)

## Merging data
Q4_merge <- merge(GDP, EDU, by = "CountryCode")

## Compute solution 
FiscalJune <- grep("Fiscal year end: June", Q4_merge$`Special Notes`)
NROW(FiscalJune)

        ## Answer: 
        ## [1]  13

#-------------------------------------------------------------------------------
        ## Question 5:
## Download data on Amazon's stock price and get the times the data was sampled.
## How many values were collected in 2012? 
## How many values were collected on Mondays in 2012? 

## Load packages & code from question
library(quantmod) 
library(lubridate)
amzn = getSymbols("AMZN", auto.assign = FALSE)
sampleTimes = index(amzn)

## How many values were collected in 2012?
amzn2012 <- sampleTimes[grep("^2012", sampleTimes)]
NROW(amzn2012)

## How many values were collected on Mondays in 2012? 
NROW(amzn2012[weekdays(amzn2012) == "Monday"])

        ## Answer: 
        ## 250 , 47 