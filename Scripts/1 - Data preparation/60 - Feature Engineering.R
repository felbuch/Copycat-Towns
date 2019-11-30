#Set main working directory
project_folder <- "C:/Users/Felipe/Desktop/Duke MIDS/Modelling and Representation of Data/0 - Final Project/"
setwd(project_folder)
setwd("./Copycat-Towns/Datasets/2 - Intermediary data/")
load("./Cities_with_Covariates.RData")
setwd(project_folder)
setwd("./Copycat-Towns/Scripts/1 - Data preparation/Functions/")
source("email_from_gov.R")
source("clean_email.R")
cities %<>% as.data.table()

#Cities who do not have data on their accountants are uncompliant with the Health Ministry
#Missing data on accountants is MNAR, since it conveys information about negligence or 
#incapacity of the city to cope with the burocratic requirements of the Health Ministry.
#This carries information on how well organized a city is and this may arguably translate to
#the propensity of copying another city's acounts.
cities[, uncompliant_w_health_ministry := 0]
cities[is.na(accountant), uncompliant_w_health_ministry := 1]

#Are the accountants outsourced?
#One way to proxy if an accountant is NOT outsourced is by seeing whether its
#e-mail has a .gov domain. If it has, the accountant is not outsourced.
#The problem with this is that some municipalities do not have their own e-mail (sic).
#This is a topic for some other paper. But yes, in some cities, even the mayor's e-mail
#has an @gmail or @hotmail domain. In this cities, surely the accountant does not have a
#.gov domain even though he may not be outsourced. But that is the best proxy we have, for now,
#so let's at least be honest about it.
cities[, outsourced_accountant := as.numeric(!email_from_gov(accountant))]

#Get name of accountant
cities[, accountant := clean_email(accountant)]


#How many other cities does the accountant of each city take care of?
polygamy <- cities[!is.na(accountant),.(accountant)] %>% .[,.N, accountant]
names(polygamy) <- c("accountant","nb_cities_same_accountant")
cities <- left_join(cities, polygamy)

#Identify region of Brazil
N <- c("AM","AC","AP","RR","PA","RO","TO") 
NE <- c("MA","PI","CE","PE","RN","PB","SE","AL","BA")
CW <- c("MT","MS","GO")
SW <- c("RJ","SP","ES","MG")
S <- c("PR","RS","SC")

cities %<>% as.data.table 
cities[state %in% N, region := "N"]
cities[state %in% NE, region := "NE"]
cities[state %in% CW, region := "CW"]
cities[state %in% SW, region := "SW"]
cities[state %in% S, region := "S"]
cities$region %<>% factor(levels = c("N","NE","SW","S","CW")) 




#Save
setwd(project_folder)
setwd("./Copycat-Towns/Datasets/2 - Intermediary data/")
save(cities, file = "Cities_with_Covariates.RData")
