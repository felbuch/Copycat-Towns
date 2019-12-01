mice_RMSE <- function(with_mice_glm_output){
  
  #Consider a dataset where MI has been performed
  #using the MICE function. You run a glm regression on it
  #using the with(..., glm(...)) routine. This function takes
  #the output of this routine and calculates its AUC
  
  require(magrittr)
  require(pROC)
  
  all_regressions = with_mice_glm_output[[4]]
  m = all_regressions %>% length()
  
  individual_rmse <- NULL
  for(i in 1:m){
    
    regression = all_regressions[[i]]
    yhat <- regression$fitted.values 
    y <- regression$y
    
    rmse <- sqrt(mean((y-yhat)^2))
    individual_rmse %<>%  c(rmse)
    
  }
  
  return(mean(individual_rmse, na.rm = TRUE))
  
}
