##########################################################
## Inflated negative binomial regression n_copied_account
##########################################################

#In our best models for is_copycat, log_population and region were
#the significant predictors. Hence, we use these variables to predict
#the inflation at zero portion of our model.

rm(list = ls())
gc()

project_folder <- "C:/Users/Felipe/Desktop/Duke MIDS/Modelling and Representation of Data/0 - Final Project/"
results_folder <- paste0(project_folder,"Copycat-Towns/Results/From_Script_B20")
setwd(project_folder)

#Load packages
library(magrittr)
library(dplyr)
library(data.table)
library(arm)
library(pROC)
library(pscl)
library(ggplot2)
library(stargazer)

#Load data
setwd("./Copycat-Towns/Datasets/3 - Final data/")
load("cities.RData")
load("mi_cities.RData")

names(cities_Z)

###############################################################################
#MODEL 10
m10_desc <- "Zero Inflated Negative Binomial using gdp. No logged variables nor interactions"
###############################################################################

m10 <- with(mi_cities,
            zeroinfl(n_copied_accounts ~ 
                  log_population +
                  log_gdp +
                  region +
                  urban_hierarchy +
                  outsourced_accountant + nb_cities_same_accountant|log_population + region))


m10_pooled <- m10 %>% pool()

setwd(results_folder)
jpeg("m10_residual_diagnostics.jpeg")
residuals <- resid(m10[[4]][[1]], "pearson")
predicted <- predict(m10[[4]][[1]], type = "response")
plot(predicted, residuals)
dev.off()




m10 <- with(mi_cities,
            zeroinfl(n_copied_accounts ~ 
                       log_population +
                       log_gdp +
                       region +
                       urban_hierarchy +
                       outsourced_accountant + 
                       nb_cities_same_accountant))


m10 <- with(mi_cities,
            glm.nb(n_copied_accounts ~ 
                       log_population +
                       log_gdp +
                       region +
                       urban_hierarchy +
                       outsourced_accountant + 
                       nb_cities_same_accountant))

m10
