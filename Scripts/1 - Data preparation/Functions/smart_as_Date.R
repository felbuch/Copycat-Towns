smart_as_Date <- function(string_representing_date, sep = "/"){
  
  ### Transform string representing date to a date object
  ### regardless on whether the year is represented as a 2 or 4 digit year
  
  require(stringr)
  require(lubridate)
  
  #Splits stirng into date parts
  correct_date <- str_split(string_representing_date, sep)[[1]]
  
  #Substitute year by two last digits of year.
  #If the year only had two digits in the first place, this does nothing.
  correct_date[3] %<>% str_sub(-2,-1)
  
  #Convert to date format
  output <- as.Date(correct_date, "%d/%m/%y")
  
  return(output)
  
}

