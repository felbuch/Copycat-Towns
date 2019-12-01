##############################################################################
## Poisson and quasi-Poisson regression on on n_copied_account for all cities
##############################################################################

rm(list = ls())
gc()

project_folder <- "C:/Users/Felipe/Desktop/Duke MIDS/Modelling and Representation of Data/0 - Final Project/"
results_folder <- paste0(project_folder,"Copycat-Towns/Results/From_Script_B30")
setwd(project_folder)

#Load packages
library(magrittr)
library(dplyr)
library(data.table)
library(arm)
library(pROC)
library(ggplot2)
library(stargazer)
source("./Copycat-Towns/Scripts/3 - Analyses/Functions/mice_RMSE.R")

#Load data
setwd("./Copycat-Towns/Datasets/3 - Final data/")
load("cities.RData")
load("mi_cities.RData")

names(cities_Z)

###############################################################################
#MODEL 10
m10_desc <- "Poisson using gdp. No logged variables nor interactions"
###############################################################################

m10 <- with(mi_cities,
            glm(n_copied_accounts ~ 
                  population +
                  gdp +
                  region +
                  urban_hierarchy +
                  outsourced_accountant + nb_cities_same_accountant,
                family = poisson))

m10_pooled <- m10 %>% pool()

setwd(results_folder)
jpeg("m10_residual_diagnostics.jpeg")
residuals <- resid(m10[[4]][[1]], "pearson")
predicted <- predict(m10[[4]][[1]], type = "response")
plot(predicted, residuals)
dev.off()

sink("B30_RMSEs.txt")
mice_RMSE(m10)
paste("m10 (",m10_desc,"):", mice_RMSE(m10))
sink()


###############################################################################
#MODEL 20
m20_desc <- "Poisson using gdp_per_capita. No logged variables nor interactions"
###############################################################################

m20 <- with(mi_cities,
            glm(n_copied_accounts ~ 
                  population +
                  gdp_per_capita +
                  region +
                  urban_hierarchy +
                  outsourced_accountant + nb_cities_same_accountant,
                family = poisson()))

m20_pooled <- m20 %>% pool()

jpeg("m20_residual_diagnostics.jpeg")
residuals <- resid(m20[[4]][[1]], "pearson")
predicted <- predict(m20[[4]][[1]], type = "response")
plot(predicted, residuals)
dev.off()

sink("B30_RMSEs.txt", append = TRUE)
paste("m20 (",m20_desc,"):", mice_RMSE(m20))
sink()


###############################################################################
#MODEL 30
m30_desc <- "QuasiPoisson using gdp_per_capita. No logged variables nor interactions"
###############################################################################

m30 <- with(mi_cities,
            glm(n_copied_accounts ~ 
                  population +
                  gdp_per_capita +
                  region +
                  urban_hierarchy +
                  outsourced_accountant + nb_cities_same_accountant,
                family = quasipoisson()))

m30_pooled <- m30 %>% pool()

jpeg("m30_residual_diagnostics.jpeg")
residuals <- resid(m30[[4]][[1]], "pearson")
predicted <- predict(m30[[4]][[1]], type = "response")
plot(predicted, residuals)
dev.off()

sink("B30_RMSEs.txt", append = TRUE)
paste("m30 (",m30_desc,"):", mice_RMSE(m30))
sink()

###############################################################################
#MODEL 40
m40_desc <- "QuasiPoisson using gdp_per_capita. Logged variables. No interactions"
###############################################################################

m40 <- with(mi_cities,
            glm(n_copied_accounts ~ 
                  log_population +
                  log_gdp_per_capita +
                  region +
                  urban_hierarchy +
                  outsourced_accountant + nb_cities_same_accountant,
                family = quasipoisson()))

m40_pooled <- m40 %>% pool()

jpeg("m40_residual_diagnostics.jpeg")
residuals <- resid(m40[[4]][[1]], "pearson")
predicted <- predict(m40[[4]][[1]], type = "response")
plot(predicted, residuals)
dev.off()

sink("B30_RMSEs.txt", append = TRUE)
paste("m40 (",m40_desc,"):", mice_RMSE(m40))
sink()


###############################################################################
#MODEL 50
m50_desc <- "QuasiPoisson using gdp_per_capita. Logged variables. Outsourced accountant interacting with region"
###############################################################################

m50 <- with(mi_cities,
            glm(n_copied_accounts ~ 
                  log_population +
                  log_gdp_per_capita +
                  region +
                  urban_hierarchy +
                  outsourced_accountant + 
                  nb_cities_same_accountant +
                  outsourced_accountant:region,
                family = quasipoisson()))

m50_pooled <- m50 %>% pool()

jpeg("m50_residual_diagnostics.jpeg")
residuals <- resid(m50[[4]][[1]], "pearson")
predicted <- predict(m50[[4]][[1]], type = "response")
plot(predicted, residuals)
dev.off()

sink("B30_RMSEs.txt", append = TRUE)
paste("m50 (",m50_desc,"):", mice_RMSE(m50))
sink()


#Is this model any better than previous one?
#Nope.
anova(m50[[4]][[1]],m40[[4]][[1]], test = "Chisq")



