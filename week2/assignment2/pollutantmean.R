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