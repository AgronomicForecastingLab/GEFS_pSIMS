bind_NOAA_ERA <- function(start) {
  # request/reformat NOAA data
  NOAA_data <- noaa_gefs_request()
  NOAA_data <- reformat_NOAA_data(NOAA_data)
  NOAA_data <- agg_site_data(NOAA_data)
  
  # request/reformat ERA data
  era_df_list <- era_ncfile_req(start, system.date)
  era_data <- reformat_ERA_data(era_df_list)
  # bind together NOAA & ERA
  merged <- merge(era_data, NOAA_data)
}
