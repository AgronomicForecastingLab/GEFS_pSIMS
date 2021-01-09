reformat_site_data <- function(data) {
  for (x in seq_len(length(data))) {
    data[[x]]$tmax <- drop_units(data[[x]]$mx2t) - 273.15
    data[[x]]$tmin <- drop_units(data[[x]]$mn2t) - 273.15
    data[[x]]$tdew <- drop_units(data[[x]]$d2m) - 273.15
    data[[x]]$tavg <- drop_units(data[[x]]$t2m)
    data[[x]]$prcp <- drop_units(data[[x]]$tp)
    data[[x]]$srad <- drop_units(data[[x]]$ssrd)
    data[[x]]$wind <- sqrt(drop_units(data[[x]]$u10)^2 + drop_units(data[[x]]$v10)^2)
  }
  return(data)
}

reformat_NOAA_data <- function(data) {
  for (x in seq_len(length(data))) {
    data[[x]]$tmax <- (data[[x]]$tmax2m - 273.15)
    data[[x]]$tmin <- (data[[x]]$tmin2m - 273.15)
    data[[x]]$tdew <- (data[[x]]$tmp2m - 273.15) - ((100 - data[[x]]$rh2m)/5.)
    data[[x]]$prcp <- (data[[x]]$apcpsfc)
    data[[x]]$wind <- sqrt((data[[x]]$ugrd10m)^2 + (data[[x]]$vgrd10m)^2)
    data[[x]]$srad <- (data[[x]]$dswrfsfc)
    data[[x]]$tavg <- ((data[[x]]$tmax + data[[x]]$tmin) / 2)
  }
  return(data)
}
