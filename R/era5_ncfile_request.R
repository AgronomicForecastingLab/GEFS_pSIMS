#' Request ERA5 hourly weather data ncfiles
#'
#' @param user character, username
#' @param sdate Start date of hourly data
#' @param edate End date of hourly data
#' @param sites A dataframe of sites (ID, lat, lon)
#' @return A list of site var data frames
#' @export
era5_ncfile_request <- function(user, sdate, edate, sites) {
  df_list <- vector("list", nrow(sites))
  for (r in 1:nrow(sites)) {
    site_coord <- c(sites[r, 'Lat'],
                    sites[r, 'Lon']-0.01,
                    sites[r, 'Lat']-0.01,
                    sites[r, 'Lon'])
    dates <- seq(as.Date(sdate), as.Date(edate), by="days")
    req <- era5_request(site_coord, dates)
    ncfile <- wf_request(user = user,
                         request = req,
                         transfer = TRUE,
                         path = "~",
                         verbose = FALSE)
    df_list[[r]] <- as.data.frame(stars::read_ncdf(ncfile))

    #When reading the ncdf file, there is usually an issue with time. We fix that here
    error_in_time <- as.POSIXct(sdate) - df_list[[r]]$time[1]
    df_list[[r]]$time <- df_list[[r]]$time + error_in_time
  }
  return(df_list)
}

