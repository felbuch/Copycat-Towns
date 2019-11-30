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
library(dlookr)
library(ggplot2)

#Load data
load("./Copycat-Towns/Datasets/2 - Intermediary data/Cities_with_Covariates.RData")
cities %<>% as.data.table()
str(cities)


