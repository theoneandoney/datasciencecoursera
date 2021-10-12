rankhospital <- function(state, outcome, num = "best") {
    ## Read outcome data
    df <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
    
    ## Check that state and outcome are valid
    ## start by checking states
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
  
    ## need to switch to numeric, then order by outcome
    df_outcome[,3] <- as.numeric(df_outcome[,3])
    df_ordered <- df_outcome[order(df_outcome[,3], df_outcome[,1]), c(1,3)]
  
    ## Return hospital name in that state with lowest 30-day death rate
    if (num == "best") {
        y <- df_ordered[1,1]
    } else if (num == "worst") {
        y <- df_ordered[nrow(df_ordered),1]
    } else if (num > nrow(df_ordered)) {
        y <- NA
    } else if (num < 1) {
        stop("invalid num")
    } else {
        y <- df_ordered[num,1]
    }
    y
  
}
