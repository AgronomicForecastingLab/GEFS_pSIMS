#' Binds NOAA GEFS and ERA5 weather data.
#'
#' Merges NOAA GEFS and ERA5 site weather data by sites.
#'
#' @param start Start date of dates requested
#' @return List of merged dataframes.
#' @export
bind_NOAA_ERA <- function(era_data, NOAA_data) {
  merged <- merge(era_data, NOAA_data)
  return(merged)
}
