% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/run.R
\name{run}
\alias{run}
\title{Run a GAMS script for testing}
\usage{
run(script, re_dir, params = NULL)
}
\arguments{
\item{script}{Path of GAMS script to run.}

\item{re_dir}{Redirection directory for holding GAMS output files.}

\item{params}{Character vector of GAMS parameters.}
}
\value{
GAMS status/error/return code.
}
\description{
Run a GAMS script and captures output files for testing. The logging output,
listing file, reference file, trace file, and a GDX dump of all symbols are
redirected to files located in \code{re_dir} with names \code{LOG_FILE_NAME},
\code{LST_FILE_NAME}, \code{REF_FILE_NAME}, \code{TRACE_FILE_NAME}, and \code{GDX_FILE_NAME}
respectively. The default compile-and-execute action is used.
}
\details{
Optionally, \href{https://www.gams.com/latest/docs/UG_GamsCall.html}{GAMS parameters} can be
provided. These add to or override the GAMS default parameters and the
parameters that \code{\link[=run]{run()}} sets for testing purposes. They can be specified in
"<keyword>=<value>" format.
}
