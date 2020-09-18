# TODO: redirect stderr, stdout, output=<listing file>, gdx=<GDX file>

#' Run a GAMS script for testing.
#'
#' Runs a GAMS script and capture result files for testing.
#'
#' @param path path of GAMS script to run
#' @param path redirection directory for holding GAMS output files
#' @export
run <- function(script, re_dir) {
  # Check and sanitize parameters
  stopifnot(length(script) == 1)
  path <- fs::as_fs_path(script)
  stopifnot(fs::is_file(script))
  stopifnot(fs::path_ext(script) == "gms")
  re_dir <- fs::as_fs_path(re_dir)
  stopifnot(fs::dir_exists(re_dir))

  # Extract the GAMS file name without extension from the path
  name <- fs::path_ext_remove(fs::path_file(script))

  # Get path to GAMS binary (no exe extension needed)
  gams <- fs::path(get_sys_dir(), "gams")

  # Construct a parameter file for GAMS (more robust)
  parameter_templates = c(
    'output="{fs::path(re_dir, \'output.lst\')}"'
  )
  parameters <- purrr::map_chr(parameter_templates, stringr::str_glue, .envir=environment())
  parameter_file <- fs::path(re_dir, "parameters.txt")
  parameter_conn<-file(parameter_file, open="wt")
  writeLines(parameters, parameter_conn)
  close(parameter_conn)

  # Construct command line arguments for GAMS
  arg_templates = c(
    '"{script}"',
    '-parmFile "{parameter_file}"'
  )
  args <- purrr::map_chr(arg_templates, stringr::str_glue, .envir=environment())

  # Invoke GAMS
  system2(gams, args)
}

