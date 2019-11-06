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

#Identify different municipalities with the same amount in the same account
#Accounts with zero value do not count for as similar accounts
stopifnot(is_unique_key(data_table = fin, key = c("account","municipality_id"))) #Checkpoint

pairs_of_similar_accounts <- fin[fin, on = .(account,amount), nomatch = 0]
pairs_of_similar_accounts %<>% .[amount != 0]
pairs_of_similar_accounts %<>% .[municipality_id != i.municipality_id]

#Consider as matching only accounts which have at least "digits_to_match" digits
pairs_of_similar_accounts %<>% .[,ndigits := n_digits(amount)]
pairs_of_similar_accounts %<>% .[ndigits >= digits_to_match]
pairs_of_similar_accounts[,ndigits := NULL]


#Our key here is a pair of municipalities which share an account with similar value
stopifnot(is_unique_key(data_table = pairs_of_similar_accounts, key = c("municipality_id","i.municipality_id","account","amount")))

#We do not consider similar accounts which are both zero
stopifnot(nrow(pairs_of_similar_accounts[amount == 0]) == 0)

#A few remarks:
# 1 - Each pair of municipalities appear twice in the database, in reverse order. 
# Thus, one has A-B in one line and B-A in another line, representing a single fact: that A and B share a similar account.
# 2 - It follows that the number of similarities is actually half the number of rows in the similar accounts.
# 3 - It also follows that nrow(similar_accounts) should be an even number, so we check that:


stopifnot(nrow(pairs_of_similar_accounts) %% 2 == 0)

#4 - The unit of analysis here is a pair. However, we only have nrows(similar_accounts / 2) pairs with similar 
# out of a total of (Choose(nrow(fin18),2)) possibilities. This is really small. In fact, that is
(nrow(pairs_of_similar_accounts)/2) / choose(nrow(fin),2)

#Identify in the fin dataset which account either is a copy or was coppied.
#Note that each line in this dataframe is an account of a given municipality. 


##################
#NEXT SCRIPT: 20
##################

