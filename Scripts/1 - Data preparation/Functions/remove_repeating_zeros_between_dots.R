remove_repeating_zeros_between_dots <- function(account_number){
  
  #Standardizes account number by ensuring no double zeros exist between dots.
  #Hence, account 1.0.00.00.0 will become 1.0.0.0.0
  
  standardized_account_number <- gsub(".00",".0",account_number)
  return(standardized_account_number)
}


