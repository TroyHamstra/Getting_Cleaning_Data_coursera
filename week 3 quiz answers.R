## Week 3 Quiz answers: 

        ## Question 1: 
## Create a logical vector that identifies the households on greater than
## 10 acres who sold more than $10,000 worth of agriculture products.
## Assign that logical vector to the variable agricultureLogical.
## Apply the which() function like this to identify the rows of the data frame
## where the logical vector is TRUE. 

## which(agricultureLogical) 

## What are the first 3 values that result?


        ## Answer:
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv",
                  "ACS.csv", method = "curl")
    
## Read data into data.frame
Q1 <- read.csv("ACS.csv")
   
## assign logical vector
agriculturalLogical <- Q1$ACR == 3 & Q1$AGS == 6 #ACR & AGS from codebook pdf

## use which()to determine where logical vector is TRUE
which(agriculturalLogical)


    ## 125, 238, 262
    
#-------------------------------------------------------------------------------
        ## Question 2: 
## Use the parameter native=TRUE.
## What are the 30th and 80th quantiles of the resulting data?
    
        ## Answer:
    
## install.packages("jpeg")
library("jpeg")
    
## download file
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg",
                  "Q2_jeff.jpg", mode = "wb")
## Read the image
Q2 <- jpeg::readJPEG("Q2_jeff.jpg", native = TRUE)
    
## find 30th and 80th quantiles
quantile(Q2, probs = c(0.3, 0.8))
    
    ##     30%       80% 
    ##  -15259150 -10575416
    
#-------------------------------------------------------------------------------
        ## Question 3: 
## Match the data based on the country shortcode.
## How many of the IDs match? Sort the data frame in descending order by GDP.
## What is the 13th country in the resulting data frame?

    
        ## Answer:
    
## install.packages("data.table")
library("dplyr")
library("data.table")

## Download file
GDP_url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
GDP_path <- "~/Desktop/R projects/Getting_cleaning_data/gdp.csv"

Edu_url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
Edu_path <- "~/Desktop/R projects/Getting_cleaning_data/edu.csv"

download.file(GDP_url, GDP_path, method = "curl")
download.file(Edu_url, Edu_path, method = "curl")

## analyze the data 
GDP <- fread(GDP_path, skip = 5, nrows = 190, select = c(1, 2, 4, 5), col.names
             = c("CountryCode", "Rank", "Economy", "Total"))

EDU <- fread(Edu_path)

## Merging & sorting data
Q3_merge <- merge(GDP, EDU, by = "CountryCode")
Q3_merge <- Q3_merge %>% arrange(desc(Rank))

## Answer: 
paste(nrow(Q3_merge), Q3_merge$Economy[13]) #gives number of matches then country 

    
    ## Answer: 
    ##    Matches / Country
    ##[1] "189  St. Kitts and Nevis"
    
#-------------------------------------------------------------------------------
        ## Question 4:
## What is the average GDP ranking for the "High income: OECD"
## and "High income: nonOECD" group?
    
    ## Answer:
Q3_merge %>%
    group_by(`Income Group`) %>%
    filter("High income: OECD" %in% `Income Group` | "High income: nonOECD" %in%
               `Income Group`) %>%
    summarise(Average = mean(Rank, na.rm = TRUE)) %>%
    arrange(desc(`Income Group`))
    
    ## High income: nonOECD    High income: OECD
    ##      91.91304              32.96667
    
#-------------------------------------------------------------------------------
        ## Question 5: 
## Cut the GDP ranking into 5 separate quantile groups.
## Make a table versus Income.Group. How many countries
## are Lower middle income but among the 38 nations with highest GDP?

Q3_merge$RankGroups <- cut(Q3_merge$Rank, breaks = 5)
vs <- table(Q3_merge$RankGroups, Q3_merge$`Income Group`)
vs
vs[1, "Lower middle income"]

        ## Answer:
    ## [1]  5 
    
    