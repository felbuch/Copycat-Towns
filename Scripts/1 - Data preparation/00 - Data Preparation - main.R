rm(list = ls())
gc()

digits_to_match <- 3 #For two accounts to be considered equal, they must have at least how many digits?
project_folder <- "C:/Users/Felipe/Desktop/Duke MIDS/Modelling and Representation of Data/0 - Final Project/"
scripts_folder <- paste0(project_folder,"./Copycat-Towns/Scripts/")
data_prep_folder <- paste0(scripts_folder, "./1 - Data preparation/")


setwd(data_prep_folder)
source("10 - Reads financial accounts.R")
setwd(data_prep_folder)
source("15 - Finds pairs of similar accounts.R")
setwd(data_prep_folder)
source("20 - Incorporate date of submission.R")
setwd(data_prep_folder)
source("30 - Prepares dataset of copycat cities.R")
setwd(data_prep_folder)
source("40 - Incorporate economic data.R")
setwd(data_prep_folder)
source("50 - Incorporate accountants info.R")
setwd(data_prep_folder)
source("60 - Feature Engineering.R")
setwd(data_prep_folder)
source("70 - Standardized numerical covariates.R")
