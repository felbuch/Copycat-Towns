get_name_from_email <- function(email){
  
  ### Given an e-mail from an accountant, grabs his name.
  ### The name is understood as everything which comes after the "e-mail: " and before the "@".
  ### For example, in "e-mail: Pikachu@Pokeworld.com", "Pikachu" is the name.
  
  name <- stringi::stri_extract(email,regex = " [[:graph:]]*@")
  name <- stringi::stri_sub(name, 2, nchar(name)-1)
  
  return(name)
}