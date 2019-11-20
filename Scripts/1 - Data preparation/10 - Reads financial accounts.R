#rm(list = ls());gc()
#digits_to_match <- 5 #For two accounts to be considered equal, they must have at least how many digits?


#Set main working directory
project_folder <- "C:/Users/Felipe/Desktop/Duke MIDS/Modelling and Representation of Data/0 - Final Project/"
setwd(project_folder)

#Load packages
library(magrittr)
library(dplyr)
library(data.table)
library(ggplot2)

#Load functions
setwd("./Copycat-Towns/Scripts/1 - Data preparation/Functions/")
source("translate_dataset_column_names.R")
source("create_account_id.R")
source("remove_repeating_zeros_between_dots.R")
source("as_percentage.R")
source("is_unique_key.R")
source("change_decimal_separator.R")
source("n_digits.R")

#Import financial accounts datasets
setwd(project_folder)
setwd("./Out-of-git/1 - Raw data/")
#fin = fread("Brazil Municipalities Balance Sheets 2018.csv")
fin_1 = fread("Brazil Municipalities Balance Sheets 2018.csv")
fin_2 = fread("Brazil Municipalities Change in Wealth 2018.csv")
fin = rbind(fin_1, fin_2)
rm(fin_1, fin_2);gc()

#Define english translation of column names
names_fin_datasets <- c("municipality",
                        "municipality_id",
                        "state",
                        "population",
                        "account_type",
                        "account",
                        "amount")

#Translate column names to english
fin %<>%  translate_dataset_column_names(names_fin_datasets)

#Does each account appear only once per municipality?
stopifnot(is_unique_key(data_table = fin, key = c("account","municipality_id")))

#Set key
setkey(fin, account, municipality_id)

# Transforms the amount in accounts from brazilian notation (i.e. comma instead of point for decimals) and
# as a character) into a numeric value
fin[ , amount := change_decimal_separator(amount)]
fin$amount %<>% as.numeric

stopifnot(is.numeric(fin$amount)) #Checkpoint

fin[,account_type := NULL] #Discard unnecessary variable

#Remove accounts with zero value
fin <- fin[amount != 0]

#Identify different municipalities with the same amount in the same account
stopifnot(is_unique_key(data_table = fin, key = c("account","municipality_id"))) #Checkpoint

#Save dataset with financial accounts.
#It will be used both for finding pairs of accounts
#and for answering the question of when is a match a mere coincidence.
setwd(project_folder)
setwd("./Copycat-Towns/Datasets/2 - Intermediary data/")
save(fin, file = "accounts.RData")
##################
#NEXT SCRIPT: 15
##################

