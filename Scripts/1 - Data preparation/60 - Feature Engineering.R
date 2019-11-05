head(cities)

setwd(project_folder)
setwd("./Copycat-Towns/Scripts/1 - Data preparation/Functions/")
source("email_from_gov.R")
source("get_name_from_email.R")


#Cities who do not have data on their accountants are uncompliant with the Health Ministry
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
cities[, accountant_name := get_name_from_email(accountant)]



