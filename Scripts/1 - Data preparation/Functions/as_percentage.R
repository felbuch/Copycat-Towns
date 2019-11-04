as.perc <- function(x, digits = 2){
  #Prints a number x as a percentage with the specified number of digits.
  #For example, if x = 0.2345, it will be printed by default as 23.45%
  paste( (100 * as.numeric(x)) %>%  round(digits), "%")}
