request <- list(
  product_type = "reanalysis",
  format = "netcdf",
  variable = c("10m_u_component_of_wind", "10m_v_component_of_wind", 
               "2m_dewpoint_temperature", "2m_temperature",
               "maximum_2m_temperature_since_previous_post_processing", 
               "minimum_2m_temperature_since_previous_post_processing", 
               "surface_solar_radiation_downwards", "total_precipitation"),
  year = "2020",
  month = "11",
  day = "01",
  time = c("00:00", "01:00", "02:00", "03:00", "04:00", "05:00", "06:00"
           , "07:00", "08:00", "09:00", "10:00", "11:00", "12:00", "13:00"
           , "14:00", "15:00", "16:00", "17:00", "18:00", "19:00", "20:00"
           , "21:00", "22:00", "23:00"),
  dataset_short_name = "reanalysis-era5-single-levels",
  target = "download.nc"
)

ncfile <- wf_request(user = "-----",
                     request = request,   
                     transfer = TRUE,  
                     path = "~",
                     verbose = FALSE)
