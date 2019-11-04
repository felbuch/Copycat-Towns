rm(list = ls());gc()

devtools::install_github("briatte/ggnet")


################################
###       PARAMETERS        ###
################################
number_of_nodes_to_show <- 100
################################

#Set main working directory
project_folder <- "C:/Users/Felipe/Desktop/Duke MIDS/Modelling and Representation of Data/Copycat towns/"
setwd(project_folder)

#Load packages
library(magrittr)
library(dplyr)
library(data.table)
library(igraph)

load("./Datasets/2 - Intermediary data/Pairs of Similar Accounts.RData")

pairs_of_similar_accounts %<>%  as.data.table()

graph_df <- pairs_of_similar_accounts[,.N,by = c("municipality_id","i.municipality_id")]
graph_df <- graph_df[order(-N)][1:number_of_nodes_to_show]
names(graph_df) <- c("edge_1","edge_2","weight") #weight is number of similar accounts shared by municipalities
g <- graph_from_data_frame(graph_df, directed = FALSE)



plot(g, edge.color = "orange", vertex.label = NA, asp = 1, 
     xlim = c(-1,1), ylim = c(-1,1))


