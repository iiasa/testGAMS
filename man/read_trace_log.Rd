% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/read.R
\name{read_trace_log}
\alias{read_trace_log}
\title{Read lines from trace log file}
\usage{
read_trace_log(re_dir)
}
\arguments{
\item{re_dir}{Redirection directory used for the \code{\link[=run]{run()}}.}
}
\value{
Character vector holding lines in the read trace log file.
}
\description{
Reads the lines of the GAMS trace file written during \code{\link[=report_trace]{report_trace()}}.
Examine at the trace log file when \code{\link[=report_trace]{report_trace()}} returns an error code.
}
