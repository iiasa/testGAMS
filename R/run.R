#' File name of GDX dump produced by `run()` in `re_dir`
#' @export
GDX_FILE_NAME <- "output.gdx"

#' File name of GANS log file produced by `run()` in `re_dir`
#' @export
LOG_FILE_NAME <- "output.log"

#' File name of GAMS listing file produced by `run()` in `re_dir`
#' @export
LST_FILE_NAME <- "output.lst"

PAR_FILE_NAME <- "parameters.txt"

#' Run a GAMS script for testing.
#'
#' Run a GAMS script and capture result files for testing. The logging
#' output, listing file, and a GDX dump of all symbols are redirected to
#' files located in `re_dir` with names LOG_FILE_NAME, LST_FILE_NAME,
#' and GDX_FILE_NAME.
#'
#' @param script Path of GAMS script to run.
#' @param re_dir Redirection directory for holding GAMS output files.
#' @return GAMS status/error/return code.
#' @export
run <- function(script, re_dir) {
  # Check and sanitize parameters
  stopifnot(length(script) == 1)
  script <- fs::as_fs_path(script)
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
    'cErr=1', # Compile-time error limit: stop after 1 error
    'errMsg=1', # Explain error codes in listing file there where they occur
    'errorLog=1000', # Max number of lines for each error that will be written to log file, 0 = none
    'logLine=0', # Minimize compile progress logging
    'logOption=2', # Log to file (stdout)
    'logFile="{fs::path(re_dir, LOG_FILE_NAME)}"', # Path to log file
    'output="{fs::path(re_dir, LST_FILE_NAME)}"', # Path to listing file
    'gdx="{fs::path(re_dir, GDX_FILE_NAME)}"', # Path to GDX file dumped at execution end
    'pageContr=2', # No page control, no padding
    'pageSize=0', # Turn off paging
    'pageWidth=32767' # Maximum allowed to avoid missing a grep on account of a line wrap
  )
  pars <- purrr::map_chr(par_templates, stringr::str_glue, .envir=environment())
  par_file <- fs::path(re_dir, PAR_FILE_NAME)
  write_lines(par_file, pars)

  # Construct command line arguments for GAMS
  arg_templates = c(
    '"{script}"',
    '-parmFile "{par_file}"'
  )
  args <- purrr::map_chr(arg_templates, stringr::str_glue, .envir=environment())

  # Invoke GAMS
  # ignore stdout: is already redirected to the log file,
  # capture stderr: only used by GAMS when it crashes out
  # status attribute on return value is set on error
  err <- suppressWarnings(system2(gams, args=args, stdout=FALSE, stderr=TRUE))

  # Extract and remove any status/error/return code
  code <- attr(err, "status")
  attr(err, "status") <- NULL
  if (is.null(code)) code <- GAMS_NORMAL_RETURN

  # Return status code when no stderr
  if (identical(err, character(0))) return(code)

  # Otherwise stop with stderr that GAMS crashed out with
  stop(err)
}
