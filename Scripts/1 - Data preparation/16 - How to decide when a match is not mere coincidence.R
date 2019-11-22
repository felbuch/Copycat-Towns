rm(list = ls());gc()

#Set main working directory
project_folder <- "C:/Users/Felipe/Desktop/Duke MIDS/Modelling and Representation of Data/0 - Final Project/"
setwd(project_folder)

#Load packages
library(magrittr)
library(dplyr)
library(data.table)
library(dlookr)
library(ggplot2)

setwd(project_folder)
source("Copycat-Towns/Scripts/1 - Data preparation/10 - Reads financial accounts.R")
setwd(project_folder)
source("Copycat-Towns/Scripts/1 - Data preparation/15 - Finds pairs of similar accounts.R")
setwd(project_folder)
source("Copycat-Towns/Scripts/1 - Data preparation/Functions/n_digits.R")


ddist <- function(dt){
  
  dt <- as.data.table(dt)
  dt <- dt[,.(amount)][, ndigits := n_digits(amount)]
  dt <- dt[,.N, ndigits][order(ndigits)]
  return(dt)
}


ddist_fin <- ddist(fin)
ddist_sim <- ddist(pairs_of_similar_accounts)

ddist <- full_join(ddist_fin, ddist_sim, by = "ndigits", suffix = c("_fin","_sim"))
ddist <- as.data.table(ddist)
ddist[is.na(ddist)] <- 0

#N_sim~ Bin(N_fin, prob)
#Expected_N_sim = N_fin * prob * 2. 
#The doubling here reflects the fact that each pair will appear twice
ddist[, prob := 1/(9 * 10^(ndigits-1))]
ddist[, Expected_N_sim := N_fin * prob * 2]
ddist[, Observed_over_Expected := N_sim / Expected_N_sim]
ddist[, sd := sqrt(prob * (1-prob) * 2)] #standard deviation of Bernoulli random variable "Is an account similar to another one" of which the Binomial distribution is a sum

#Most accounts have 9 digits (7 + 2 cents)
plot(ddist$ndigits, ddist$N_fin)
#Bust most similar accounts have 5 digits (3 + 2 cents)
plot(ddist$ndigits, ddist$N_sim)
#Maybe because its more easy to match a small digit number by coincidence
#Here, the fraction of matching accounts per number of digits
plot(ddist$ndigits, ddist$N_sim / ddist$N_fin)

#Parameters for confidence intervals
alpha = 0.05
z = qnorm(alpha/2) %>% abs() #For unilateral CI

#Graph for visualization purposes
ggplot(data = ddist, aes(x = ndigits)) + 
  #Observed
  geom_line(aes(y = N_sim/N_fin), col = "red", lwd = 2) +
  #Expected
  geom_line(aes(y = prob), col = "blue", lwd = 2) +
  #Confidence interval error bars
  geom_linerange(aes(ymin = prob, ymax = prob + z * sd), col = "blue") +
  #Confidence interval upper line
  geom_line(aes(y = prob + z * sd), col = "blue") +
  geom_ribbon(aes(ymin = prob, ymax = prob + z * sd), fill = "light blue", alpha = 0.3) +
  scale_x_continuous(breaks = c(-2,-1, 1,2,3,4,5,6,7,8,9,10,11,12)) +
  xlab("Number of digits of the account \n (including 2 digits for cents)") +
  ylab("Proportion of similar \n accounts") +
  annotate("text", label = "Observed",col = "red", 4.5,.75) +
  annotate("text", label = "Expected \n due to mere chance",col = "blue", 4,.15) +
#  scale_y_log10() +
  theme_bw() +
  ggsave("./Copycat-Towns/Results/When_is_a_match_a_match.jpg")

