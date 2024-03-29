% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/reformat_ERA.R
\name{reformat_ERA_data}
\alias{reformat_ERA_data}
\title{Reformat ERA5 weather dataframe list}
\usage{
reformat_ERA_data(data)
}
\arguments{
\item{data}{List of ERA5 weather data dataframes}
}
\value{
A list of reformatted dataframes
}
\description{
Converts temp variables from K to C. Derives wind speed from wind u- and
v-components.
}
