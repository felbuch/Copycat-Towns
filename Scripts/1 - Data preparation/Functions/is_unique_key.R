is_unique_key <- function(data_table, key){
  #Checks if a key is unique for every row in a datatable
  #If true, returns TRUE
  #If false, returns FALSE and a data table with how many times each key appears.
  #This data table is sorted in decreasing order of frequencies.
  frequency_table <- data_table[ , .N, by = key]
  frequencies <- frequency_table$N
  test <- prod(frequencies) == 1
  
  if(test){
    return(test)
  }else{
    frequency_table <- frequency_table[order(-N)] 
    return(list(key_is_unique = test, key_counts = frequency_table))
  }
}
