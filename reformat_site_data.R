reformat_ERA_data <- function(data) {
  drops <- c("mx2t","mn2t", "d2m", "t2m", "tp", "ssrd", "u10", "v10")
  for (x in seq_len(length(data))) {
    data[[x]]$tmax <- drop_units(data[[x]]$mx2t) - 273.15
    data[[x]]$tmin <- drop_units(data[[x]]$mn2t) - 273.15
    data[[x]]$tdew <- drop_units(data[[x]]$d2m) - 273.15
    data[[x]]$tavg <- drop_units(data[[x]]$t2m)
    data[[x]]$prcp <- drop_units(data[[x]]$tp)
    data[[x]]$srad <- drop_units(data[[x]]$ssrd)
    data[[x]]$wind <- sqrt(drop_units(data[[x]]$u10)^2 + drop_units(data[[x]]$v10)^2)
  }
  data <- lapply(data, function(x) x[!(names(x) %in% drops)])
  return(data)
}

reformat_NOAA_data <- function(data) {
  drops <- c("tmax2m","tmin2m", "tmp2m", "rh2m", "apcpsfc", "wind_speed", 
             "dswrfsfc", "dlwrfsfc", "ensmbles")
  for (x in seq_len(length(data))) {
    data[[x]]$tmax <- (data[[x]]$tmax2m - 273.15)
    data[[x]]$tmin <- (data[[x]]$tmin2m - 273.15)
    data[[x]]$tdew <- (data[[x]]$tmp2m - 273.15) - ((100 - data[[x]]$rh2m)/5.)
    data[[x]]$prcp <- (data[[x]]$apcpsfc)
    data[[x]]$wind <- (data[[x]]$wind_speed)
    data[[x]]$srad <- (data[[x]]$dswrfsfc)
    data[[x]]$tavg <- ((data[[x]]$tmax + data[[x]]$tmin) / 2)
  }
  data <- lapply(data, function(x) x[!(names(x) %in% drops)])
  return(data)
}
