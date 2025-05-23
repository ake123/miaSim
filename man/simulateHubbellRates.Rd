% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/simulateHubbellRates.R
\docType{methods}
\name{simulateHubbellRates}
\alias{simulateHubbellRates}
\alias{simulateHubbellRates-numeric}
\alias{simulateHubbellRates,numeric-method}
\title{Hubbell's neutral model simulation applied to time series}
\usage{
simulateHubbellRates(
  n_species = NULL,
  x0 = NULL,
  names_species = NULL,
  migration_p = 0.01,
  metacommunity_probability = NULL,
  k_events = 1,
  growth_rates = NULL,
  error_variance = 0,
  norm = FALSE,
  t_end = 1000,
  ...
)
}
\arguments{
\item{n_species}{Integer: number of species}

\item{x0}{\code{Numeric scalar}. Indicates the initial species
composition. If \code{NULL}, \code{rep(100, n_species)} is used.}

\item{names_species}{Character: names of species. If NULL,
\code{paste0("sp", seq_len(n_species))} is used.
(default: \code{names_species = NULL})}

\item{migration_p}{Numeric: the probability/frequency of migration from a
metacommunity.
(default: \code{migration_p = 0.01})}

\item{metacommunity_probability}{Numeric: Normalized probability distribution
of the likelihood that species from the metacommunity can enter the community
during the simulation. If NULL, \code{rdirichlet(1, alpha = rep(1,n_species))} is
used.
(default: \code{metacommunity_probability = NULL})}

\item{k_events}{\code{Integer scalar}. Indicates the number of
events to simulate before updating the sampling distributions.
(Default: \code{1})}

\item{growth_rates}{\code{Numeric scalar}. Indicates the maximum
growth rates(mu) of species. If \code{NULL}, \code{rep(1, n_species)} is used.
(Default: \code{NULL})}

\item{error_variance}{Numeric: the variance of measurement error.
By default it equals to 0, indicating that the result won't contain any
measurement error. This value should be non-negative.
(default: \code{error_variance = 0})}

\item{norm}{Logical: whether the time series should be returned with
the abundances as proportions (\code{norm = TRUE}) or
the raw counts (default: \code{norm = FALSE})
(default: \code{norm = FALSE})}

\item{t_end}{Numeric: the end time of the simulationTimes, defining the
modeled time length of the community.
(default: \code{t_end = 1000})}

\item{...}{additional parameters, see \code{\link{utils}} to know more.}
}
\value{
\code{simulateHubbellRates} returns a TreeSummarizedExperiment class
object
}
\description{
Neutral species abundances simulation according to the Hubbell model. This
model shows that losses in society can be replaced either by the birth of
individuals or by immigration depending on their probabilities.
The specific time between the events of birth or migration is calculated and
time effect is considered to determine the next event.
}
\examples{
set.seed(42)
tse <- simulateHubbellRates(n_species = 5)

miaViz::plotSeries(tse, x = "time")

# no migration, all stochastic birth and death
set.seed(42)
tse1 <- simulateHubbellRates(n_species = 5, migration_p = 0)

# all migration, no stochastic birth and death
set.seed(42)
tse2 <- simulateHubbellRates(
    n_species = 5,
    migration_p = 1,
    metacommunity_probability = c(0.1, 0.15, 0.2, 0.25, 0.3),
    t_end = 20,
    t_store = 200
)

# all migration, no stochastic birth and death, but with measurement errors
set.seed(42)
tse3 <- simulateHubbellRates(
    n_species = 5,
    migration_p = 1,
    metacommunity_probability = c(0.1, 0.15, 0.2, 0.25, 0.3),
    t_end = 20,
    t_store = 200,
    error_variance = 100
)

# model with specified inputs
set.seed(42)
tse4 <- simulateHubbellRates(
    n_species = 5,
    migration_p = 0.1,
    metacommunity_probability = c(0.1, 0.15, 0.2, 0.25, 0.3),
    t_end = 200,
    t_store = 1000,
    k_events = 5,
    growth_rates = c(1.1, 1.05, 1, 0.95, 0.9)
)

}
\references{
Rosindell, James et al. "The unified neutral theory of
biodiversity and biogeography at age ten." Trends in ecology & evolution
vol. 26,7 (2011).
}
