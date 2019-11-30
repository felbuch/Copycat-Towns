########################################
## Logistic regression on is_copycat
########################################


rm(list = ls())
gc()

project_folder <- "C:/Users/Felipe/Desktop/Duke MIDS/Modelling and Representation of Data/0 - Final Project/"
results_folder <- paste0(project_folder,"Copycat-Towns/Results/")
setwd(project_folder)

#Load packages
library(magrittr)
library(dplyr)
library(data.table)
library(arm)
library(pROC)
library(ggplot2)
library(stargazer)
source("./Copycat-Towns/Scripts/3 - Analyses/Functions/mice_AUC.R")
#source("./Copycat-Towns/Scripts/3 - Analyses/Functions/save_A10_models_results.R")

#Load data
setwd("./Copycat-Towns/Datasets/3 - Final data/")
load("cities.RData")
load("mi_cities.RData")

names(cities_Z)

###############################################################################
#MODEL 10
m10_desc <- "Logit using gdp. No logged variables nor interactions"
###############################################################################

m10 <- with(mi_cities,
            glm(is_copycat ~ 
                  population +
                  gdp +
                  region +
                  urban_hierarchy +
                  outsourced_accountant + nb_cities_same_accountant,
                family = binomial(link = "logit")))

m10_pooled <- m10 %>% pool()

setwd(results_folder)
jpeg("is_copycat_m10_binned_residuals.jpeg")
binnedplot(m10[[4]][[1]]$fitted.values, m10[[4]][[1]]$residuals)
dev.off()

summary(m10_pooled)
sink("is_copycat_m10_summary.csv")
summary(m10_pooled)
sink()


mice_AUC(m10)
sink("is_copycat_AUC_s.txt")
paste("m10 (",m10_desc,"):", mice_AUC(m10))
sink()

###############################################################################
#MODEL 20
m20_desc <- "Logit using gdp_per_capita. No logged variables nor interactions"
###############################################################################

m20 <- with(mi_cities,
            glm(is_copycat ~ 
                  population +
                  gdp_per_capita +
                  region +
                  urban_hierarchy +
                  outsourced_accountant + nb_cities_same_accountant,
                family = binomial(link = "logit")))

m20_pooled <- m20 %>% pool()

setwd(results_folder)
jpeg("is_copycat_m20_binned_residuals.jpeg")
binnedplot(m20[[4]][[1]]$fitted.values, m20[[4]][[1]]$residuals)
dev.off()

summary(m20_pooled)
sink("is_copycat_m20_summary.csv")
summary(m20_pooled)
sink()


mice_AUC(m20)
sink("is_copycat_AUC_s.txt", append = TRUE)
paste("m20 (",m20_desc,"):", mice_AUC(m20))
sink()


###############################################################################
#MODEL 30
m30_desc <- "Probit using gdp. No logged variables nor interactions"
###############################################################################

m30 <- with(mi_cities,
            glm(is_copycat ~ 
                  population +
                  gdp +
                  region +
                  urban_hierarchy +
                  outsourced_accountant + nb_cities_same_accountant,
                family = binomial(link = "probit")))

m30_pooled <- m30 %>% pool()

setwd(results_folder)
jpeg("is_copycat_m30_binned_residuals.jpeg")
binnedplot(m30[[4]][[1]]$fitted.values, m30[[4]][[1]]$residuals)
dev.off()

summary(m30_pooled)
sink("is_copycat_m30_summary.csv")
summary(m30_pooled)
sink()

mice_AUC(m30)
sink("is_copycat_AUC_s.txt", append = TRUE)
paste("m30 (",m30_desc,"):", mice_AUC(m30))
sink()


###############################################################################
#MODEL 40
m40_desc <- "Probit using gdp_per_capita. No logged variables nor interactions"
###############################################################################


m40 <- with(mi_cities,
            glm(is_copycat ~ 
                  population +
                  gdp_per_capita +
                  region +
                  urban_hierarchy +
                  outsourced_accountant + nb_cities_same_accountant,
                family = binomial(link = "probit")))

m40_pooled <- m40 %>% pool()

setwd(results_folder)
jpeg("is_copycat_m40_binned_residuals.jpeg")
binnedplot(m40[[4]][[1]]$fitted.values, m40[[4]][[1]]$residuals)
dev.off()

summary(m40_pooled)
sink("is_copycat_m40_summary.csv")
summary(m40_pooled)
sink()

mice_AUC(m40)
sink("is_copycat_AUC_s.txt", append = TRUE)
paste("m40 (",m40_desc,"):", mice_AUC(m40))
sink()


###############################################################################
#MODEL 50
m50_desc <- "Logit using gdp. Logged variables. No interactions"
###############################################################################


m50 <- with(mi_cities,
            glm(is_copycat ~ 
                  log_population +
                  log_gdp +
                  region +
                  urban_hierarchy +
                  outsourced_accountant + nb_cities_same_accountant,
                family = binomial(link = "logit")))

m50_pooled <- m50 %>% pool()

setwd(results_folder)
jpeg("is_copycat_m50_binned_residuals.jpeg")
binnedplot(m50[[4]][[1]]$fitted.values, m50[[4]][[1]]$residuals)
dev.off()

summary(m50_pooled)
sink("is_copycat_m50_summary.csv")
summary(m50_pooled)
sink()

mice_AUC(m50)
sink("is_copycat_AUC_s.txt", append = TRUE)
paste("m50 (",m50_desc,"):", mice_AUC(m50))
sink()


###############################################################################
#MODEL 60
m60_desc <- "Logit using gdp_per_capita. Logged variables nor interactions"
###############################################################################

m60 <- with(mi_cities,
            glm(is_copycat ~ 
                  log_population +
                  log_gdp_per_capita +
                  region +
                  urban_hierarchy +
                  outsourced_accountant + nb_cities_same_accountant,
                family = binomial(link = "logit")))

m60_pooled <- m60 %>% pool()

setwd(results_folder)
jpeg("is_copycat_m60_binned_residuals.jpeg")
binnedplot(m60[[4]][[1]]$fitted.values, m60[[4]][[1]]$residuals)
dev.off()

summary(m60_pooled)
sink("is_copycat_m60_summary.csv")
summary(m60_pooled)
sink()

mice_AUC(m60)
sink("is_copycat_AUC_s.txt", append = TRUE)
paste("m60 (",m60_desc,"):", mice_AUC(m60))
sink()


###############################################################################
#MODEL 70
m70_desc <- "Probit using gdp. Logged variables no interactions"
###############################################################################

m70 <- with(mi_cities,
            glm(is_copycat ~ 
                  log_population +
                  log_gdp +
                  region +
                  urban_hierarchy +
                  outsourced_accountant + nb_cities_same_accountant,
                family = binomial(link = "probit")))

m70_pooled <- m70 %>% pool()

setwd(results_folder)
jpeg("is_copycat_m70_binned_residuals.jpeg")
binnedplot(m70[[4]][[1]]$fitted.values, m70[[4]][[1]]$residuals)
dev.off()

summary(m70_pooled)
sink("is_copycat_m70_summary.csv")
summary(m70_pooled)
sink()

mice_AUC(m70)
sink("is_copycat_AUC_s.txt", append = TRUE)
paste("m70 (",m70_desc,"):", mice_AUC(m70))
sink()


###############################################################################
#MODEL 80
m80_desc <- "Probit using gdp_per_capita. Logged variables no interactions"
###############################################################################

m80 <- with(mi_cities,
            glm(is_copycat ~ 
                  log_population +
                  log_gdp_per_capita +
                  region +
                  urban_hierarchy +
                  outsourced_accountant + nb_cities_same_accountant,
                family = binomial(link = "probit")))

m80_pooled <- m80 %>% pool()

setwd(results_folder)
jpeg("is_copycat_m80_binned_residuals.jpeg")
binnedplot(m80[[4]][[1]]$fitted.values, m80[[4]][[1]]$residuals)
dev.off()

summary(m80_pooled)
sink("is_copycat_m80_summary.csv")
summary(m80_pooled)
sink()

mice_AUC(m80)
sink("is_copycat_AUC_s.txt", append = TRUE)
paste("m80 (",m80_desc,"):", mice_AUC(m80))
sink()



###############################################################################
#MODEL 90
m90_desc <- "Logit using gdp_per_capita. Logged variables. population and gdp interacting with region"
#Interactions were not statistically significant
###############################################################################

m90 <- with(mi_cities,
            glm(is_copycat ~ 
                  log_population +
                  log_gdp_per_capita +
                  region +
                  urban_hierarchy +
                  outsourced_accountant + 
                  nb_cities_same_accountant +
                  log_population:region +
                  log_gdp_per_capita:region,
                family = binomial(link = "logit")))

m90_pooled <- m90 %>% pool()

setwd(results_folder)
jpeg("is_copycat_m90_binned_residuals.jpeg")
binnedplot(m90[[4]][[1]]$fitted.values, m90[[4]][[1]]$residuals)
dev.off()

summary(m90_pooled)
sink("is_copycat_m90_summary.csv")
summary(m90_pooled)
sink()

mice_AUC(m90)
sink("is_copycat_AUC_s.txt", append = TRUE)
paste("m90 (",m90_desc,"):", mice_AUC(m90))
sink()


###############################################################################
#MODEL 100
m100_desc <- "Logit using gdp_per_capita. Logged variables. outsourced accountant interacting with region and urban_hierarchy"

###############################################################################

m100 <- with(mi_cities,
            glm(is_copycat ~ 
                  log_population +
                  log_gdp_per_capita +
                  region +
                  urban_hierarchy +
                  outsourced_accountant + 
                  nb_cities_same_accountant +
                  outsourced_accountant:region +
                  outsourced_accountant:urban_hierarchy,
                family = binomial(link = "logit")))

m100_pooled <- m100 %>% pool()

setwd(results_folder)
jpeg("is_copycat_m100_binned_residuals.jpeg")
binnedplot(m100[[4]][[1]]$fitted.values, m100[[4]][[1]]$residuals)
dev.off()

summary(m100_pooled)
sink("is_copycat_m100_summary.csv")
summary(m100_pooled)
sink()

mice_AUC(m100)
sink("is_copycat_AUC_s.txt", append = TRUE)
paste("m100 (",m100_desc,"):", mice_AUC(m100))
sink()



###############################################################################
#MODEL 100
m1000_desc <- "Random forest on one full dataset produced by MICE"
###############################################################################

library(randomForest)
library(pROC)

m1000 <- randomForest(factor(is_copycat) ~ 
                       population +
                       gdp +
                       gdp_per_capita +
                       urban_hierarchy +
                       outsourced_accountant +
                       nb_cities_same_accountant +
                       region +
                       log_population +
                       log_gdp +
                       log_gdp_per_capita,
                     data = complete(mi_cities, 1))




