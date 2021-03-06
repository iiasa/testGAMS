% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/run.R
\name{report_trace}
\alias{report_trace}
\title{Generate trace report and summary files from trace file}
\usage{
report_trace(re_dir, trace_level = 0)
}
\arguments{
\item{re_dir}{Redirection directory for holding GAMS output files.}

\item{trace_level}{Modelstat/Solvestat threshold for filtering GamsSolve
trace records.}
}
\value{
GAMS status/error/return code.
}
\description{
Have GAMS generate a trace report and summary given the trace file output by
\code{\link[=run]{run()}} in \code{re_dir}. The report and summary are also written to \code{re_dir} as
files with names\code{TRACE_REPORT_FILE_NAME} and \code{TRACE_SUMMARY_FILE_NAME}
respectively.
}
