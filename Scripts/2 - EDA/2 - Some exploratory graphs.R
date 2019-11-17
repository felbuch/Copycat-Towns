#rm(list = ls());gc()

#Set main working directory
project_folder <- "C:/Users/Felipe/Desktop/Duke MIDS/Modelling and Representation of Data/0 - Final Project/"
setwd(project_folder)

#Load packages
library(magrittr)
library(dplyr)
library(data.table)
library(dlookr)
library(ggplot2)

#Load data
load("./Copycat-Towns/Datasets/2 - Intermediary data/Cities_with_Covariates.RData")
str(cities)
cities %<>% as.data.table()

###################
#NUMERIC VARIABLES
###################

diagnose_numeric(cities)

#Basic "does it make sense" analysis
cities[gdp < 0] %>% nrow
cities[order(-gdp)][,.(municipality)] %>% head(10)
cities[order(-population)][,.(municipality)] %>% head(10)

plot_correlate(cities[,.(population,n_copied_accounts,gdp,gdp_per_capita)])


cities_rf <- cities[complete.cases(cities), ] %>% as.data.table
cities_rf[, municipality_id := NULL]
cities_rf[, municipality := NULL]
cities_rf$state %<>% as.factor()
cities_rf$is_copycat %<>% as.factor()
cities_rf$accountant %<>% as.factor()
cities_rf$uncompliant_w_health_ministry %<>% as.factor()
cities_rf$outsourced_accountant %<>% as.factor()

rf <- randomForest::randomForest(as.factor(is_copycat) ~ . -accountant -n_copied_accounts, data = cities_rf)
rf

randomForest::importance(rf) %>% as.data.frame(optional = TRUE)


rf <- randomForest::randomForest(n_copied_accounts ~ . -accountant -is_copycat, data = cities_rf)
rf


cities$n_copied_accounts %<>% as.factor
levels(cities$n_copied_accounts)

#Size doesn`t seem to matter that much`
ggplot(data = cities, aes(x = population, y = gdp_per_capita, color = n_copied_accounts)) + 
  geom_point() +
  scale_x_log10() +
  scale_y_log10() #+
#  scale_color_brewer(type = "seq", palette = 2)


ggplot(data = cities[is_copycat == 1], aes(x = population, y = gdp_per_capita, color = n_copied_accounts)) + 
  geom_point() +
  scale_x_log10() +
  scale_y_log10()


ggplot(data = cities, aes(x = population, y = gdp_per_capita, color = is_copycat)) + 
  geom_point() +
  scale_x_log10() +
  scale_y_log10() +
  facet_wrap(~urban_hierarchy)


ggplot(data = cities, aes(x = population, y = gdp_per_capita, color = is_copycat)) + 
  geom_point() +
  scale_x_log10() +
  scale_y_log10() +
  facet_wrap(~outsourced_accountant)


cities$urban_hierarchy %<>% as.factor() 
ggplot(data = cities[is_copycat == 1], aes(y = n_copied_accounts)) + geom_boxplot(group = urban_hierarchy)
ggplot(data = cities[is_copycat == 1], aes(group = outsourced_accountant, y = n_copied_accounts)) + geom_boxplot()
ggplot(data = cities[is_copycat == 1], aes(group = uncompliant_w_health_ministry, y = n_copied_accounts)) + geom_boxplot()

ggplot(data = cities[is_copycat == 1], aes(x = n_copied_accounts, group = outsourced_accountant, fill = outsourced_accountant, alpha = 0.3)) + geom_density()

cities$shares_accountant <- ifelse(cities$nb_cities_same_accountant > 1, 1, 0)
ggplot(data = cities[is_copycat == 1 & !is.na(shares_accountant)], aes(x = n_copied_accounts, group = shares_accountant, fill = shares_accountant, alpha = 0.3)) + geom_density()


ggplot(data = cities[is_copycat == 1], aes(y = n_copied_accounts, group = nb_cities_same_accountant)) + geom_boxplot()

ggplot(data = cities[is_copycat == 1], aes(y = n_copied_accounts, x = nb_cities_same_accountant)) + geom_point()


pairs_of_similar_accounts[]


ggplot(data = cities[is_copycat == 1], aes(y = n_copied_accounts, x = nb_cities_same_accountant)) + geom_point()

ggplot(data = cities[is_copycat == 1], aes(x = nb_cities_same_accountant, y = n_copied_accounts)) + 
  geom_point()  +
  facet_wrap(~state)

