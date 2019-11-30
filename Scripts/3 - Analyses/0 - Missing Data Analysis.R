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
mi_cities <- mice(cities_mda, m = 5,  method = "cart")
summary(mi_cities)
sample_n(complete(mi_cities, 1), 10)

#Inspectng quality
densityplot(mi_cities)
stripplot(mi_cities, pch = 20, cex = 1.2)

#Save
setwd(project_folder)
setwd("./Copycat-Towns/Datasets/3 - Final data/")
save(mi_cities, file = "mi_cities.RData")

cities <- cities_mda
save(cities, file = "cities.RData")

