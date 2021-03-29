#' Aggregate NOAA GEFS to 6-hour step
#'
#' Aggregates NOAA GEFS weather variable data from a daily to 6-hour
#' time step.
#'
#' @param data List of site weather dataframes
#' @return Aggregated (6-hour) list of site weather dataframes
#' @export
noaa_gefs_aggregate <- function(data) {
  vars <- c("tmax", "tmin", "prcp", "tdew", "wind", "srad",  "tavg")
  funcs <- c("max", "min", "mean", "sum", "mean", "sum", "mean")
  for (x in seq_len(length(data))) {
    # Removes NA values from df
    temp <- na.omit(data[[x]])
    for (i in seq_len(length(vars))) {
      temp[, c("time", vars[i])] <- stUPscales::Agg.t(
        data = temp[, c("time", vars[i])],
        nameData = vars[i],
        delta = 1440,
        # A numeric value that specifies the level of aggregation required in minutes.
        func = funcs[i],
        # The name of the function of aggregation e.g. mean, sum.
        namePlot = "Temporal aggregation of variable."
      )
    }
    data[[x]] <- temp
  }
  return(data)
}

}
