reformat_site_data <- function(data) {
  new_df <- data.frame()
  for (x in seq_len(length(data))) {
    new_df$tmax <- (data[[x]]$mx2t - 273.15K)
    new_df$tmin <- (data[[x]]$mn2t - 273.15)
    new_df$tdew <- (data[[x]]$d2m- 273.15)
    new_df$tavg <- (data[[x]]$t2m)
    new_df$prcp <- (data[[x]]$tp)
    new_df$srad <- (data[[x]]$ssrd)
    new_df$wind <- sqrt((data[[x]]$u10)^2 + (data[[x]]$v10)^2)
  }
  return(new_df)
}

reformat_site_data_list <- function(df_list) {
  new_df_list <- vector("list", length(df_list))
  for (x in seq_len(length(df_list))) {
    new_df_list[[x]] <- reformat_site_data(df_list[[x]])
  }
  return (new_df_list)
}
