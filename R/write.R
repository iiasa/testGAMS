# Helper functions to write text files for testing purposes,

#' Write lines to a file
#'
#' Truncates or creates the file before writing.
#'
#' @param path  Path of the file to create.
#' @param lines Character vector of lines to write.
#' @export
write_lines <- function(path, lines) {
  conn <- file(path, open="wt")
  writeLines(lines, conn)
  close(conn)
}

#' Write lines to a file with deferred cleanup
#'
#' Truncates or creates the file before writing, and sets deferred deletion
#' of the file to occur when the specified environment is destroyed. By
#' default, the invoking environment is set.
#'
#' @param path  Path of the file to create.
#' @param lines Character vector of lines to write.
#' @param env   Environment to set `withr::defer()` cleanup on.
#' @export
write_lines_cleanup <- function(path, lines, env = parent.frame()) {
  conn <- file(path, open="wt")
  withr::defer(fs::file_delete(path), env = env)
  writeLines(lines, conn)
  close(conn)
}
