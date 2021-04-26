#' Aggregate ERA5 to daily step
#'
#' Aggregates NOAA GEFS weather variable data from a 6-hour to daily
#' time step.
#'
#' @param data List of site weather dataframes
#' @param  ensemble_col column name with the ensembles
#' @return Aggregated (6-hour) list of site weather dataframes
#' @export
#'
ERA5_aggregate <- function(data) {
  vars <- c("tmax", "tmin", "prcp", "tdew", "wind", "srad",  "tavg")
  funcs <- c("max", "min", "mean", "mean", "mean", "sum", "mean")

  for (x in seq_len(length(data))) {
    # Removes NA values from df
    temp <- na.omit(data[[x]])

    ensembles <- unique(temp[["number"]])
    #for each ensmeble
    data[[x]] <- ensembles %>%
      map_dfr(function(ens){

        temp_ens <- temp %>%
          filter(number == ens) %>%
          mutate(Iden=paste0(latitude,"_",longitude)) %>%
          split(.$Iden) %>%
          map_dfr(function(Iden){

            Iden.split <- strsplit(Iden$Iden %>% unique(), "_")[[1]]

            purrr::map2_dfc(vars, funcs, function(var, func) {
              stUPscales::Agg.t(
                data = Iden[, c("time", var)],
                nameData = var,
                delta = 1440,
                # A numeric value that specifies the level of aggregation required in minutes.
                func = func,
                # The name of the function of aggregation e.g. mean, sum.
                namePlot = "Temporal aggregation of variable."
              ) %>%
                dplyr::select(var)
            }) %>%
              bind_cols(time = unique(as.Date(temp$time))) %>%
              mutate(
                number=ens,
                lat=Iden.split[1],
                lon=Iden.split[2]
              )
          })


      })


  }
  return(data)
}


