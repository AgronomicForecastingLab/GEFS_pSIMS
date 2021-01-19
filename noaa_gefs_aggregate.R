library(stUPscales)

vars <- c("tmax", "tmin", "prcp", "tdew", "wind", "srad", "tavg")
funcs <- c("max", "min", "mean", "sum", "mean", "sum", "mean")

agg_site_data <- function(data) {
  for (x in seq_len(length(data))) {
    # Removes NA values from df
    temp <- na.omit(data[[x]])
    for (i in seq_len(length(vars))) {
      temp[, c("time", vars[i])] <- Agg.t(
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
