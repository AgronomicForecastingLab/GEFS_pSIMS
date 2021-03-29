#' Download ERA5 hourly weather data.
#'
#' Requests max temp, min temp, dew temp, solar rad, wind speed,
#' and precipitation data for the lon/lat sites provided.
#'
#' @param site_coord Site lon/lat vector (max lat, min lon, min lat, max lon)
#' @param dates Sequence of R "Date" class objects.
#' @return A dataframe of the requested site variables.
#' @export
era5_request <- function(site_coord, dates) {
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