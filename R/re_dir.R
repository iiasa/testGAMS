#' Create temporary redirection directory
#'
#' Create a temporary directory to where output files can be redirected for
#' examination and later cleanup. Once the output files have been written
#' to the redirection directory, apply any needed tests to them to examine
#' their content. Thereafter, cleanup can be performed by deleting the
#' directory and its content in one go, e.g. by using `fs::dir_delete()`.
#'
#' You may wish to defer the cleanup to a cleanup handler such as `on.exit()`
#' or `withr::defer()`. The `local_re_dir()` function does this for you.
#'
#' @return re_dir Newly created uniquely named temporary directory.
#' @export
#' @examples
#' re_dir <- create_re_dir()
#' # Do something with the re_dir directory
#' fs::dir_delete(re_dir)
create_re_dir <- function() {
  re_dir <- fs::file_temp("testGAMS")
  fs::dir_create(re_dir)
}

#' Create temporary redirection directory with local cleanup
#'
#' Create a temporary directory via `create_re_dir()` with a cleanup handler
#' attached to the calling environment. Cleanup deletes the directory and its
#' contents using `withr::defer()`.
#'
#' @param env \[`environment`: `parent.frame()`]\cr Attach cleanup handler to
#' this environment, defaults to the calling environment.
#' @return re_dir Newly created uniquely named temporary directory.
#' @export
local_re_dir <- function(env = parent.frame()) {
  re_dir <- create_re_dir()
  withr::defer(fs::dir_delete(re_dir), env = env)
  re_dir
}
