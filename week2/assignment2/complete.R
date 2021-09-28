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