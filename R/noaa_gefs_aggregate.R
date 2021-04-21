#' Aggregate NOAA GEFS to 6-hour step
#'
#' Aggregates NOAA GEFS weather variable data from a 6-hour to daily
#' time step.
#'
#' @param data List of site weather dataframes
#' @return Aggregated (6-hour) list of site weather dataframes
#' @export
noaa_gefs_aggregate <- function(data) {
  vars <- c("tmax", "tmin", "prcp", "tdew", "wind", "srad",  "tavg")
  funcs <- c("max", "min", "mean", "mean", "mean", "sum", "mean")
  for (x in seq_len(length(data))) {
    # Removes NA values from df
    temp <- na.omit(data[[x]])

    data[[x]]<-purrr::map2_dfc(vars, funcs, function(var, func){

     stUPscales::Agg.t(
        data = temp[, c("time", var)],
        nameData = var,
        delta = 1440,
        # A numeric value that specifies the level of aggregation required in minutes.
        func = func,
        # The name of the function of aggregation e.g. mean, sum.
        namePlot = "Temporal aggregation of variable."
      ) %>%
        select(var)
    }) %>%
      bind_cols(time=unique(as.Date(temp$time)))

  }
  return(data)
}


