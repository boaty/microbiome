% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/potential_analysis.R
\name{potential_univariate}
\alias{potential_univariate}
\title{Potential Analysis for Univariate Data}
\usage{
potential_univariate(
  x,
  std = 1,
  bw = "nrd",
  weights = c(),
  grid.size = NULL,
  peak.threshold = 1,
  bw.adjust = 1,
  density.smoothing = 0,
  min.density = 1
)
}
\arguments{
\item{x}{Univariate data (vector) for which the potentials shall be estimated}

\item{std}{Standard deviation of the noise (defaults to 1; this will set
scaled potentials)}

\item{bw}{kernel bandwidth estimation method}

\item{weights}{optional weights in ksdensity
(used by potential_slidingaverages).}

\item{grid.size}{Grid size for potential estimation.
of density kernel height dnorm(0, sd=bandwidth)/N}

\item{peak.threshold}{Mode detection threshold}

\item{bw.adjust}{The real bandwidth will be bw.adjust*bw; defaults to 1}

\item{density.smoothing}{Add a small constant density across the
whole observation range to regularize density estimation (and to
avoid zero probabilities within the observation range). This
parameter adds uniform density across the observation range, scaled
by density.smoothing.}

\item{min.density}{minimum accepted density for a maximum; as a
multiple of kernel height}
}
\value{
\code{potential_univariate} returns a list with the
following elements:
\itemize{
\item{xi }{the grid of points on which the potential is estimated}
\item{pot }{The estimated potential: -log(f)*std^2/2,
where f is the density.}
\item{density }{Density estimate corresponding to the potential.}
\item{min.inds }{indices of the grid points at which the density has
minimum values; (-potentials; neglecting local optima)}
\item{max.inds }{indices the grid points at which the density has
maximum values; (-potentials; neglecting local optima)}
\item{bw }{bandwidth of kernel used}
\item{min.points }{grid point values at which the density has
minimum values; (-potentials; neglecting local optima)}
\item{max.points }{grid point values at which the density has
maximum values; (-potentials; neglecting local optima)}
}
}
\description{
One-dimensional potential estimation for univariate timeseries.
}
\examples{
# res <- potential_univariate(x)
}
\references{
\itemize{
\item{}{Livina et al. (2010).
 Potential analysis reveals changing number of climate states during
 the last 60 kyr. \emph{Climate of the Past}, 6, 77-82.}
\item{}{Lahti et al. (2014).
 Tipping elements of the human intestinal ecosystem.
 \emph{Nature Communications} 5:4344.}
}
}
\author{
Based on Matlab code from Egbert van Nes modified by Leo Lahti.
Extended from the initial version in the \pkg{earlywarnings} R package.
}
\keyword{early-warning}
