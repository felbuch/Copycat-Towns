#We now produce a dataset of municipalities with the number of accounts
cities <- as.data.table(cities)
#First, very quick statistic:
#What percentage of the total accounts are similar?
as.perc(fin[,mean(is_copycat)])

#What percentage of the municipalities have similar accounts to other municipalities?
as.perc(cities[,mean(is_copycat)])

#How many accounts, on average, does a municipality have similar to other municipalities?
cities[ , mean(n_copied_accounts)] #If we consider all municipalities
cities[is_copycat == 1 , mean(n_copied_accounts)] #If we consider only municipalities which are copycats

#How much do the municipalities which most copy other municipalities?
cities[order(-n_copied_accounts)] %>% .[,.(municipality, n_copied_accounts)] %>% head

#hist(cities$n_copied_accounts, nclass = 100)

#São Paulo
cities[municipality_id == 3550308]
