% Generated by roxygen2 (4.1.0): do not edit by hand
% Please edit documentation in R/simulation.R
\name{cutOff}
\alias{cutOff}
\title{Remove rows where re-simulation is needed.}
\usage{
cutOff(pen, feedMix, m0, C0, var0, phase, startFeed, startT, PigsCull)
}
\arguments{
\item{feedMix}{The feed-mix that is used in week "startT"}

\item{phase}{Number of phase feeding in the system}

\item{startFeed}{The time that the last feedMix has been started}

\item{dat}{List with 2 data tables (see createSampleData) where the weekly data table
contains optimal actions (columns threshold and feedMix).}
}
\value{
A reduced data table.
}
\description{
Remove rows where re-simulation is needed.
}

