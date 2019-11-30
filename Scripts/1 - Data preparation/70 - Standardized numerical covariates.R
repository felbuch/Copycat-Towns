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

cities_Z <- cities #Cities with standardized covariates

#We sill standardize the following covariates:
#population, gdp, gdp_per_caipta and their logarithms.
#We WILL NOT standardize the nb_cities_same_accountant
#because we are interested in retaining interpretation from this variable
#and also because this variable is very skewed and the majority of cities
#already have the convenient value of 0, which we want to keep as a baseline
#for interpretation.

#standardize population
cities_Z[,population := scale(population)]
cities_Z[,log_population := scale(log_population)]

#standardize gdp
cities_Z[,gdp := scale(gdp)]
cities_Z[,log_gdp := scale(log_gdp)]

#standardize gdp_per_capita 
cities_Z[,gdp_per_capita := scale(gdp)]
cities_Z[,log_gdp_per_capita := scale(log_gdp_per_capita)]

setwd(project_folder)
setwd("Copycat-Towns/Datasets/2 - Intermediary data/")
save(cities_Z, file = "standardized_cities.RData")
