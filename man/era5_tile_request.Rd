% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/era5_tile_request.R
\name{era5_tile_request}
\alias{era5_tile_request}
\title{Request ERA5 hourly weather data ncfiles for a whole tile}
\usage{
era5_tile_request(
  user,
  sdate,
  edate,
  xmin,
  xmax,
  ymin,
  ymax,
  pathi = "~",
  fname = "download.nc"
)
}
\arguments{
\item{user}{character, username}

\item{sdate}{Start date of hourly data}

\item{edate}{End date of hourly data}

\item{xmin}{xmin}

\item{xmax}{xmax}

\item{ymin}{ymin}

\item{ymax}{ymax}
}
\value{
A list of site var data frames
}
\description{
Request ERA5 hourly weather data ncfiles for a whole tile
}
