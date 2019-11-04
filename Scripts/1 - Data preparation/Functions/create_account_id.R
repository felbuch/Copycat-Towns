create_account_id <- function(accounts){
  
  #Given a column of accounts, creates an account_id for it.
  #The account is either a plain name or a number followed by a dash and a name.
  splitted_account <- accounts %>% strsplit(" - ")
  account_id <- lapply(splitted_account, function(x){return(x[1])}) %>% unlist
  return(account_id)
}

