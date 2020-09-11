# TODO: unvoke a particular GAMS version instead of the on-path GAMS
# TODO: redirect stderr, stdout, output=<listing file>, gdx=<GDX file>

#' Run a GAMS script for testing.
#'
#' Runs a GAMS script and capture result files for testing.
#'
#' @param path path of GAMS script to run
#'
#' @return
#' @export
#'
#' @examples
run <- function(path) {
  # Check and sanitize parameters
  stopifnot(length(path) == 1)
  path <- fs::as_fs_path(path)
  stopifnot(fs::is_file(path))
  stopifnot(fs::path_ext(path) == "gms")

  # Extract the GAMS file name without extension from the path
  name <- fs::path_ext_remove(fs::path_file(path))
  print(name)

  # Create temp directory for redirection
  re_dir <- fs::file_temp("testGAMS")
  fs::dir_create(re_dir)

  # Invoke GAMS
  system2("gams", path)

  # Delete the temp redirection directory
  fs::dir_delete(re_dir)
}

