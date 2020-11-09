# Functions to read log and listing files for grepping

#' Read line from a text file
#'
#' @param  path  Path to text file.
#' @return Character vector holding lines in the read text file.
#' @export
read_lines <- function(path) {
  conn <- file(path, open="rt")
  lines <- readLines(conn)
  close(conn)
  lines
}

#' Read lines from parameter file
#'
#' Reads the lines of the GAMS parameter file used for a [run()].
#'
#' @param  re_dir Redirection directory used for the [run()].
#' @return Character vector holding lines in the read parameter file.
#' @export
read_par <- function(re_dir) {
  read_lines(fs::path(re_dir, PAR_FILE_NAME))
}

#' Read lines from log file
#'
#' Reads the lines of the GAMS log output file written during a [run()].
#'
#' @param  re_dir Redirection directory used for the [run()].
#' @return Character vector holding lines in the read log file.
#' @export
read_log <- function(re_dir) {
  read_lines(fs::path(re_dir, LOG_FILE_NAME))
}

#' Read lines from listing file
#'
#' Reads the lines of the GAMS listing output file written during a [run()].
#'
#' @param  re_dir Redirection directory used for the [run()].
#' @return Character vector holding lines in the read listing file.
#' @export
read_lst <- function(re_dir) {
  read_lines(fs::path(re_dir, LST_FILE_NAME))
}

#' Read lines from reference file
#'
#' Reads the lines of the GAMS reference output file written during a [run()].
#'
#' @param  re_dir Redirection directory used for the [run()].
#' @return Character vector holding lines in the read reference file.
#' @export
read_ref <- function(re_dir) {
  read_lines(fs::path(re_dir, REF_FILE_NAME))
}

#' Read lines from trace file
#'
#' Reads the lines of the GAMS trace file written during a [run()].
#'
#' @param  re_dir Redirection directory used for the [run()].
#' @return Character vector holding lines in the read trace file.
#' @export
read_trace <- function(re_dir) {
  read_lines(fs::path(re_dir, TRACE_FILE_NAME))
}

#' Read lines from trace log file
#'
#' Reads the lines of the GAMS trace file written during [report_trace()].
#' Examine at the trace log file when [report_trace()] returns an error code.
#'
#' @param  re_dir Redirection directory used for the [run()].
#' @return Character vector holding lines in the read trace log file.
#' @export
read_trace_log <- function(re_dir) {
  read_lines(fs::path(re_dir, TRACE_LOG_FILE_NAME))
}


#' Read lines from trace report file
#'
#' Reads the lines of the GAMS trace report file written during [report_trace()].
#'
#' @param  re_dir Redirection directory used for the [run()].
#' @return Character vector holding lines in the read trace report file.
#' @export
read_trace_report <- function(re_dir) {
  read_lines(fs::path(re_dir, TRACE_REPORT_FILE_NAME))
}

#' Read lines from trace summary file
#'
#' Reads the lines of the GAMS trace summary file written during [report_trace()].
#'
#' @param  re_dir Redirection directory used for the [run()].
#' @return Character vector holding lines in the read trace summary file.
#' @export
read_trace_summary <- function(re_dir) {
  read_lines(fs::path(re_dir, TRACE_SUMMARY_FILE_NAME))
}
