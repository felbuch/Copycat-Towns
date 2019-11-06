n_digits <- function(x){
  
  ### Calculates number of digits of a numeric value
  ### e.g. 314.15 has 5 digits.
  ### Likewise, -0.01 has 3 digits
  
  ch <- as.character(abs(x)) #Absolute value of the number expressed as a character
  ch <- gsub("\\.","",ch) #Remove eventual dot so it doesn't count as digit
  n <- nchar(ch) #Count number of characters
  return(n)
}
