tmax_data <- data[[1]][, c("time", “tmax”)]
tmin_data <- data[[1]][, c("time", “tmin”)]
tdew_data <- data[[1]][, c("time", "tdew")]
prcp_data <- data[[1]][, c("time", “prcp”)]
wind_data <- data[[1]][, c("time", “wind”)]
srad_data <- data[[1]][, c("time", “srad”)]
tavg_data <- data[[1]][, c("time", “tavg”)]

tmax_data <-
     Agg.t(
         data = tmax_data,
         nameData = "tmax",
         delta = 1440 , # A numeric value that specifies the level of aggregation required in minutes.
         func = max, # The name of the function of aggregation e.g. mean, sum.
         namePlot = "Temporal aggregation of temperature min tmin"
     )
tmin_data <-
    Agg.t(
         data = tmin_data,
         nameData = "tmin",
         delta = 1440 , # A numeric value that specifies the level of aggregation required in minutes.
         func = min, # The name of the function of aggregation e.g. mean, sum.
         namePlot = "Temporal aggregation of temperature min tmin"
     )

tdew_data <-
      Agg.t(
         data = tdew_data,
         nameData = "tdew",
         delta = 1440 , # A numeric value that specifies the level of aggregation required in minutes.
         func = mean, # The name of the function of aggregation e.g. mean, sum.
         namePlot = "Temporal aggregation of temperature min tmin"
     )

prcp_data <-
     Agg.t(
         data = prcp_data,
         nameData = "prcp",
         delta = 1440 , # A numeric value that specifies the level of aggregation required in minutes.
         func = sum, # The name of the function of aggregation e.g. mean, sum.
         namePlot = "Temporal aggregation of temperature min tmin"
     )

wind_data <-
     Agg.t(
         data = wind_data,
         nameData = "wind",
         delta = 1440 , # A numeric value that specifies the level of aggregation required in minutes.
         func = mean, # The name of the function of aggregation e.g. mean, sum.
         namePlot = "Temporal aggregation of temperature min tmin"
     )

srad_data <-
     Agg.t(
         data = srad_data,
         nameData = "srad",
         delta = 1440 , # A numeric value that specifies the level of aggregation required in minutes.
         func = sum, # The name of the function of aggregation e.g. mean, sum.
         namePlot = "Temporal aggregation of temperature min tmin"
     )

tavg_data <-
    Agg.t(
         data = tavg_data,
         nameData = "tavg",
         delta = 1440 , # A numeric value that specifies the level of aggregation required in minutes.
         func = mean, # The name of the function of aggregation e.g. mean, sum.
         namePlot = "Temporal aggregation of temperature min tmin"
