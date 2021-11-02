library(dplyr)
library(lubridate)

fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(fileUrl, destfile = "./data.csv", method="curl")
dateDownloaded <- date()
dat <- read.csv("data.csv")
head(dat)
df <- tbl_df(dat)
head(df)


## q1
splitNames = strsplit(names(dat), "wgtp")
splitNames[[123]]

## q2
fileUrl2 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
download.file(fileUrl2, destfile = "./data2.csv", method="curl")
dateDownloaded <- date()

dat <- data.table::fread(fileUrl2, skip=5, nrows = 190, select=c(1,5), col.names=c("Country", "Total"))
head(dat)


gdps <- gsub(",","", dat$Total)
gdps2 <- gsub(" ","", gdps)
gdps2

gdps3 <- sapply(gdps2, strtoi)
mean(gdps3)


## q3
GDPrank <- data.table::fread('http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv'
                             , skip=5
                             , nrows=190
                             , select = c(1, 2, 4, 5)
                             , col.names=c("CountryCode", "Rank", "Country", "GDP")
)
grep("^United",GDPrank[, Country])


## q4
GDPrank <- data.table::fread('http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv'
                             , skip=5
                             , nrows=190
                             , select = c(1, 2, 4, 5)
                             , col.names=c("CountryCode", "Rank", "Country", "GDP")
)
eduDT <- data.table::fread('http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv')

mergedDT <- merge(GDPrank, eduDT, by = 'CountryCode')

mergedDT[grepl(pattern = "Fiscal year end: June 30;", mergedDT[, `Special Notes`]), .N]




## q5
#install.packages("quantmod")
library("quantmod")
amzn <- getSymbols("AMZN",auto.assign=FALSE)
sampleTimes <- index(amzn) 
timeDT <- data.table::data.table(timeCol = sampleTimes)

# How many values were collected in 2012? 
timeDT[(timeCol >= "2012-01-01") & (timeCol) < "2013-01-01", .N ]

# How many values were collected on Mondays in 2012?
timeDT[((timeCol >= "2012-01-01") & (timeCol < "2013-01-01")) & (weekdays(timeCol) == "Monday"), .N ]
