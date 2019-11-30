#####################################################
## Linear regression on n_copied_account for n >= 1
#####################################################

#All in all, assumptions of the linear regression model are not satisfied.

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
load("mi_copycat_cities.RData")

#Let's get an example of a complete dataset generated from MICE
example <- complete(mi_copycat_cities,1)
hist(example$n_copied_accounts, nclass = 100)
dlookr::plot_normality(example)
example$n_copied_accounts %>% summary()

#Let's look at histogram
hist(example %>% filter(n_copied_accounts < 50) %>% dplyr::select(n_copied_accounts), nclass = 100)


#MODEL 10
#No interactions log

no_interactions_log <- with(mi_copycat_cities,
                              lm(log(n_copied_accounts) ~ 
                                    #                         state + 
                                    population + 
                                    gdp +       #gdp_per_capita seems to leave worse residuals 
                                    urban_hierarchy + 
                                    outsourced_accountant + 
                                    nb_cities_same_accountant + 
                                    region))

res_10 <- no_interactions_log[[4]][[1]]$residuals

qqnorm(res_10)
qqline(res_10)


plot(no_interactions_log[[4]][[1]])

#MODEL 20
#No interactions sqrt

no_interactions_sqrt <- with(mi_copycat_cities,
                            lm(sqrt(n_copied_accounts) ~ 
                                 #                         state + 
                                 population + 
                                 gdp +       #gdp_per_capita seems to leave worse residuals 
                                 urban_hierarchy + 
                                 outsourced_accountant + 
                                 nb_cities_same_accountant + 
                                 region))

res_20 <- no_interactions_sqrt[[4]][[1]]$residuals

qqnorm(res_20)
qqline(res_20)


#The log transformation seems to adhere better to the assumption of normality of the residuals

plot(no_interactions_sqrt[[4]][[1]])
