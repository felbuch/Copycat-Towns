save_A10_models_results <- function(mx,
                                mx_name,
                                mx_desc,
                                Y_name = "is_copycat",
                                project_folder = "C:/Users/Felipe/Desktop/Duke MIDS/Modelling and Representation of Data/0 - Final Project/",
                                results_folder = paste0(project_folder,"Copycat-Towns/Results/")
){
  
  #Consider a glm classification regression produced
  #using the with(..., glm(...)) routine. This function takes
  #the output of this routine and saves some relevant output
  
  pooled <- mx %>% pool()
  
  #Makes binned plot residual and saves to file
  setwd(results_folder)
  graph_name <- paste0(Y_name,"_",mx_name,"_binned_residuals.jpeg")
  jpeg(graph_name)
  binnedplot(mx[[4]][[1]]$fitted.values, mx[[4]][[1]]$residuals)
  dev.off()
  
  #Saves summary to file
  summary(pooled)
  summary_file_name <- paste0(Y_name,"_",mx_name,"_summary.txt")
  sink(summary_file_name)
  summary(pooled)
  sink()
  
  auc <- mice_AUC(mx)
  auc
  auc_file_name <- paste0(Y_name,"_AUC.txt")
  sink(auc_file_name, append = TRUE)
  paste(mx_name, "(",mx_desc,"):",auc)
  sink()
  
  
}