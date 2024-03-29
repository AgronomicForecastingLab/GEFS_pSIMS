% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/era5_ncfile_request.R
\name{era5_ncfile_request}
\alias{era5_ncfile_request}
\title{Request ERA5 hourly weather data ncfiles}
\usage{
era5_ncfile_request(user, sdate, edate, sites)
}
\arguments{
\item{user}{character, username}

\item{sdate}{Start date of hourly data}

\item{edate}{End date of hourly data}

\item{sites}{A dataframe of sites (ID, lat, lon)}
}
\value{
A list of site var data frames
}
\description{
Request ERA5 hourly weather data ncfiles
}
