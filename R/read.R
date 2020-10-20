# Functions to read log and listing files for grepping

# Package-private test helper to write lines to a file for local use,
# truncating or creating it before writing, and setting deferred
# deletion of the file on destruction of the invoking environment.
local_write_lines <- function(path, lines, env = parent.frame()) {
  conn <- file(path, open="wt")
  withr::defer(fs::file_delete(path), env = env)
  writeLines(lines, conn)
  close(conn)
}

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
#' Reads the lines from a GAMS log file. Uses`LOG_FILE_NAME` by default,
#' which is where `run()` to redirects GAMS logging to. When using this
#' default, the `dir` argument should be set to the redirection directory
#' used for the `run()`.
#'
#' @param  dir  Directory containing log file.
#' @param  name Name of log file.
#' @return Character vector holding lines in the read log file.
#' @export
read_log <- function(dir, name=LOG_FILE_NAME) {
  read_lines(fs::path(dir, name))
}

#' Read lines from listing file
#'
#' Reads the lines from a GAMS listing file. Uses`LST_FILE_NAME` by default,
#' which is where `run()` redirects GAMS listing to. When using this
#' default, the `dir` argument should be set to the redirection directory
#' used for the `run()`.
#'
#' @param  dir  Directory containing log file.
#' @param  name Name of log file.
#' @return Character vector holding lines in the read listing file.
#' @export
read_lst <- function(dir, name=LST_FILE_NAME) {
  read_lines(fs::path(dir, name))
}
