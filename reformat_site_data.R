reformat_site_data <- function(data){
  for (x in seq_len(length(data))) {
    data[[x]]$tmax <- (data[[x]]$mx2t - 273.15)
    data[[x]]$tmin <- (data[[x]]$mn2t - 273.15)
    data[[x]]$tdew <- (data[[x]]$d2m- 273.15)
    data[[x]]$tavg <- (data[[x]]$t2m)
    data[[x]]$prcp <- (data[[x]]$tp)
    data[[x]]$srad <- (data[[x]]$ssrd)
    data[[x]]$wind <- sqrt((data[[x]]$u10)^2 + (data[[x]]$v10)^2)
  }
  return(data)
}
