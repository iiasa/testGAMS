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

#' Read lines from log file
#'
#' Reads the lines from the GAMS log output file written during
#' a  `run()`.
#'
#' @param  re_dir Redirection directory used for the `run()`.
#' @return Character vector holding lines in the read log file.
#' @export
read_log <- function(re_dir) {
  read_lines(fs::path(re_dir, LOG_FILE_NAME))
}

#' Read lines from listing file
#'
#' Reads the lines from the GAMS listing output file written during
#' a  `run()`.
#'
#' @param  re_dir Redirection directory used for the `run()`.
#' @return Character vector holding lines in the read listing file.
#' @export
read_lst <- function(re_dir) {
  read_lines(fs::path(re_dir, LST_FILE_NAME))
}
