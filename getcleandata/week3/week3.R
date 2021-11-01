#week3.R
#q1
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(fileUrl, destfile = "./data.csv", method="curl")
dateDownloaded <- date()
dat <- read.csv("data.csv")
head(dat)
df <- tbl_df(dat)
head(df)

# Create a logical vector that identifies the households on greater than 10 acres 
# who sold more than $10,000 worth of agriculture products. Assign that logical 
# vector to the variable agricultureLogical. Apply the which() function like this 
# to identify the rows of the data frame where the logical vector is TRUE. 

#  which(agricultureLogical) 

# What are the first 3 values that result?

agricultureLogical <- dat$ACR == 3 & dat$AGS == 6
head(which(agricultureLogical), 3)


# q2
library(jpeg)
download.file('https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg'
              , 'jeff.jpg'
              , mode='wb' )
picture <- jpeg::readJPEG('jeff.jpg'
                          , native=TRUE)

quantile(picture, probs = c(0.3, 0.8) )

#q3
library("data.table")

FGDP <- data.table::fread('https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv'
                          , skip=4
                          , nrows = 190
                          , select = c(1, 2, 4, 5)
                          , col.names=c("CountryCode", "Rank", "Economy", "Total")
)

FEDSTATS_Country <- data.table::fread('https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv'
)

mergedDT <- merge(FGDP, FEDSTATS_Country, by = 'CountryCode')
nrow(mergedDT)
mergedDT[order(-Rank)][13,.(Economy)]

#q4
mergedDT[`Income Group` == "High income: OECD"
         , lapply(.SD, mean)
         , .SDcols = c("Rank")
         , by = "Income Group"]

mergedDT[`Income Group` == "High income: nonOECD"
         , lapply(.SD, mean)
         , .SDcols = c("Rank")
         , by = "Income Group"]

# q5
library('dplyr')
breaks <- quantile(mergedDT[, Rank], probs = seq(0, 1, 0.2), na.rm = TRUE)
mergedDT$quantileGDP <- cut(mergedDT[, Rank], breaks = breaks)
mergedDT[`Income Group` == "Lower middle income", .N, by = c("Income Group", "quantileGDP")]
