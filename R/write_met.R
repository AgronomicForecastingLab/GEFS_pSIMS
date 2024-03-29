#' Write the ERA5 met file to necdf for pSIMS
#'
#' @param Metdata
#' @param filename
#'
#' @return
#' @export
#'
#' @examples
write_met<- function(Metdata, filename='test.nc4'){

  Metdata <- Metdata %>%
    mutate(lat=as.numeric(lat),
           lon=as.numeric(lon))


  #defining the dims--------------------------------------------------
  latv<- unique(Metdata$lat) %>% as.numeric() %>% sort(FALSE)
  lonv<- unique(Metdata$lon)  %>% as.numeric() %>% sort(FALSE)
  Metdata$time <- (as.Date(Metdata$time)-as.Date("1980-01-01") ) %>% as.numeric()
  tim <- unique(Metdata$time)
  Metdata$number <- (1-min(Metdata$number))+Metdata$number
  scen <- unique(Metdata$number)
  ## define lat, lon time dimensions
  latdim <- ncdf4::ncdim_def("lat", "degrees_east", vals =  latv, unlim = FALSE)
  londim <- ncdf4::ncdim_def("lon", "degrees_north", vals = lonv, unlim = FALSE)
  timedim <- ncdf4::ncdim_def("time", "days since 1980-01-01",  vals=tim, unlim = TRUE)
  scendim <- ncdf4::ncdim_def("scen", "",  vals=scen, unlim = TRUE)
  #Create variables -----------------------------------------------------
  vars <- c("tmax","tmin","prcp","tdew","wind","srad","tavg")
  units <- c("degc", "degc", "mm/day", "degc","m/s", "W/m2", "degc")



  #create the variables
  vars.list <- purrr::map2(vars, units, function(var, unit){
    ncvar_def(var, units = unit, dim = list(latdim, londim, timedim, scendim))
  })

  #add crop land
  cropv <- ncvar_def('cropland', units = 'percent', dim = list(latdim, londim, timedim, scendim))
  vars.list <- c(vars.list, list(cropv))

  ## create, write to, close nc file
  nc <- nc_create(filename =filename, vars = vars.list)

  print("Populating the ncdf ....")
  #populate the variables -------------------------------------------------
  walk2(vars, units, function(var, unit){
    print(var)


    tmp_d <- Metdata %>%
      dplyr::select((!!var), lat, lon, number, time)%>%
      split(.$number) %>%
      furrr::future_map(function(one.time){

        one.time %>%
          split(.$time) %>%
          purrr::map(~.x %>% `colnames<-`(c(var, "y","x","scen","time"))) %>%
          purrr::map(~ raster::rasterFromXYZ(.x %>% dplyr::select(x,y,z=var)) %>% raster::as.matrix(.) %>% rotate%>% rotate %>% mirror.matrix) %>%
          simplify2array()
      }, .progress = TRUE) %>%
      simplify2array()


    ncvar_put(nc = nc, varid = var, vals = tmp_d )
  })

  #crop land
  ncvar_put(nc = nc, varid = 'cropland', vals =  array(100, dim = c(length(lonv), length(latv), length(scen), length(tim))) )


  nc_sync(nc = nc)
  nc_close(nc = nc)

}



#' rotate matrix
#'
#' @param x matirx
#'
#' @return
#' @export
#'
#' @examples
rotate <- function(x) {
  t(apply(x, 2, rev))
}


#' mirror.matrix
#'
#' @param x
#'
#' @return
#' @export
#'
#' @examples
mirror.matrix <- function (x){
  xx <- as.data.frame(x)
  xx <- rev(xx)
  xx <- as.matrix(xx)
  xx
}


