best <- function(state, outcome) {
  ## Read outcome data
  df <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
  
  ## Check that state and outcome are valid
  ## Return hospital name in that state with lowest 30-day death rate

  # start by checking states
  df_states <- df[df$State == state,]
  if (nrow(df_states) == 0){
    stop("invalid state")
  }

  # now subset by outcome
  if (outcome == "heart attack"){ 
    ## column 11 == heart attack outcomes
    ## only keep name, state, and outcome, ignore "Not Available"
    bad <- df_states[,11] == "Not Available"
    df_outcome <- df_states[!bad,c(2,7,11)] 

  } else if (outcome == "heart failure"){
    ## column 17 == heart failure outcomes
    ## only keep name, state, and outcome, ignore "Not Available"
    bad <- df_states[,17] == "Not Available"
    df_outcome <- df_states[!bad,c(2,7,17)] 

  } else if (outcome == "pneumonia"){
    ## column 23 == pneumonia outcomes
    ## only keep name, state, and outcome, ignore "Not Available"
    bad <- df_states[,23] == "Not Available"
    df_outcome <- df_states[!bad,c(2,7,23)] 

  } else {
    stop("invalid outcome")
  }

  ## find the "best" by taking minimum value of outcome, first
  ## need to switch to numeric
  df_outcome[,3] <- as.numeric(df_outcome[,3])
  thebest <- df_outcome[df_outcome[,3] == min(df_outcome[,3]),1]
  
  ## if only one hospital is best return it, otherwise return list
  ## in alphabetical order
  if (length(thebest) == 1) {
    y <- thebest[1]
    #print(y)
  } else {
    y <- sort(thebest)
    #print(y)
  }
  
  y
  }

