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
era5_tile_request <- function(user, sdate, edate, xmin, xmax, ymin, ymax, pathi="~", fname="download.nc") {

    site_coord <- c(ymax,
                    xmin,
                    ymin,
                    xmax)
    dates <- seq(as.Date(sdate), as.Date(edate), by="days")

    req <- era5_request(site_coord, dates, fname)

    ncfile <- wf_request(user = user,
                         request = req,
                         transfer = TRUE,
                         path = pathi,
                         verbose = FALSE)
    df_list <- as.data.frame(stars::read_ncdf(ncfile))

    #When reading the ncdf file, there is usually an issue with time. We fix that here
    error_in_time <- as.POSIXct(sdate) - df_list$time[1]
    df_list$time <- df_list$time + error_in_time

  return(list(df_list))
}


#' Reads ERA5 nc files that was already on the local disk
#'
#' @param ncfile ncfile
#' @param sdate Start date of hourly data
#' @return A list of site var data frames
#' @export
#'
era5_tile_read <- function(ncfile="~/download.nc", sdate) {

  df_list <- as.data.frame(stars::read_ncdf(ncfile))

  #When reading the ncdf file, there is usually an issue with time. We fix that here
  error_in_time <- as.POSIXct(sdate) - df_list$time[1]
  df_list$time <- df_list$time + error_in_time

  return(list(df_list))
}


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
era5_tile_request_multiYear <- function(user,key, sdate, edate, xmin, xmax, ymin, ymax, year_per_req=2, pathi="~", fname="download") {


  print(pathi)

  site_coord <- c(ymax,
                  xmin,
                  ymin,
                  xmax)

  sdate <- as.Date(sdate)
  edate <- as.Date(edate)

  sYear <- lubridate::year(sdate)
  eYear <- lubridate::year(edate)

  day_diff <- ( edate - sdate) %>% as.numeric()

  if(day_diff > 365){

    reqs <- cbind(seq(sYear, eYear, year_per_req),
                  lead(seq(sYear, eYear, year_per_req)-1)
    ) %>%
      as.data.frame() %>%
      filter(!is.na(V2)) %>%
      `colnames<-`(c("sYear", "eYear"))%>%
      as.list()

    print(reqs)

    all.d <-reqs%>%
      future_pmap(function(sYear, eYear){

        wf_set_key(user = user, key = key, 'cds')

        nsdate <- paste0(sYear,"-01-01")
        nedate <- paste0(eYear,"-12-31")

        dates <- seq(as.Date(nsdate), as.Date(nedate), by="days")
        #fname for each Year
        fname <- paste0(fname, "_", sYear, ".nc")

        req <- era5_request(site_coord, dates, fname)

        ncfile <- wf_request(user = user,
                             request = req,
                             transfer = TRUE,
                             path = pathi,
                             verbose = FALSE)
        #Readin the file
        df_list <- as.data.frame(stars::read_ncdf(ncfile))

        #When reading the ncdf file, there is usually an issue with time. We fix that here
        error_in_time <- as.POSIXct(nsdate) - df_list$time[1]
        df_list$time <- df_list$time + error_in_time

        return(df_list)
      })
  }



  return(all.d)
}



