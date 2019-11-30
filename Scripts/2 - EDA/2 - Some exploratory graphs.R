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


#Size doesn`t seem to matter that much`
ggplot(data = cities, aes(x = population, y = gdp_per_capita, color = n_copied_accounts)) + 
  geom_point() +
  scale_x_log10() +
  scale_y_log10() #+
#  scale_color_brewer(type = "seq", palette = 2)

#Only for copycats
ggplot(data = cities[is_copycat == 1], aes(x = population, y = gdp_per_capita, color = n_copied_accounts)) + 
  geom_point() +
  scale_x_log10() +
  scale_y_log10()



#Lets make some variables factors
cities$is_copycat %<>% factor()
levels(cities$is_copycat) <- c("Not Copycat", "Copycat")

cities$outsourced_accountant %<>% factor()
levels(cities$outsourced_accountant) <- c("Hired accountant", "Outsourced accountant")


#Change folder to save graph results
setwd(project_folder)

#is_copycat does not seem to depend on population, gdp_per_capita, urban hierarchy or outsourced accountant
ggplot(data = cities, aes(x = population, y = gdp_per_capita, color = is_copycat)) + 
  geom_point() +
  scale_x_log10() +
  scale_y_log10() +
  scale_color_manual(values = c("navy blue","red")) +
  facet_grid(urban_hierarchy~outsourced_accountant, labeller = label_wrap_gen(width = 0.5, multi_line = TRUE)) +
  theme_bw() +
  ggsave("./Copycat-Towns/Results/EDA_interactions_1.jpg")


#There seems to be no difference in the number of copied accounts for
#cities with hired or outsourced accountants.
#Region also doesnt seem to play a role, though there is slightly more copied accounts
#in the North region, as expected.
#Unlike expected, it happens with hired accountants!
#Yet, the gross cases of copying occure with outsourced accountants and in the NE.
ggplot(data = cities, aes(x = region, y = n_copied_accounts)) + 
  geom_boxplot() +
  scale_y_log10() +
  scale_color_manual(values = c("red","yellow","pink","green","orange")) +
  facet_grid(~outsourced_accountant, labeller = label_wrap_gen(width = 0.5, multi_line = TRUE)) +
  theme_bw() +
  ggsave("./Copycat-Towns/Results/EDA_interactions_2.jpg")



#Histogram of n_copied_acounts
ggplot(data = cities, aes(x = n_copied_accounts)) + 
  geom_histogram(binwidth = 1) +
  theme_bw() +
  ggsave("./Copycat-Towns/Results/Histogram_n_copied_accounts.jpg")


