args = commandArgs(trailingOnly=TRUE)

## Command Line Arguments:
##### 1. mode (REQ) -- either:
#                           'new' -- add a row, OR
#                           'rj' -- update a row (partial match on position + employer combo) 
#                             with "rejected on" [date].  
#                           'lc' -- same as rj, minus the "rejected on" bit (it just inserts date)
#     2. position (REQ) -- a string. partial matching supported for rj and lc
#     3. employer (REQ) -- a string
#     4. date(OPT, rj and lc mode only) -- specify the date of rejection or correspondence.
#                                         if you do not specify, it will default to today.
##### ... values for any additional columns you wish to populate in 'new' mode

## This version will look for "Position" and "Employer" columns (case sensitive). It also assumes they are your first two columns.

cor_col <- 5   # The position of your date of last correspondence column

if(!(args[1] %in% c("new","rj","lc"))){stop("choose mode: enter 'new' for new entries,
                                            'rj' for rejections, or 'lc' for correspondence")
  
}
df <- read.csv("./Applications/application-tracker.csv")   ## Specify your csv file here

## New mode:
if(args[1] == "new"){
  newrow <- nrow(df)+1
  if(length(args) < 2){stop("enter more arguments")} 
  if(length(args) > 1){
    df[newrow, 1] <- args[2]
    df[newrow, 2] <- args[3]
    df[newrow, 3] <- args[4]
  }
  if(length(args) > 4){
  for(i in 5:length(args))
    df[newrow, i] <- args[i]
}
}

## Rejection Mode:
if(args[1] == "rj") {  # rejection mode: specify position in arg 2 and employer in arg 3 (partial matching supported)
  if(length(args) < 3){stop("Enter position and employer arguments")}
  if(nrow(df[grepl(args[2], df$Position) & grepl(args[3], df$Employer),]) != 1) {
    stop(paste("combination position", args[2], "and employer", args[3], "not found or not unique"))}
  if(length(args) > 3){rejectday <- args[4]}
  else{rejectday <- date()}
  df[grepl(args[2], df$Position) & grepl(args[3], df$Employer), cor_col] <- paste("Rejected on", rejectday) 
}


## Latest Correspondence Mode:
if(args[1] == "lc"){
  if(length(args) < 2){
    if(length(args) < 3){stop("Enter position and employer arguments")}
    if(nrow(df[grepl(args[2], df$Position) & grepl(args[3], df$Employer),]) != 1) {
      stop("combination not found or not unique")}
    if(length(args) > 3){corday <- args[4]}
    else{corday <- date()}
    df[grepl(args[2], df[,df$Position]) & grepl(args[3], df$Employer), cor_col] <- corday # Latest Correspondence is column 5
    
  }
}

write.csv(df, "./Applications/application-tracker.csv",row.names=FALSE)  ## Name your CSV here

