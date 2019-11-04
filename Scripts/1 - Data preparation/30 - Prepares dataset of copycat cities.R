########################
## Runs after script 20
########################

# is_unique_key(fin, c("municipality_id","account")) #Checkpoint

#is_unique_key(data_table = pairs_of_similar_accounts, key = c("municipality_id","i.municipality_id","account","amount")) #Checkpoint

similar_accounts <- pairs_of_similar_accounts[,.(municipality_id, 
                                                 account,
                                                 amount,
                                                 copycat_id)] %>% unique

is_unique_key(data_table = similar_accounts, key = c("municipality_id","account","amount","copycat_id")) #Checkpoint

#Create identifier. Is this municipality the copycat of this account?
similar_accounts[, is_copycat := ifelse(municipality_id == copycat_id, 1, 0)]

#Filters only copied accounts
copied_accounts <- similar_accounts[is_copycat == 1]
copied_accounts[,copycat_id := NULL]

#Join info of copied accounts to dataset of all accounts
fin <- left_join(fin, copied_accounts) %>% as.data.table
fin[is.na(is_copycat), is_copycat := 0]

#is_unique_key(fin, c("municipality_id","account")) #Checkpoint

#The fin dataset is on the level of the account.
#Each row is an account from one municipality.
#The is_copycat column says if that account was copied from someone else.

#Now, we group these acounts on the level of the city.

cities <- fin[, .(municipality = unique(municipality),
                  state = unique(state),
                  population = unique(population),
                  n_copied_accounts = sum(is_copycat),
                  is_copycat = max(is_copycat)), by = municipality_id]

is_unique_key(cities, "municipality_id") #Checkpoint
length(unique(fin$municipality_id)) == nrow(cities) #Checkpoint
sum(cities$n_copied_accounts) == nrow(copied_accounts) #Checkpoint

#Save
setwd(project_folder)
setwd("./Copycat-Towns/Datasets/2 - Intermediary data")
save(cities, file = "Municipality_copycat_label.RData")

##################
#NEXT SCRIPT: 40
##################
