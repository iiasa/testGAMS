# Helper functions to write text files for testing purposes,

#' Write lines to a file
#'
#' Truncates or creates the file before writing.
#'
#' @param path  Path of the file to create.
#' @param ...   One or more character vectors of lines to write, NULLs are
#'   skipped.
#' @export
write_lines <- function(path, ...) {
  conn <- file(path, open="wt")
  for (l in list(...)) {
    if (!is.null(l)) writeLines(l, conn)
  }
  close(conn)
}

#' Write lines to a file with deferred cleanup
#'
#' Truncates or creates the file before writing, and sets deferred deletion of
#' the file to occur when the specified environment is destroyed. By default,
#' the invoking environment is set.
#'
#' @param path  Path of the file to create.
#' @param ...   One or more character vectors of lines to write, NULLs are
#'   skipped.
#' @param env   Environment to set [withr::defer()] cleanup on.
#' @export
write_lines_cleanup <- function(path, ..., env = parent.frame()) {
  conn <- file(path, open="wt")
  withr::defer(fs::file_delete(path), env = env)
  for (l in list(...)) {
    if (!is.null(l)) writeLines(l, conn)
  }
  close(conn)
}
