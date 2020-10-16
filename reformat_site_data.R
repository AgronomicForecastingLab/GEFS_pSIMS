reformat_site_data <- function(data){
  for (x in seq_len(length(data))) {
    data[[x]]$tmax <- (data[[x]]$tmax2m - 273.15)
    data[[x]]$tmin <- (data[[x]]$tmin2m - 273.15)
    data[[x]]$tdew <- (data[[x]]$tmp2m - 273.15) - ((100 - data[[x]]$rh2m)/5.)
    data[[x]]$prcp <- (data[[x]]$apcpsfc)
    data[[x]]$wind <- (data[[x]]$wind_speed)
    data[[x]]$srad <- (data[[x]]$dswrfsfc)
    data[[x]]$tavg <- ((data[[x]]$tmax + data[[x]]$tmin) / 2)
  }
  return(data)
}
