% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/align_move.R
\name{align_move}
\alias{align_move}
\title{Align movement data}
\usage{
align_move(
  m,
  res = "min",
  digit = "min",
  unit = "secs",
  spaceMethod = "greatcircle"
)
}
\arguments{
\item{m}{\code{move} or \code{moveStack}, which is allowed to contain irregular timestamps and diverging temporal resolutions to be aligned (see \code{\link{df2move}} to convert a \code{data.frame} to a \code{move} object).}

\item{res}{either numeric, representing the temporal resolution, to which \code{m} should be aligned to (see argument \code{unit}), or character:
\itemize{
  \item \code{"min"} to use the smalles temporal resolution of \code{m} (default)
  \item \code{"max"} to use the largest temporal resolution of \code{m}
  \item \code{"mean"} to use the rounded average temporal resolution of \code{m}
}}

\item{digit}{either numeric, indicating to which digits of a specifc unit (see argument \code{unit}) the time scale of \code{m} should be aligned (e.g. 0 to align the time scale to second ":00", if \code{unit} is set to \code{secs}), or character:
\itemize{
  \item \code{"min"} to use the smallest digit of the defined \code{unit} (default)
  \item \code{"max"} to use the largest digit of the defined \code{unit}
  \item \code{"mean"} to use the rounded average digit of the defined \code{unit}
}}

\item{unit}{character, either \code{"secs"}, \code{"mins"}, \code{"hours"}, \code{"days"}, indicating the temporal unit, to which \code{res} and \code{digit} are referring.}

\item{spaceMethod}{character, either \code{"euclidean"}, \code{"greatcircle"} or \code{"rhumbline"}, indicating the interpolation function to be used to interpolate locations of \code{m} to the aligned time scale. Interpolation is performed using \code{move::interpolateTime}.}
}
\value{
Aligned \code{move} or \code{moveStack}, ready to be used with \code{\link{frames_spatial}}-
}
\description{
This function aligns movement data to a uniform time scale with a uniform temporal resolution throughout the complete movement sequence. 
This prepares the provided movement data to be interpretable by \code{\link{frames_spatial}}, which necessitates a uniform time scale and
a consistent, unique temporal resolution for all moving individuals to turn recording times into frame times.
}
\examples{
library(moveVis)
library(move)
data("move_data")

# the tracks in move_data have irregular timestamps and sampling rates.
# print unique timestamps and timeLag
unique(timestamps(move_data))
unique(unlist(timeLag(move_data, units = "secs")))

# use align_move to correct move_data to a uniform time scale and lag using interpolation.
# resolution of 4 minutes (240 seconds) at digit 0 (:00 seconds) per timestamp:
m <- align_move(move_data, res = 240, digit = 0, unit = "secs")
unique(unlist(timeLag(m, units = "secs")))

# resolution of 1 hour (3600 seconds) at digit 0 (:00 seconds) per timestamp:
m <- align_move(move_data, res = 3600, digit = 0, unit = "secs")
unique(unlist(timeLag(m, units = "secs")))

# resolution of 1 hour (15 seconds) at digit 0 (:00 seconds) per timestamp:
m <- align_move(move_data, res = 15, digit = 0, unit = "secs")
unique(unlist(timeLag(m, units = "secs")))

# resolution of 1 hour:
m <- align_move(move_data, res = 60, unit = "mins")
unique(unlist(timeLag(m, units = "secs")))

}
\seealso{
\code{\link{df2move}} \code{\link{frames_spatial}} \code{\link{frames_graph}}
}
\author{
Jakob Schwalb-Willmann
}
