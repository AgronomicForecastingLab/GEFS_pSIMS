#' Reformat NOAA GEFS dataframe list
#'
#' Converts temp variables from K to C. Derives dew temp (tdew) from observed
#' temp and relative humidity. Derives avg temp (tavg) from max temp and
#' min temp. Removes unused variable columns.
#'
#' @param data List of NOAA GEFS weather dataframes
#' @return List of reformatted dataframes
#' @export
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
