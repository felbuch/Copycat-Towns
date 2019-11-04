translate_dataset_column_names <- function(dataset, translated_column_names){
  
  #Gets a dataframe and changes its column's names to the translated_column_names
  
  if(length(translated_column_names) != ncol(dataset)){
    print("ERROR!!! The length of the translated_column_names vector does not equal the number of columns in the dataset")
    break
  }
  
  names(dataset) <- translated_column_names
  return(dataset)
}

