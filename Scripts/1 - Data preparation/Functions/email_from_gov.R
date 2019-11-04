email_from_gov <- function(email){
  
  ### Returns 1 if an e-mail address has a .gov. domains and 0 otherwise
  
  boolean = grepl("\\.gov\\.",email) # True or False
  numeric = as.numeric(boolean) # 1 or 0
  return(numeric)
  
}