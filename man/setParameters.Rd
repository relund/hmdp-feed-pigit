% Generated by roxygen2 (4.1.0): do not edit by hand
% Please edit documentation in R/setParam.R
\name{setParameters}
\alias{setParameters}
\title{Set the parameters used when build the HMDP model}
\usage{
setParameters(tMax = 12, tStartMarketing = 9, phases = 4, pigs = 15,
  rations = 4, iniFeedMix = 2, rationCost = c(1.8, 1.88, 1.96),
  minPhaseT = c(1, 4, 7, 10), thresholds = c(0, seq(94, 116, by = 3), 200),
  convRate = 0.84, convRateSd = 1.4, avgGRate = 6,
  priorGrowth = seq(5.5, by = 0.5, length = rations), avgLeanP = 61,
  CovWG = 8.66, avgInsWeight = 26, sDMeasure = 1, disWeight = c(5, 2),
  disSD = c(2, 1), disGrowth = c(5, 2), centerWeight = seq(26.4, 130, by =
  7), centerSD = seq(4, 11, by = 0.5), centerGrowth = priorGrowth,
  iniDist = c(26.49, 4.26), cullActions = TRUE, samples = 1000,
  check = TRUE)
}
\arguments{
\item{tMax}{Maximum growth period in weeks.}

\item{tStartMarketing}{Week where start to consider marketing.}

\item{phases}{Maximum number of phases (possible changes in the ration).}

\item{pigs}{Number of pigs in a pen at insertion.}

\item{rations}{Number of possible rations.}

\item{iniFeedMix}{The first feed mix for starting the system.}

\item{rationCost}{A vector with ration costs (per feed unit) of length rations.}

\item{minPhaseT}{A vector with minimum number of weeks used for each phase of feeding. (Used for three-level hmdp)}

\item{thresholds}{A vector of thresholds (in kg) used by the actions. The first threshold must be zero, i.e. the term. action. It must be increasing!}

\item{convRate}{Conversion rate between live weight and carcass weight}

\item{convRateSd}{Standard deviation of the conversion rate of the live weight and the carcass weight}

\item{avgGRate}{Average growth rate in the herd.}

\item{priorGrowth}{Prior growth rate for each feed mix.}

\item{avgLeanP}{Average leanness percent in the herd}

\item{CovWG}{Covariance between live weight and growth rate (we assume it is a constant value)}

\item{avgInsWeight}{Avarage weight of the pigs at the insertion time into the pen}

\item{sDMeasure}{Std. dev. on measurements (vision).}

\item{disWeight}{A vector with number of center points on each side of the center value and the length of each interval (weight)}

\item{disSD}{A vector with number of center points on each side of the center value and the length of each interval (standard deviation).}

\item{disGrowth}{A vector with number of center points on each side of the center value and the length of each interval (growth)}

\item{centerWeight}{A vector with center values (prior mean weight at time t) (one for each stage 1,...,tMax).}

\item{centerSD}{A vector with center values (prior sd at time t) (one for each stage 1,...,tMax).}

\item{centerGrowth}{A vector with center values (prior growth) (one for each feed mix).}

\item{cullActions}{True is use cull actions instead of threshold actions.}

\item{samples}{Number of samples to use in the simulation.}

\item{check}{Check model e.g. do trans pr sum to one}
}
\value{
A list containing all the parameters
}
\description{
Set the parameters used when build the HMDP model
}
\author{
Reza Pourmoayed \email{rpourmoayed@econ.au.dk} and Lars Relund \email{lars@relund.dk}
}

