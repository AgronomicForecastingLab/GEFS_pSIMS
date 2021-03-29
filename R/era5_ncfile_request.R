#' Request ERA5 hourly weather data ncfiles
#'
#' @param sdate Start date of hourly data
#' @param edate End date of hourly data
#' @param sites A dataframe of sites (ID, lat, lon)
#' @return A list of site var data frames
#' @export
era5_ncfile_request <- function(sdate, edate, sites) {
  df_list <- vector("list", nrow(sites))
  for (r in 1:nrow(sites)) {
    site_coord <- c(sites[r, 'Lat'],
                    sites[r, 'Lon']-0.01,
                    sites[r, 'Lat']-0.01,
                    sites[r, 'Lon'])
    dates <- seq(as.Date(sdate), as.Date(edate), by="days")
    req <- era5_request(site_coord, dates)
    ncfile <- wf_request(user = "67047",
                         request = req,
                         transfer = TRUE,
                         path = "~",
                         verbose = FALSE)
    df_list[[r]] <- as.data.frame(read_ncdf(ncfile))
  }
  return(df_list)
}

