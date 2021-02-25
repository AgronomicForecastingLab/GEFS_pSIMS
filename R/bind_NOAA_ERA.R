#' Binds NOAA GEFS and ERA5 weather data.
#'
#' Merges NOAA GEFS and ERA5 site weather data by sites.
#'
#' @param start Start date of dates requested
#' @return List of merged dataframes.
#' @export
bind_NOAA_ERA <- function(start) {
  # request/reformat NOAA data
  NOAA_data <- noaa_gefs_request()
  NOAA_data <- reformat_NOAA_data(NOAA_data)
  NOAA_data <- agg_site_data(NOAA_data)
  
  # request/reformat ERA data
  era_df_list <- era5_ncfile_req(start, Sys.Date(), sites[1:5, ])
  era_data <- reformat_ERA_data(era_df_list)
  # bind together NOAA & ERA
  merged <- merge(era_data, NOAA_data)
  return(merged)
}
