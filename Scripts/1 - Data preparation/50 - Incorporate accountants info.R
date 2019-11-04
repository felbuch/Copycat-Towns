

library(magrittr)
library(data.table)
library(zoo)
setwd(project_folder)
source("./Copycat-Towns/Scripts/1 - Data preparation/Functions/drop_last_digit.R")

#Define the number of sheets in the Excel workbook file containing information data
#(It's 26, but I didn't want just to hard code it.)
nb_sheets <- readxl::excel_sheets("./Out-of-git/1 - Raw data/Accountants.xlsx") %>% length()

#Create list to store the datatables for each sheet
accountants_list_of_sheets <- list()

#Loop over all sheets in the Excel file and store them as elements in the list
for(sheet_nb in 1:nb_sheets){
  accountants <- readxl::read_xlsx("./Out-of-git/1 - Raw data/Accountants.xlsx", sheet = sheet_nb) %>% as.data.table()
  accountants_list_of_sheets[[sheet_nb]] <- accountants
}

#Concatenate all elements of list into a single data table with info on accountants
accountants <- do.call(rbind, accountants_list_of_sheets)
rm(accountants_list_of_sheets, nb_sheets, sheet_nb)

#Translate names to English
names(accountants) <- c("municipality","municipality_id","mayor","secretary","accountant")
accountants %>% is.data.table #Checkpoint of format

#The Excel file had merged tables.
#We now wrangle the data to put it into a formal dataset
#We use the accountant's e-mail as a way to identify the accountant
accountants <- na.locf(accountants)
accountants %<>% .[accountant %like% "e-mail:",.(municipality_id, accountant)]
accountants %<>% unique()

# is_unique_key(accountants, "municipality_id") #Checkpoint




#Before we merge this dataset, 
#we must acknowledge de fact that the municipality_id in the cities dataset
#has one aditional (verifying) digit that the municipality_id in the accountants dataset lacks.
#Therefore, we create a new variable where we drop the last digit of the municipality_id 
#in the cities. We thus use this variable as a key to merge the two datasets.
cities %<>% as.data.table()
cities[, short_municipality_id := drop_last_digit(municipality_id)]

#Merge this dataset with the cities dataset
cities <- dplyr::left_join(cities, accountants, by = c("short_municipality_id" = "municipality_id"))
cities %<>% dplyr::select(-short_municipality_id)


head(cities)
names(cities)
names(accountants)
mean(x$municipality_id)
is.na(x) %>% mean

