#####################################################
## Linear regression on n_copied_account for n >= 1
#####################################################

#All in all, assumptions of the linear regression model are not satisfied.

rm(list = ls())
gc()

project_folder <- "C:/Users/Felipe/Desktop/Duke MIDS/Modelling and Representation of Data/0 - Final Project/"
results_folder <- paste0(project_folder,"Copycat-Towns/Results/From_Script_B10")
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


###############################################################################
#MODEL 10
m10_desc <- "Linear regression using gdp. No logged variables nor interactions"
###############################################################################

m10 <- with(mi_copycat_cities,
            lm(n_copied_accounts ~ 
                 population + 
                 gdp + 
                 urban_hierarchy + 
                 outsourced_accountant + 
                 nb_cities_same_accountant + 
                 region))

m10_pooled <- m10 %>% pool


setwd(results_folder)

jpeg("residual_diagnostics_m10.jpeg")
par(mfrow=c(2,2))
plot(m10[[4]][[1]], 1)
plot(m10[[4]][[1]], 2)
plot(m10[[4]][[1]], 3)
plot(m10[[4]][[1]], 4)
par(mfrow=c(1,1))
dev.off()


###############################################################################
#MODEL 20
m20_desc <- "Linear regression using gdp. Logged-transformed variables. No interactions"
###############################################################################

m20 <- with(mi_copycat_cities,
            lm(log(n_copied_accounts) ~ 
                 log_population + 
                 log_gdp + 
                 urban_hierarchy + 
                 outsourced_accountant + 
                 nb_cities_same_accountant + 
                 region))

m20_pooled <- m20 %>% pool

setwd(results_folder)

jpeg("residual_diagnostics_m20.jpeg")
par(mfrow=c(2,2))
plot(m20[[4]][[1]], 1)
plot(m20[[4]][[1]], 2)
plot(m20[[4]][[1]], 3)
plot(m20[[4]][[1]], 4)
par(mfrow=c(1,1))
dev.off()


