clean_email <- function(email){
  
  ### Given an accountant's e-mail,
  ### gets only the name and e-mail provider.
  ### Thus, for example, given an e-mail such as "e-mail: Pikachu@Pokeworld.com.br",
  ### returns Pikachu@Pokeworld
  
  email <- stringi::stri_extract(email,regex = " [[:graph:]]*@[A-Za-z]*")
  email <- stringi::stri_sub(email, 2, nchar(email))
  
  return(email)
}