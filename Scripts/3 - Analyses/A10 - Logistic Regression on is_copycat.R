########################################
## Logistic regression on is_copycat
########################################


rm(list = ls())
gc()

project_folder <- "C:/Users/Felipe/Desktop/Duke MIDS/Modelling and Representation of Data/0 - Final Project/"
setwd(project_folder)

#Load packages
library(magrittr)
library(dplyr)
library(data.table)
library(arm)
library(ggplot2)
library(stargazer)

#Load data
setwd("./Copycat-Towns/Datasets/3 - Final data/")
load("cities.RData")
load("mi_cities.RData")

names(cities)


#gdp performed better than gdp per capita (less violation of models assumptions verified in binned residual plot)
#so we use gdp rather than gdp per capita

#MODEL 10
#No interactions logit

no_interactions_logit <- with(mi_cities,
                        glm(is_copycat ~ 
#                         state + 
                         population + 
                         gdp +       #gdp_per_capita seems to leave worse residuals 
                         urban_hierarchy + 
                         outsourced_accountant + 
                         nb_cities_same_accountant + 
                         region,
                       family = binomial(link = "logit")))


#Regression diagnostics
binnedplot(no_interactions_logit[[4]][[1]]$fitted ,no_interactions_logit[[4]][[1]]$residuals)


no_interactions_logit_pool <- no_interactions_logit %>% pool



summary(no_interactions_logit_pool)


#MODEL 15
#No interactions probit

no_interactions_probit <- with(mi_cities,
                              glm(is_copycat ~ 
                                    #                         state + 
                                    population + 
                                    gdp + 
                                    urban_hierarchy + 
                                    outsourced_accountant + 
                                    nb_cities_same_accountant + 
                                    region,
                                  family = binomial(link = "probit")))


#Regression diagnostics
binnedplot(no_interactions_probit[[4]][[1]]$fitted ,no_interactions_probit[[4]][[1]]$residuals)


no_interactions_probit_pool <- no_interactions_probit %>% pool


summary(no_interactions_probit_pool)





#MODEL 20
#With interactions region x outsourced accountant
interactions_20 <- with(mi_cities,
                        glm(is_copycat ~ 
#                             state + 
                              population + 
                              gdp_per_capita + 
                              urban_hierarchy + 
                              outsourced_accountant + 
                              nb_cities_same_accountant + 
                              region +
                              region:outsourced_accountant,
                            family = binomial(link = "logit")))

binnedplot(interactions_20[[4]][[1]]$fitted ,interactions_20[[4]][[1]]$residuals)

summary(interactions_20)


