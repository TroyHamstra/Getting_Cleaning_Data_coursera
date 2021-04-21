## Question 1: 
## Register an application with the Github API here
## "https://github.com/settings/applications" 

## Access the API to get information on your instructors repositories
## (hint: this is the url you want "https://api.github.com/users/jtleek/repos"). 

## Use this data to find the time that the datasharing repo was created.
library(httr)

## Find Oauth setting for github:
oauth_endpoints("github")

gitapp <- oauth_app("github",
                    key = # insert own key "", 
                    secret = # insert own secret "")

## Get OAuth credentials
github_token <- oauth2.0_token(oauth_endpoints("github"), gitapp)

## Use API 
gtoken <- config(token = github_token)
req <- GET("https://api.github.com/users/jtleek/repos", gtoken)
stop_for_status(req)
output <- content(req)

## find Datasharing
datashare <- which(sapply(output, FUN = function(X) "datasharing" %in% X))
datashare

## Find time that datashare repo was crated
list(output[[datashare]]$name, output[[datashare]]$created_at)

        ## Answer: 2013-11-07T13:25:07Z


#-------------------------------------------------------------------------------
## Question 2: 

## We will use the sqldf package to practice the queries
## we might send with the dbSendQuery() command in RMySQL.

## Download the American Community Survey data and load it into an R object
## called: acs https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv

## Which command will select only the data for the
## probability weights pwgtp1 with ages less than 50?
library(sqldf)

## Download file
fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"

download.file(fileURL, destfile = "acs.csv", method = "curl")

## Loading data
acs <- read.csv("acs.csv")
head(asc)

## Find probability weights pwgtp1 w/ age < 50
sqldf("select pwgtp1 from acs where AGEP < 50")


#-------------------------------------------------------------------------------
## Question 3:
## Using the same data frame you created in the previous problem
## what is the equivalent function to unique(acs$AGEP)
z <- unique(acs$AGEP)

A <- sqldf("select AGEP where unique from acs")
    # Error: near "unique": syntax error
B <- sqldf("select distinct AGEP from acs")
    identical(z, B$AGEP)
    # TRUE
C <- sqldf("select distinct pwgtp1 from acs")
    identical(z, C$AGEP)
    # FALSE
D <- sqldf("select unique AGEP from acs")
    # Error: near "unique": syntax error

#-------------------------------------------------------------------------------
## Question 4:
## How many characters are in the 10th, 20th, 30th and 100th lines of HTML 
## from this page:
##      http://biostat.jhsph.edu/~jleek/contact.html

## (Hint: the nchar() function in R may be helpful)

## Fetching data
htmlURL <- url("http://biostat.jhsph.edu/~jleek/contact.html")
htmlCode <- readLines(htmlURL)

## Viewing data
head(htmlCode)

## finding answer
c(nchar(htmlCode[10]), nchar(htmlCode[20]), nchar(htmlCode[30]), 
  nchar(htmlCode[100]))
        ## Answer : 45, 31, 7, 25

#-------------------------------------------------------------------------------
## Question 5:
## Read this data set into R
## report the sum of the numbers in the fourth of the nine columns.
## https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for
        ## ***HINT: this is a fixed width file (fwf) format ****

## fetching data
fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for"
SST <- read.fwf(fileURL, skip = 4, widths = c(12, 7, 4, 9, 4, 9, 4, 9, 4))

## viewing file 
head(SST)

## Finding Answer
sum(SST[,4])
        ## Answer: 32426.7