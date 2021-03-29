#' Download NOAA GEFS data for a list of sites
#'
#' Requests max temp, min temp, dew temp, solar rad, wind speed,
#' and precipitation data for the lon/lat sites provided.
#'
#' @param sites A dataframe of sites (ID, lat, lon)
#' @return A list of site dataframes
#' @export
noaa_gefs_request <- function(sites) {
  data <- noaaGEFSpoint::noaa_gefs_download_downscale(
    site_list = sites$site_id,
    lat_list = sites$latitude,
    lon_list = sites$longitude,
    output_directory,
    forecast_time = "latest",
    forecast_date = Sys.Date() %>% as.character(),
    # latest = FALSE,
    var_names=c("tmax2m", "tmin2m", "dlwrfsfc",
                "dswrfsfc",'apcpsfc',"ugrd10m",
                "vgrd10m", "tmp2m", "rh2m"),
    downscale = FALSE,
    run_parallel = FALSE,
    num_cores = 4,
    overwrite = TRUE
  )
  return(data)
}