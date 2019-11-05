#Set main working directory
project_folder <- "C:/Users/Felipe/Desktop/Duke MIDS/Modelling and Representation of Data/0 - Final Project/"
setwd(project_folder)

#Load economic data
setwd("../0 - Final Project/Out-of-git/1 - Raw data/")
econ = readxl::read_xlsx("./Brazil Municipalities GDP.xlsx") %>% as.data.table

#Filter latest year (2016)
econ <- econ[Ano == max(unique(econ$Ano))]

#Select columns of interest
econ %<>% .[,.(municipality_id = `Código do Município`,
              gdp = `Produto Interno Bruto, a preços correntes\r\n(R$ 1.000)`,
              gdp_per_capita = `Produto Interno Bruto per capita\r\n(R$ 1,00)`,
              urban_hierarchy = `Hierarquia Urbana (principais categorias)`
              )]

#Define variable types
econ$municipality_id %<>% as.numeric
econ$gdp %<>% as.numeric
econ$gdp_per_capita %<>% as.numeric
econ$urban_hierarchy %<>% as.factor

#Set order of levels for urban hierarchy
hierarchy_order <- c("Centro Local",
                     "Centro de Zona",
                     "Centro Subregional",
                     "Centro Regional",
                     "Metrópole")

levels(econ$urban_hierarchy) <- hierarchy_order

levels(econ$urban_hierarchy) <- c("Local Center",
                                  "Zone Center",
                                  "Subregional Center",
                                  "Regional Center",
                                  "Metropolis")

#Merge with cities dataset
cities <- dplyr::inner_join(cities, econ, by = "municipality_id")
cities %<>% as.data.table()

stopifnot(cities[gdp == max(cities$gdp), .(municipality_id)] == 3550308) #Checkpoint. The greatest gdp is Sao Paulo

