# This file was generated by Rcpp::compileAttributes
# Generator token: 10BE3573-1514-4C36-9D1C-5A225CD40393

#' Univariate cumulative normal (distribution function)
#' 
#' Based on the paper "Better approximations to cumulative normal functions" by 
#' G. West \url{http://www.wilmott.com/pdfs/090721_west.pdf}. The source code
#' has been taken from the authors webpage \url{http://finmod.co.za/research.html}.
#' 
#' @param x Value of quantiles.
#' @param mean The mean.
#' @param sd The standard deviation.
#' @return The distribution function.
#' @author Lars Relund \email{lars@@relund.dk}
#' @examples
#' # test against pnorm
#' times<-500
#' x<-runif(times,-10,10)
#' mean<-0
#' sd<-3
#' diff<-abs(pnorm(x,mean,sd)-pNorm1D(x,mean,sd))
#' if (all(diff<1e-15)) cat("No problems")
#' 
#' # compare performance
#' testpnorm<-function() {
#'    x<-runif(1,-10,10)
#'    mean<-runif(1,-10,10)
#'    sd<-runif(1,0,5)
#'    pnorm(x,mean,sd)
#' }
#' testpNorm1D<-function() {
#'    x<-runif(1,-10,10)
#'    mean<-runif(1,-10,10)
#'    sd<-runif(1,0,5)
#'    pNorm1D(x,mean,sd)
#' }
#' 
#' require(rbenchmark)
#' benchmark(testpnorm(), testpNorm1D(), order="relative", replications=100000)[,1:4]
#' @export
pNorm1D <- function(x, mean, sd) {
    .Call('hmdpFeedPigIT_pNorm1D', PACKAGE = 'hmdpFeedPigIT', x, mean, sd)
}

#' Bivariate cumulative normal (distribution function) using Armadillo
#' 
#' Based on the paper "Better approximations to cumulative normal functions" by 
#' G. West \url{http://www.wilmott.com/pdfs/090721_west.pdf}. The source code
#' has been taken from the authors webpage \url{http://finmod.co.za/research.html}.
#' 
#' Transform into a bivariate with sd = 1 using Y = 1/sqrt(diag(sigma))(X-mean), i.e.
#' Pr(X<=x) = P(Y<=1/sqrt(diag(sigma))(x-mean)).
#' 
#' @param lower The vector of lower limits (2-dim vector).
#' @param upper The vector of upper limits (2-dim vector).
#' @param mean The mean vector (2-dim vector).
#' @param sigma The covariance matrix (2x2). 
#' @return The distribution function.
#' @author Lars Relund \email{lars@@relund.dk}
#' @examples
#' # test against pmvnorm
#' times<-500
#' diff<-rep(NA,times)
#' diff_arma<-rep(NA,times)
#' for (i in 1:times) {
#'    sigma <- matrix(c(runif(1,1,10),1,1,runif(1,1,10)),nrow=2)
#'    sigma[1,2]<-sigma[2,1]<-sqrt(sigma[1,1]*sigma[2,2])*runif(1,-1,1)
#'    mean <- c(runif(1,1,10),runif(1,1,10))
#'    lower<-c(runif(1,-6,6),runif(1,-6,6))
#'    upper<-c(runif(1,lower[1],6),runif(1,lower[2],6))
#'    p1<-pmvnorm(lower=lower,upper=upper,mean=mean,sigma=sigma)
#'    p2<-pNorm2D(lower, upper, mean, sigma)
#'    p3<-pNorm2D_arma(lower, upper, mean, sigma)
#'    diff[i]<-abs(p1-p2)
#'    diff_arma[i]<-abs(p1-p3)
#' }
#' if (all(diff<1e-15)) cat("No problems with pNorm2D") else stop("Results for pNorm2D not the same!")
#' if (all(diff_arma<1e-15)) cat("No problems with pNorm2D_arma") else stop("Results for pNorm2D_arma not the same!")
#' 
#' # compare performance
#' testPmvnorm<-function() {
#'    sigma <- matrix(c(runif(1,1,10),1,1,runif(1,1,10)),nrow=2)
#'    sigma[1,2]<-sigma[2,1]<-sqrt(sigma[1,1]*sigma[2,2])*runif(1,-1,1)
#'    mean <- c(runif(1,1,10),runif(1,1,10))
#'    lower<-c(runif(1,-6,6),runif(1,-6,6))
#'    upper<-c(runif(1,lower[1],6),runif(1,lower[2],6))
#'    pmvnorm(lower=lower,upper=upper,mean=mean,sigma=sigma)
#' }
#' testpNorm2D<-function() {
#'    sigma <- matrix(c(runif(1,1,10),1,1,runif(1,1,10)),nrow=2)
#'    sigma[1,2]<-sigma[2,1]<-sqrt(sigma[1,1]*sigma[2,2])*runif(1,-1,1)
#'    mean <- c(runif(1,1,10),runif(1,1,10))
#'    lower<-c(runif(1,-6,6),runif(1,-6,6))
#'    upper<-c(runif(1,lower[1],6),runif(1,lower[2],6))
#'    pNorm2D_arma(lower, upper, mean, sigma)
#' }
#' testpNorm2D_arma<-function() {
#'    sigma <- matrix(c(runif(1,1,10),1,1,runif(1,1,10)),nrow=2)
#'    sigma[1,2]<-sigma[2,1]<-sqrt(sigma[1,1]*sigma[2,2])*runif(1,-1,1)
#'    mean <- c(runif(1,1,10),runif(1,1,10))
#'    lower<-c(runif(1,-6,6),runif(1,-6,6))
#'    upper<-c(runif(1,lower[1],6),runif(1,lower[2],6))
#'    pNorm2D_arma(lower, upper, mean, sigma)
#' }
#' 
#' require(rbenchmark) 
#' benchmark(testPmvnorm(), testpNorm2D(), testpNorm2D_arma, order="relative", replications=10000)[,1:4]
#' @export
pNorm2D_arma <- function(lower, upper, mean, sigma) {
    .Call('hmdpFeedPigIT_pNorm2D_arma', PACKAGE = 'hmdpFeedPigIT', lower, upper, mean, sigma)
}

#' Bivariate cumulative normal (distribution function)
#' 
#' Based on the paper "Better approximations to cumulative normal functions" by 
#' G. West \url{http://www.wilmott.com/pdfs/090721_west.pdf}. The source code
#' has been taken from the authors webpage \url{http://finmod.co.za/research.html}.
#' 
#' Transform into a bivariate with sd = 1 using Y = 1/sqrt(diag(sigma))(X-mean), i.e.
#' Pr(X<=x) = P(Y<=1/sqrt(diag(sigma))(x-mean)).
#' 
#' @param lower The vector of lower limits (2-dim vector).
#' @param upper The vector of upper limits (2-dim vector).
#' @param mean The mean vector (2-dim vector).
#' @param sigma The covariance matrix (2x2). 
#' @return The distribution function.
#' @author Lars Relund \email{lars@@relund.dk}
#' @examples
#' # test against pmvnorm
#' times<-500
#' diff<-rep(NA,times)
#' diff_arma<-rep(NA,times)
#' for (i in 1:times) {
#'    sigma <- matrix(c(runif(1,1,10),1,1,runif(1,1,10)),nrow=2)
#'    sigma[1,2]<-sigma[2,1]<-sqrt(sigma[1,1]*sigma[2,2])*runif(1,-1,1)
#'    mean <- c(runif(1,1,10),runif(1,1,10))
#'    lower<-c(runif(1,-6,6),runif(1,-6,6))
#'    upper<-c(runif(1,lower[1],6),runif(1,lower[2],6))
#'    p1<-pmvnorm(lower=lower,upper=upper,mean=mean,sigma=sigma)
#'    p2<-pNorm2D(lower, upper, mean, sigma)
#'    p3<-pNorm2D_arma(lower, upper, mean, sigma)
#'    diff[i]<-abs(p1-p2)
#'    diff_arma[i]<-abs(p1-p3)
#' }
#' if (all(diff<1e-15)) cat("No problems with pNorm2D") else stop("Results for pNorm2D not the same!")
#' if (all(diff_arma<1e-15)) cat("No problems with pNorm2D_arma") else stop("Results for pNorm2D_arma not the same!")
#' 
#' # compare performance
#' testPmvnorm<-function() {
#'    sigma <- matrix(c(runif(1,1,10),1,1,runif(1,1,10)),nrow=2)
#'    sigma[1,2]<-sigma[2,1]<-sqrt(sigma[1,1]*sigma[2,2])*runif(1,-1,1)
#'    mean <- c(runif(1,1,10),runif(1,1,10))
#'    lower<-c(runif(1,-6,6),runif(1,-6,6))
#'    upper<-c(runif(1,lower[1],6),runif(1,lower[2],6))
#'    pmvnorm(lower=lower,upper=upper,mean=mean,sigma=sigma)
#' }
#' testpNorm2D<-function() {
#'    sigma <- matrix(c(runif(1,1,10),1,1,runif(1,1,10)),nrow=2)
#'    sigma[1,2]<-sigma[2,1]<-sqrt(sigma[1,1]*sigma[2,2])*runif(1,-1,1)
#'    mean <- c(runif(1,1,10),runif(1,1,10))
#'    lower<-c(runif(1,-6,6),runif(1,-6,6))
#'    upper<-c(runif(1,lower[1],6),runif(1,lower[2],6))
#'    pNorm2D_arma(lower, upper, mean, sigma)
#' }
#' testpNorm2D_arma<-function() {
#'    sigma <- matrix(c(runif(1,1,10),1,1,runif(1,1,10)),nrow=2)
#'    sigma[1,2]<-sigma[2,1]<-sqrt(sigma[1,1]*sigma[2,2])*runif(1,-1,1)
#'    mean <- c(runif(1,1,10),runif(1,1,10))
#'    lower<-c(runif(1,-6,6),runif(1,-6,6))
#'    upper<-c(runif(1,lower[1],6),runif(1,lower[2],6))
#'    pNorm2D_arma(lower, upper, mean, sigma)
#' }
#' 
#' require(rbenchmark) 
#' benchmark(testPmvnorm(), testpNorm2D(), testpNorm2D_arma, order="relative", replications=10000)[,1:4]
#' @export
pNorm2D <- function(lower, upper, mean, sigma) {
    .Call('hmdpFeedPigIT_pNorm2D', PACKAGE = 'hmdpFeedPigIT', lower, upper, mean, sigma)
}

#' Build the HMDP (3 levels with shared linking) using the C++ binary writer. 
#' 
#' The MDP specified at level 3 is generated for each ration for a dummy state at the first stage at level 2. 
#' 
#' @param filePrefix Prefix used by the binary files storing the MDP model.
#' @param param Model parameters a list created using \code{\link{setParameters}}.
#' @param dlms A list a long as the number of rations where each entry is a DLM created using \code{\link{iniDLM}} and 
#'   \code{\link{buildDLM}}.
#' @param dglmParam Model parameters a list created using \code{\link{iniDGLM}}.
#'
#' @return Build log (character).
#' @author Lars Relund \email{lars@@relund.dk}
#' @export
BuildHMDP <- function(filePrefix, param, dlms, dglmParam) {
    .Call('hmdpFeedPigIT_BuildHMDP', PACKAGE = 'hmdpFeedPigIT', filePrefix, param, dlms, dglmParam)
}

