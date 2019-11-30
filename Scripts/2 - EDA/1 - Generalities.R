source("./Copycat-Towns/Scripts/1 - Data preparation/Functions/as_percentage.R")

#We now produce a dataset of municipalities with the number of accounts
cities <- as.data.table(cities)
#First, very quick statistic:

#What percentage of the municipalities are copycats?
as.perc(cities[,mean(is_copycat)])

#How many accounts, on average, does a municipality have similar to other municipalities?
cities[ , mean(n_copied_accounts)] #If we consider all municipalities
cities[is_copycat == 1 , mean(n_copied_accounts)] #If we consider only municipalities which are copycats

#How much do the municipalities which most copy other municipalities?
cities[order(-n_copied_accounts)] %>% .[,.(municipality, n_copied_accounts)] %>% head

#Let's see what the data looks like without the top 3, which seem to be outliers
#We'll only consider cities which copy at least one account, so we're looking at "non-outlying" copycats
nboc <- cities[n_copied_accounts > 0][order(-n_copied_accounts)][,.(municipality, n_copied_accounts)][-c(1:3)]
nboc #Non blatently outlying copycats
nboc$n_copied_accounts %>% table
nboc$n_copied_accounts %>% hist

#hist(cities$n_copied_accounts, nclass = 100)

#São Paulo
cities[municipality_id == 3550308]


#Now lets look IF a city copies anything.
tt <- table(cities$is_copycat); tt/sum(tt); rm(tt)

