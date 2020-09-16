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
run <- function(script) {
  # Check and sanitize parameters
  stopifnot(length(script) == 1)
  path <- fs::as_fs_path(script)
  stopifnot(fs::is_file(script))
  stopifnot(fs::path_ext(script) == "gms")

  # Extract the GAMS file name without extension from the path
  name <- fs::path_ext_remove(fs::path_file(script))

  # Create temp directory for redirection
  re_dir <- fs::file_temp("testGAMS")
  fs::dir_create(re_dir)

  # Get path to GAMS binary (no exe extension needed)
  gams <- fs::path(get_sys_dir(), "gams")

  # Construct command line arguments for GAMS
  arg_templates = c(
    '"{script}"'
  )
  args <- purrr::map_chr(arg_templates, stringr::str_glue, .envir=environment())

  # Invoke GAMS
  system2(gams, args)

  # Delete the temp redirection directory
  fs::dir_delete(re_dir)
}

