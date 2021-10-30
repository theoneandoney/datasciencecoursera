# quiz 1

# codebook:  https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FPUMSDataDict06.pdf
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(fileUrl, destfile = "./data.csv", method="curl")
dateDownloaded <- date()
dat <- read.csv("data.csv")
head(dat)


library(xlsx)
fileUrl2 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx"
download.file(fileUrl2, destfile = "./data2.xlsx", method="curl")
dateDownloaded <- date()

colIndex <- 7:15
rowIndex <- 18:23
dat <- read.xlsx("data2.xlsx", sheetIndex=1, header=TRUE, colIndex = colIndex, rowIndex = rowIndex)
head(dat)

sum(dat$Zip*dat$Ext,na.rm=T)

library(XML)
fileUrl3 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"
#doc <- xmlTreeParse(fileUrl3, useInternal=TRUE)
doc <- xmlTreeParse(sub("s", "", fileUrl3), useInternal = TRUE)
rootNode <- xmlRoot(doc)
xmlName(rootNode)
zips <- xpathSApply(rootNode, "//zipcode",xmlValue)


fileUrl4 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
download.file(fileUrl4, destfile="./data4.csv", method="curl")
DT <- fread("data4.csv")