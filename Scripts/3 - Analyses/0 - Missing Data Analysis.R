rm(list = ls())
gc()

project_folder <- "C:/Users/Felipe/Desktop/Duke MIDS/Modelling and Representation of Data/0 - Final Project/"
setwd(project_folder)

#Load packages
library(magrittr)
library(dplyr)
library(data.table)
library(mice)


#Load data
load("./Copycat-Towns/Datasets/2 - Intermediary data/Cities_with_Covariates.RData")
cities %<>% as.data.table()
str(cities)

cities_mda <- cities[,c("municipality_id","municipality","accountant","uncompliant_w_health_ministry") := NULL]

#Missing Data Pattern
md.pattern(cities_mda)

#We only have missing data in the nb_cities_same_accountant

#Lets do multiple imputation
#We use method *cart* because some of our variables are highly unbalanced

#We first do for the entire dataset----------------------------------------
mi_cities <- mice(cities_mda, m = 10,  method = "cart", seed = 314)
summary(mi_cities)
sample_n(complete(mi_cities, 1), 10)
plot(mi_cities)


#Inspectng quality
densityplot(mi_cities)
stripplot(mi_cities, pch = 20, cex = 1.2)
#End of multiple imputation for the entire dataset----------------------------------------

#Now we do only for cities which copy at least one account----------------------------------------
cities_mds_filtered <- cities_mda[is_copycat == 1][n_copied_accounts < 50] 
# There are only 3 cities with more than 50 copied accounts and they are clearly outliers
# Indeed, the 3rd quartile of n_copied_accounts for is_copycat == 1 is 4
mi_copycat_cities <- mice(cities_mds_filtered, m = 10,  method = "cart", seed = 314)
summary(mi_copycat_cities)
sample_n(complete(mi_copycat_cities, 1), 10)
plot(mi_copycat_cities)
#--------------------------------------------------------------------------------------------------

#Save
setwd(project_folder)
setwd("./Copycat-Towns/Datasets/3 - Final data/")
save(mi_cities, file = "mi_cities.RData")
save(mi_copycat_cities, file = "mi_copycat_cities.RData")






cities <- cities_mda
save(cities, file = "cities.RData")

