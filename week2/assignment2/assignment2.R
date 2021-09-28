## week 2 assignment
library(plyr)
library(readr)


# part 1
# Write a function named 'pollutantmean' that calculates the mean 
# of a pollutant (sulfate or nitrate) across a specified list of 
# monitors. The function 'pollutantmean' takes three arguments: 
# 'directory', 'pollutant', and 'id'. Given a vector monitor ID 
# numbers, 'pollutantmean' reads that monitors' particulate 
# matter data from the directory specified in the 'directory' 
# argument and returns the mean of the pollutant across all of 
# the monitors, ignoring any missing values coded as NA. A 
# prototype of the function is as follows


pollutantmean <- function(directory, pollutant, id = 1:332) {
    myfiles <- list.files(path = directory,
        pattern = "*.csv", full.names = TRUE)
    df <- data.frame()
    for (i in id) {
        df <- rbind(df, read.csv(myfiles[i]))
    }
    p <- df[,pollutant]
    good <- complete.cases(p)
    p2 <- p[good]
    y <- mean(p2)
    y
}



# part 2
# Write a function that reads a directory full of files 
# and reports the number of completely observed cases in 
# each data file. The function should return a data frame 
# where the first column is the name of the file and the 
# second column is the number of complete cases. A prototype 
# of this function follows

complete <- function(directory, id = 1:332) {
    myfiles <- list.files(path = directory,
        pattern = "*.csv", full.names = TRUE)
    df <- data.frame()
    for (i in id) {
        dftmp <- read.csv(myfiles[i])
        good <- complete.cases(dftmp)
        y <- dftmp[good,]
        nobs <- nrow(y)
        df <- rbind(df, data.frame("id" = i, "nobs" = nobs))
    }
    df
}



# part 3
# Write a function that takes a directory of data files 
# and a threshold for complete cases and calculates the 
# correlation between sulfate and nitrate for monitor 
# locations where the number of completely observed cases 
# (on all variables) is greater than the threshold. The 
# function should return a vector of correlations for 
# the monitors that meet the threshold requirement. If no 
# monitors meet the threshold requirement, then the 
# function should return a numeric vector of length 0. 
# A prototype of this function follows

corr <- function(directory, threshold = 0) {
    myfiles <- list.files(path = directory,
        pattern = "*.csv", full.names = TRUE)
    n <- length(myfiles)
    dfthr <- complete(directory, 1:n)
    v <- vector()
    for (i in 1:n) {
        if (threshold == 0) {
            df <- read.csv(myfiles[i])
            good <- complete.cases(df)
            df2 <- df[good,]
            v <- rbind(v, cor(df2$nitrate, df2$sulfate))
        } else if (dfthr[dfthr$id == i, 2] >= threshold) {
            df <- read.csv(myfiles[i])
            v <- rbind(v, cor(df$nitrate, df$sulfate, use = "complete.obs"))
        }
    }
    if (length(v) == 0) {
        bad <- is.na(v)
        v[!bad]
    } else {
        bad <- is.na(v[, 1])
        v[!bad, 1]
    }
}
