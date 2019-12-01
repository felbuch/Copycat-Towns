project_folder <- "C:/Users/Felipe/Desktop/Duke MIDS/Modelling and Representation of Data/0 - Final Project/"
analysis_folder <- paste0(project_folder,"/Copycat-Towns/Scripts/3 - Analyses/")
setwd(analysis_folder)

source("0 - Missing Data Analysis.R")
setwd(analysis_folder)
source("A10 - Logistic Regression on is_copycat.R")
setwd(analysis_folder)
source("B10 - Linear Regression on n_copied_accounts_for_copycats.R")
setwd(analysis_folder)
source("B20 - Poisson Regression on n_copied_accounts_for_copycats.R")
setwd(analysis_folder)
source("B30 - Poisson Regression on n_copied_accounts_for_all_cities.R")
setwd(analysis_folder)
#source("C10 - Zero Inflated Negative Binomial on n_copied_accounts.R")

