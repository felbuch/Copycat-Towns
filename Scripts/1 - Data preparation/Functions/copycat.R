copycat <- function(pairs_dt, order_dt = submissions){
  
  ### Given a datatable of pairs of copied accounts (pairs_dt)
  ### and a datatable on the order of submissions of reports to the government,
  ### this function determines, for each pair of copied accounts, who was the municipality
  ### which copied its peer.
  ### The premise here is that whoever send the report first is NOT the copycat,
  ### but rather the one being copied. Hence, the copycat must be whoever sent the report for last.
  
  
  pairs_dt <- as.vector(pairs_dt)
  city_1_id <- pairs_dt[1] #municipality_id
  city_2_id <- pairs_dt[2] #i.municipality_id
  
  #print(city_1_id)
  #print(city_2_id)
  ranks <- order_dt[(municipality_id == city_1_id) | (municipality_id == city_2_id), .(municipality_id, rank)]
  ranks <- unique(ranks)
  ranks <- ranks[order(-rank)]
  copycat_city = ranks[1,.(municipality_id)] %>% as.numeric
  
  
  return(copycat_city)
}
