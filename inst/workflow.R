# Package workflow demo:

# Request ERA5 data
era5_data <- era5_ncfile_req("2019-12-01", "2019-12-03", sites[1:4,])
# Reformat ERA5 data
era5_data_refmt <- reformat_ERA_data(era5_data)

# Request NOAA GEFS data
gefs_data <- noaa_gefs_request(sites[1:4,])
# Reformat NOAA GEFS data
gefs_data_refmt <- reformat_NOAA_data(gefs_data)
# Aggregate NOAA GEFS data
gefs_data_agg <- noaa_gefs_aggregate(gefs_data_refmt)

# Bind ERA5 and NOAA data together
noaa_era_bind <- bind_NOAA_ERA(gefs_data_agg, era5_data_refmt)
