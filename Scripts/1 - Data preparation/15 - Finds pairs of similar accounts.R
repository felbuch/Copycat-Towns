#####################
#PREVIOUS SCRIPT: 10
#####################



pairs_of_similar_accounts <- fin[fin, on = .(account,amount), nomatch = 0]
pairs_of_similar_accounts %<>% .[municipality_id != i.municipality_id]

#Consider as matching only accounts which have at least "digits_to_match" digits
pairs_of_similar_accounts %<>% .[,ndigits := n_digits(amount)]
pairs_of_similar_accounts %<>% .[ndigits >= digits_to_match]
pairs_of_similar_accounts[,ndigits := NULL]


#Our key here is a pair of municipalities which share an account with similar value
stopifnot(is_unique_key(data_table = pairs_of_similar_accounts, key = c("municipality_id","i.municipality_id","account","amount")))

#We do not consider similar accounts which are both zero
stopifnot(nrow(pairs_of_similar_accounts[amount == 0]) == 0)

#A few remarks:
# 1 - Each pair of municipalities appear twice in the database, in reverse order. 
# Thus, one has A-B in one line and B-A in another line, representing a single fact: that A and B share a similar account.
# 2 - It follows that the number of similarities is actually half the number of rows in the similar accounts.
# 3 - It also follows that nrow(similar_accounts) should be an even number, so we check that:


stopifnot(nrow(pairs_of_similar_accounts) %% 2 == 0)

#4 - The unit of analysis here is a pair. However, we only have nrows(similar_accounts / 2) pairs with similar 
# out of a total of (Choose(nrow(fin18),2)) possibilities. This is really small. In fact, that is
(nrow(pairs_of_similar_accounts)/2) / choose(nrow(fin),2)

#Identify in the fin dataset which account either is a copy or was coppied.
#Note that each line in this dataframe is an account of a given municipality. 


##################
#NEXT SCRIPT: 20
##################
