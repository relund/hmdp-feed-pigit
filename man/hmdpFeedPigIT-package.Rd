% Generated by roxygen2 (4.1.0): do not edit by hand
% Please edit documentation in R/PigIT-package.R
\docType{package}
\name{hmdpFeedPigIT-package}
\alias{hmdpFeedPigIT}
\alias{hmdpFeedPigIT-package}
\title{Various models developed in the PigIT project}
\description{
This package include models and tools used during the PigIT project \url{www.pigit.net}.
}
\section{History}{

\itemize{
  \item
  \item 2014-03: Rewrote the code such the whole HMDP model (binary files) are built in C++ [Lars]. Removed previous
    files and functions (old folder). Two possible models added.
  \item 2014-02: Updated \link{WriteHMDPStates} so define a shared process and added functions for generating the HMDP [Lars].
  \item 2013-12: Added building of states using C++ and Rcpp see \link{WriteHMDPStates} [Lars].
}
}

\section{To do/questions}{


Use tags [Lars] and [Reza] when comment stuff.

I would start working on the 2 levels HMDP and finish it first. If something is similar for the 3-levels HMDP one may change it immidiately. Note c++ maps are used to find the id of a given state. Debug info can be written out to R using DBG functions (see debug.h). Some of the code may be wrong so look at it critically. Write down changes in the history above. This could also be questions we should look at when I get back.
\itemize{
  \item Debug the code. One could 1) calculate the trans pr of one state in R and see if it is the same in C++. 2) Write out info the a small model to see if okay.
  \item Check if transPr for the DGLM calculated okay
  \item In \code{BuildL1StageMid} need to modify \code{index.assign(1,mapR[iA][getLabel(t,n,iSW,0,iSSd)]);} so that link to average growth of that ration (link to iSG=0 now). The same problem exists in the 2 levels model. We have to have have a vector for each ration avgG[1:tMax] with average growth rates.
  \item Code functions \code{CalcWeightsTH, CalcWeightsChange, CalcWeightsTerm} and \code{CalcWeightsCont} in the models have not been coded (just use zero weights now). Rezas code may be used.
  \item Finish the documentation of function \code{iniDGLM} in file \code{setParam.R}.
  \item Implement filter functions for the DLM (we can use the dlm package) and DGLM (take Rezas code).
  \item Check function \code{\link{buildDLM}} if correct [Reza].
  \item Must have a constant sampleSizePigs = 35 (pigs measured using e.g. vision per day) used in the DGLM code instead of n. Must be defined in setParam function.
}
}
\author{
Lars Relund \email{lars@relund.dk} and Reza Pourmoayed \email{rpourmoayed@econ.au.dk}.
}

