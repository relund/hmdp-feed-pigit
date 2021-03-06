% Generated by roxygen2 (4.1.0): do not edit by hand
% Please edit documentation in R/simulation.R
\name{estimatePosterior}
\alias{estimatePosterior}
\title{Add estimated posterior values to observed values of the GSSM and nGSSM.}
\usage{
estimatePosterior(dat, m0, C0, var0, startT)
}
\arguments{
\item{dat}{Data table with observed values (columns aveOLW, sdOLW and aveFI).}

\item{m0}{Initial mean in DLM. This value is equal to filtered mean at time "startT-1"}

\item{C0}{Initial variance in DLM. This value is equal to filtered variance at time "startT-1"}

\item{var0}{Initial variance in DGLM. This value is equal to the varince at time "startT-1" resulted from DGLM.}

\item{startT}{Starting time of using the DLM and the DGLM (starting time after having a new decision)}
}
\value{
An extended data table with new columns eAveOLW, eSdOLW and eAve, and also the posterior variances to be used as the initial variances in the next run of SSMs
}
\description{
Add estimated posterior values to observed values of the GSSM and nGSSM.
}
\author{
Reza Pourmoayed \email{rpourmoayed@econ.au.dk}
}

