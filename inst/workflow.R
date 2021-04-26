library(pSIMSMetMaker)
sites.path <- system.file("", 'pSIMS_extent.RData', package = "pSIMSMetMaker")
load(sites.path)
#------------------------------------------------- ERA - NEEDS LOGIN
#Login setup
#Create a free CDS user account by self registering.
#Once your user account has been verified you can get your personal user ID and key by visiting the user profile.
#This information is required to be able to retrieve data via the ecmwfr package
#https://github.com/bluegreen-labs/ecmwfr
user <- "10027"
wf_set_key(user = user, key = "e5d0082f-ae4d-44d6-a1e0-3b581282033f", 'cds')

debugonce(ERA5_aggregate)
# Request ERA5 data
era5_data <- era5_tile_request(user, "2020-01-01", "2020-12-31",
                               pSIMS.extent$xmin[1], pSIMS.extent$xmax[1],
                               pSIMS.extent$ymin[1], pSIMS.extent$ymax[1])
# Reformat ERA5 data
era5_data_refmt <- reformat_ERA_data(era5_data)
#Aggregate the ERA5 data
era5_data_Agg <- ERA5_aggregate(era5_data_refmt)


pSIMSMetMaker::write_met(era5_data_Agg[[1]], 'clim_0022_0029.tile.nc4')


#--------------------------------------------------- NOAA gets
# Request NOAA GEFS data
gefs_data <- noaa_gefs_request(sites[1:4,])
# Reformat NOAA GEFS data
gefs_data_refmt <- reformat_NOAA_data(gefs_data)
# Aggregate NOAA GEFS data
gefs_data_agg <- noaa_gefs_aggregate(gefs_data_refmt)

# Bind ERA5 and NOAA data together
noaa_era_bind <- bind_NOAA_ERA(gefs_data_agg, era5_data_Agg)
