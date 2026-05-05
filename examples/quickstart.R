# Minimal runnable example for pSIMSMetMaker.
#
# Prerequisites:
#   - pSIMSMetMaker installed (see README.md)
#   - A free Copernicus Climate Data Store (CDS) account with user ID + API key
#     https://cds.climate.copernicus.eu/
#
# Replace the placeholders below with your own credentials before running.

library(pSIMSMetMaker)
library(ecmwfr)

CDS_USER <- "<CDS_USER_ID>"
CDS_KEY  <- "<CDS_API_KEY>"

# One-time credential registration for the ecmwfr package.
wf_set_key(user = CDS_USER, key = CDS_KEY, service = "cds")

# Load bundled pSIMS tile extents and pick the first tile as a demo.
sites_path <- system.file("", "pSIMS_extent.RData", package = "pSIMSMetMaker")
load(sites_path)
site <- pSIMS.extent[1, ]

# 1. Download a year of ERA5 hourly data for the chosen tile.
era5_data <- era5_tile_request(
  user  = CDS_USER,
  sdate = "2020-01-01",
  edate = "2020-12-31",
  xmin  = site$xmin, xmax = site$xmax,
  ymin  = site$ymin, ymax = site$ymax,
  fname = "tile.nc"
)

# 2. Convert units / derive variables.
era5_refmt <- reformat_ERA_data(era5_data)

# 3. Aggregate hourly -> daily.
era5_daily <- ERA5_aggregate(era5_refmt)

# 4. Write a pSIMS-compatible NetCDF.
write_met(era5_daily[[1]], "clim_quickstart.tile.nc4")
