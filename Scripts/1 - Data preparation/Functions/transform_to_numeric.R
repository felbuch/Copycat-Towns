
change_decimal_separator <- function(value_as_character){
  
  #Changes decimal separator from coma to point
  
  require(stringr)
  value_as_character <- fin$amount[1]
  value_as_character <- str_replace(value_as_character,",","")
  return(value_as_character)
  }

