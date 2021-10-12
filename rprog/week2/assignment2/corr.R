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