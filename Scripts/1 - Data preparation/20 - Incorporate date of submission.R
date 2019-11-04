####################
#RUN AFTER SCRIPT 10
####################

#Set main working directory
project_folder <- "C:/Users/Felipe/Desktop/Duke MIDS/Modelling and Representation of Data/0 - Final Project/"
setwd(project_folder)

#Load packages
library(magrittr)
library(dplyr)
library(data.table)
library(lubridate)

#Load functions
setwd("./Copycat-Towns/Scripts/1 - Data preparation/Functions/")
source("translate_dataset_column_names.R")
source("digits_of_year.R")
source("copycat.R")

#Import data on when each municipality submitted its financial reports
setwd(project_folder)
setwd("./Out-of-git/1 - Raw data/")
submissions <- read.csv("SICONFI submission dates.csv")

#Translate column names into English
column_names_in_english <- c("municipality_id",
                             "municipality",
                             "state",
                             "institution",
                             "date","on_time","unknown_coded_as_X30.04.19","late")
submissions %<>%  translate_dataset_column_names(column_names_in_english)

#Get important columns
submissions %<>% as.data.table
submissions %<>% .[,.(municipality_id, municipality,state,date)]

#Convert date to date formar
submissions[, date := dmy(date)]

#Check if only one year
stopifnot(length(submissions$date %>% year %>% unique) == 1)

#Define deadline (defined by law LRF)
year <- submissions$date %>% year %>% unique 
deadline <- as.Date("2019-04-30", format = "%Y-%m-%d")
rm(year)

#Create an indicator variable for late submission
submissions[, late_submission := 0]
submissions[date > deadline, late_submission := 1]

#Rank from earliest to latest submission
submissions <- submissions[order(date)]

submissions[, rank := 1:nrow(submissions)]
submissions


#Includes info on which city is the copycat in each pair of accounts.

pairs_of_similar_accounts$copycat_id <- pairs_of_similar_accounts[,.(municipality_id, i.municipality_id)] %>% apply(1, copycat)

##################
#NEXT SCRIPT: 30
##################



