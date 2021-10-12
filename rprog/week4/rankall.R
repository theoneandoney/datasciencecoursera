rankall <- function(outcome, num= "best") {
    ## read outcome data
    df <- read.csv("outcome-of-care-measures.csv", colClasses = "character")

    ## check that state and outcome are valid
    ## first, generate list of all possible states
    states <- names(table(df$State))

    ## next, subset by outcome
    if (outcome == "heart attack"){ 
      ## column 11 == heart attack outcomes
      ## only keep name, state, and outcome, ignore "Not Available"
      bad <- df[,11] == "Not Available"
      df_outcome <- df[!bad,c(2,7,11)]
      df_outcome[,3] <- as.numeric(df_outcome[,3])
  
    } else if (outcome == "heart failure"){
      ## column 17 == heart failure outcomes
      ## only keep name, state, and outcome, ignore "Not Available"
      bad <- df[,17] == "Not Available"
      df_outcome <- df[!bad,c(2,7,17)] 
      df_outcome[,3] <- as.numeric(df_outcome[,3])
  
    } else if (outcome == "pneumonia"){
      ## column 23 == pneumonia outcomes
      ## only keep name, state, and outcome, ignore "Not Available"
      bad <- df[,23] == "Not Available"
      df_outcome <- df[!bad,c(2,7,23)] 
      df_outcome[,3] <- as.numeric(df_outcome[,3])
  
    } else {
      stop("invalid outcome")
    }

    # y <- data.frame(hospital = character(), states)
    # ## for each state, find the hospital of the given rank
    # for (state in y$states) {

    # }

    df_out <- data.frame(hospital = character(), state = character())

    ## for each state, find the hospital of the given rank
    for (state in states) {
        df_states <- df_outcome[df_outcome$State == state,]
        if (nrow(df_states) == 0){
            stop("invalid state")
        }
        df_ordered <- df_states[order(df_states[,3], df_states[,1]),]

        if (num == "best") {
            y <- df_ordered[1,c(1,2)]

        } else if (num == "worst") {
            y <- df_ordered[nrow(df_ordered),c(1,2)]

        } else if (num > nrow(df_ordered)) {
            y <- c(NA, state)

        } else if (num < 1) {
            stop("invalid num")
        } else {
            y <- df_ordered[num,c(1,2)]
        }
        
        df_out[nrow(df_out) + 1,] = y

    }

    ## return df with the hospital names and state name
    df_out



}