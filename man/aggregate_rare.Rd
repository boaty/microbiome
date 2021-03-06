% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/aggregate_rare.R
\name{aggregate_rare}
\alias{aggregate_rare}
\title{Aggregate Rare Groups}
\usage{
aggregate_rare(x, level, detection, prevalence, include.lowest = FALSE, ...)
}
\arguments{
\item{x}{\code{\link{phyloseq-class}} object}

\item{level}{Summarization level (from \code{rank_names(pseq)})}

\item{detection}{Detection threshold for absence/presence
(strictly greater by default).}

\item{prevalence}{Prevalence threshold (in [0, 1]). The
required prevalence is strictly greater by default. To include the
limit, set include.lowest to TRUE.}

\item{include.lowest}{Include the lower boundary of the detection and
prevalence cutoffs. FALSE by default.}

\item{...}{Arguments to pass.}
}
\value{
\code{\link{phyloseq-class}} object
}
\description{
Combining rare taxa.
}
\examples{
data(dietswap)
s <- aggregate_rare(dietswap, level = 'Phylum',
    detection = 0.1/100, prevalence = 5/100)
}
\references{
See citation('microbiome')
}
\author{
Contact: Leo Lahti \email{microbiome-admin@googlegroups.com}
}
\keyword{utilities}
