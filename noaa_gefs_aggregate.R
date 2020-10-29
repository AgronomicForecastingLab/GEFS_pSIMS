vars <- c("tmax", "tmin", "prcp", "tdew", "wind", "srad", "tavg")

funcs <- c("max", "min", "mean", "sum", "mean", "sum", "mean")

for (x in seq_len(length(data))) {
  for (i in seq_len(length(vars))) {
    data[[x]][, c("time", vars[i] )] <- Agg.t(
      data = data[[x]][, c("time", vars[i])],
      nameData = vars[i],
      delta = 1440,
      # A numeric value that specifies the level of aggregation required in minutes.
      func = funcs[i],
      # The name of the function of aggregation e.g. mean, sum.
      namePlot = "Temporal aggregation of variable."
    )
  }
}
