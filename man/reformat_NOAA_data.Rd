% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/reformat_NOAA.R
\name{reformat_NOAA_data}
\alias{reformat_NOAA_data}
\title{Reformat NOAA GEFS dataframe list}
\usage{
reformat_NOAA_data(data)
}
\arguments{
\item{data}{List of NOAA GEFS weather dataframes}
}
\value{
List of reformatted dataframes
}
\description{
Converts temp variables from K to C. Derives dew temp (tdew) from observed
temp and relative humidity. Derives avg temp (tavg) from max temp and
min temp. Removes unused variable columns.
}
