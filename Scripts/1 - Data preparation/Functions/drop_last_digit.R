drop_last_digit <- function(x){
  
  ### Drops last digit of a numeric value.
  ### For example, 31415 becomes 3141.
  ### We use this because in the accountants dataset,
  ### municipality_id has the final digit missing.
  
  return(floor(x/10))
}