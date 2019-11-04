smart_as_Date <- function(string_representing_date, sep = "/"){
  
  ### Transform string representing date to a date object
  ### regardless on whether the year is represented as a 2 or 4 digit year
  
  require(stringr)
  
  #Splits stirng into date parts
  correct_date <- str_split(string_representing_date, sep)[[1]]
  
  #Substitute year by two last digits of year.
  #If the year only had two digits in the first place, this does nothing.
  correct_date[3] %<>% str_sub(-2,-1)
  
  return(correct_date)
  
}



digits_of_year <- function(string_representing_date, sep = "/"){
  ### Identify if year is represented as a 2 or 4 digit year in a string representing a date
  
  correct_date <- stringr::str_split(string_representing_date, sep)[[1]]
  year = correct_date[3]
  return(nchar(year))
}



