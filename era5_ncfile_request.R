req_func <- function(site_coord, dates) {
  request <- list(
    product_type = "reanalysis",
    format = "netcdf",
    area = site_coord,
    variable = c("10m_u_component_of_wind", "10m_v_component_of_wind", 
                 "2m_dewpoint_temperature", "2m_temperature",
                 "maximum_2m_temperature_since_previous_post_processing", 
                 "minimum_2m_temperature_since_previous_post_processing", 
                 "surface_solar_radiation_downwards", "total_precipitation"),
    year = unique(format(dates, format="%Y")),
    month = unique(format(dates, format="%m")),
    day = unique(format(dates, format="%d")), 
    time = c("00:00", "01:00", "02:00", "03:00", "04:00", "05:00", "06:00"
             , "07:00", "08:00", "09:00", "10:00", "11:00", "12:00", "13:00"
             , "14:00", "15:00", "16:00", "17:00", "18:00", "19:00", "20:00"
             , "21:00", "22:00", "23:00"),
    dataset_short_name = "reanalysis-era5-single-levels",
    target = "download.nc"
  )
  return(request)
}

era5_ncfile_req <- function(sdate, edate, sites) {
  df_list <- vector("list", nrow(sites))
  for (r in 1:nrow(sites)) {
    site_coord <- c(sites[r, 'Lat'], 
                    sites[r, 'Lon']-0.01,
                    sites[r, 'Lat']-0.01,
                    sites[r, 'Lon'])
    dates <- seq(as.Date(sdate), as.Date(edate), by="days")
    req <- req_func(site_coord, dates)
    ncfile <- wf_request(user = "67047",
                         request = req,   
                         transfer = TRUE,  
                         path = "~",
                         verbose = FALSE)
    df_list[[r]] <- as.data.frame(read_ncdf(ncfile))
  }
  return(df_list)
}
