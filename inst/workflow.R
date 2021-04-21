library(pSIMSMetMaker)
sites.path <- system.file("", 'sites.csv', package = "pSIMSMetMaker")
sites <- read.csv(sites.path)
#------------------------------------------------- ERA - NEEDS LOGIN
#Login setup
#Create a free CDS user account by self registering.
#Once your user account has been verified you can get your personal user ID and key by visiting the user profile.
#This information is required to be able to retrieve data via the ecmwfr package
#https://github.com/bluegreen-labs/ecmwfr
user <- "10027"
wf_set_key(user = user, key = "e5d0082f-ae4d-44d6-a1e0-3b581282033f", 'cds')

debugonce(noaa_gefs_aggregate)
# Request ERA5 data
era5_data <- era5_ncfile_request(user, "2019-12-01", "2019-12-02", sites[1,])
# Reformat ERA5 data
era5_data_refmt <- reformat_ERA_data(era5_data)
#This dunction works for both NOAA and ERA5 given that both are reformted to the same format
era5_data_Agg <-noaa_gefs_aggregate(era5_data_refmt)

#--------------------------------------------------- NOAA gets
# Request NOAA GEFS data
gefs_data <- noaa_gefs_request(sites[1:4,])
# Reformat NOAA GEFS data
gefs_data_refmt <- reformat_NOAA_data(gefs_data)
# Aggregate NOAA GEFS data
gefs_data_agg <- noaa_gefs_aggregate(gefs_data_refmt)

# Bind ERA5 and NOAA data together
noaa_era_bind <- bind_NOAA_ERA(gefs_data_agg, era5_data_Agg)
