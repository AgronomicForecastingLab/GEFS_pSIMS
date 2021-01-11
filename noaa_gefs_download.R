data <- noaa_gefs_download_downscale(
  site_list = neon_sites$site_id,
  lat_list = neon_sites$latitude,
  lon_list = neon_sites$longitude,
  output_directory,
  forecast_time = "latest",
  forecast_date = Sys.Date() %>% as.character(),
  #  latest = FALSE,
  var_names=c("tmax2m", "tmin2m", "dlwrfsfc",
              "dswrfsfc",'apcpsfc',"ugrd10m",
              "vgrd10m"),
  downscale = FALSE,
  run_parallel = FALSE,
  num_cores = 4,
  overwrite = TRUE
)
