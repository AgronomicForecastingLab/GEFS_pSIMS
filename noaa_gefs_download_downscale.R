library(tidyverse)
library(noaaGEFSpoint)
setwd("~/Scripts/GEFPoints")
output_directory <- "Data"
site_file <- system.file("extdata", "noaa_download_site_list.csv", package = "noaaGEFSpoint")
neon_sites <- read_csv(site_file)[1:2,]
#debugonce(download_downscale_site)
data <- noaa_gefs_download_downscale(
  site_list = neon_sites$site_id,
  lat_list = neon_sites$latitude,
  lon_list = neon_sites$longitude,
  output_directory,
  forecast_time = "latest",
  forecast_date = Sys.Date() %>% as.character(),
  #  latest = FALSE,
  var_names=c("tmax2m", "tmin2m", "dlwrfsfc",
              "dswrfsfc",'apcpsfc',"ugrd10m",
              "vgrd10m"),
  downscale = FALSE,
  run_parallel = FALSE,
  num_cores = 4,
  overwrite = TRUE
)
