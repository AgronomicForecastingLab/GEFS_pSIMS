#' Request ERA5 hourly weather data ncfiles for a whole tile
#'
#' @param user character, username
#' @param sdate Start date of hourly data
#' @param edate End date of hourly data
#' @param xmin xmin
#' @param xmax xmax
#' @param ymin ymin
#' @param ymax ymax
#' @param edate End date of hourly data
#' @return A list of site var data frames
#' @export
#'
era5_tile_request <- function(user, sdate, edate, xmin, xmax, ymin, ymax) {

    site_coord <- c(ymax,
                    xmin,
                    ymin,
                    xmax)
    dates <- seq(as.Date(sdate), as.Date(edate), by="days")

    req <- era5_request(site_coord, dates)

    ncfile <- wf_request(user = user,
                         request = req,
                         transfer = TRUE,
                         path = "~",
                         verbose = FALSE)
    df_list <- as.data.frame(stars::read_ncdf(ncfile))

    #When reading the ncdf file, there is usually an issue with time. We fix that here
    error_in_time <- as.POSIXct(sdate) - df_list$time[1]
    df_list$time <- df_list$time + error_in_time

  return(list(df_list))
}

