# GEFS_pSIMS (pSIMSMetMaker)

Build pSIMS-ready NetCDF weather inputs by combining NOAA GEFS forecasts and ERA5 reanalysis data.

## Languages and key dependencies

- Language: R (package `pSIMSMetMaker`, version 0.1.0)
- R dependencies (from `DESCRIPTION`): `ecmwfr`, `stars`, `units`, `dplyr`, `purrr`, `ncdf4`
- Additional packages used by the workflow / functions: `tidyverse`, `noaaGEFSpoint`, `job`

## Install

```r
# install.packages("remotes")
remotes::install_github("AgronomicForecastingLab/GEFS_pSIMS")
```

To install from a local clone:

```sh
git clone https://github.com/AgronomicForecastingLab/GEFS_pSIMS.git
```

```r
remotes::install_local("GEFS_pSIMS")
```

A free Copernicus Climate Data Store (CDS) account is required to download ERA5
data via the `ecmwfr` package. See https://github.com/bluegreen-labs/ecmwfr for
details on obtaining a user ID and API key.

## Quickstart

```r
library(pSIMSMetMaker)
library(ecmwfr)

# Register CDS credentials (one-time setup)
wf_set_key(user = "<CDS_USER_ID>", key = "<CDS_API_KEY>", service = "cds")

# Load bundled pSIMS tile extents
sites_path <- system.file("", "pSIMS_extent.RData", package = "pSIMSMetMaker")
load(sites_path)

site <- pSIMS.extent[1, ]

# 1. Request ERA5 data for one tile
era5_data <- era5_tile_request(
  user  = "<CDS_USER_ID>",
  sdate = "2020-01-01",
  edate = "2020-12-31",
  xmin = site$xmin, xmax = site$xmax,
  ymin = site$ymin, ymax = site$ymax,
  fname = "tile.nc"
)

# 2. Reformat (K -> C, wind speed from u/v, etc.)
era5_data_refmt <- reformat_ERA_data(era5_data)

# 3. Aggregate hourly -> daily
era5_data_agg <- ERA5_aggregate(era5_data_refmt)

# 4. Write a pSIMS-compatible NetCDF
write_met(era5_data_agg[[1]], "clim_tile.nc4")
```

A more complete script is in [`inst/workflow.R`](inst/workflow.R) and
[`examples/quickstart.R`](examples/quickstart.R).

## What's inside

- `R/era5_request.R` — download ERA5 hourly weather for a lon/lat site
- `R/era5_ncfile_request.R` — download ERA5 hourly NetCDFs for a list of sites
- `R/era5_tile_request.R` — request ERA5 data for a whole pSIMS tile (single year and multi-year variants)
- `R/reformat_ERA.R` — unit conversion and variable derivation for ERA5 data
- `R/ERA5_Aggregate.R` — aggregate hourly ERA5 to daily time step
- `R/noaa_gefs_request.R` — download NOAA GEFS forecast data for a list of sites
- `R/reformat_NOAA.R` — unit conversion and variable derivation for NOAA GEFS data
- `R/noaa_gefs_aggregate.R` — aggregate NOAA GEFS to 6-hour / daily time step
- `R/bind_NOAA_ERA.R` — merge NOAA GEFS and ERA5 site dataframes
- `R/write_met.R` — write a pSIMS-compatible NetCDF met file
- `inst/pSIMS_extent.RData` — pSIMS tile extents used by the workflow
- `inst/sites.csv` — example site list
- `inst/workflow.R` — end-to-end example script
- `man/` — generated roxygen documentation
- `examples/quickstart.R` — minimal runnable example

## Citation

No `CITATION.cff` or formal citation file is present in the repository.

## License

No `LICENSE` file is present in this repository, and the `License:` field in
`DESCRIPTION` is unset. Contact the maintainers (Agronomic Forecasting Lab)
before redistributing or reusing this code.
