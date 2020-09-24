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

  # Construct parameter file for GAMS (more robust than passing command line args)
  par_templates = c(
    'logOption=2', # Log to file
    'logFile="{fs::path(re_dir, \'output.log\')}"', # Path to log file
    'logLine=0', # Minimize compile progress logging
    'cErr=1', # Compile-time error limit: stop after 1 error
    'errorLog=1000', # Max number of lines for each error that will be written to log file, 0 = none
    'errMsg=1', # Explain error codes in listing file there where they occur
    'output="{fs::path(re_dir, \'output.lst\')}"', # Path to listing file
    'pageContr=2', # No page control, no padding
    'pageSize=0', # Turn off paging
    'pageWidth=32767' # Maximum allowed to avoid missing a grep on account of a line wrap
  )
  pars <- purrr::map_chr(par_templates, stringr::str_glue, .envir=environment())
  par_file <- fs::path(re_dir, "parameters.txt")
  par_conn<-file(par_file, open="wt")
  writeLines(pars, par_conn)
  close(par_conn)

  # Construct command line arguments for GAMS
  arg_templates = c(
    '"{script}"',
    '-parmFile "{par_file}"'
  )
  args <- purrr::map_chr(arg_templates, stringr::str_glue, .envir=environment())

  # Invoke GAMS
  system2(gams, args)
}

