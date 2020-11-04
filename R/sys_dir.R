#' Set GAMS system directory
#'
#' Set the GAMS installation to use for testing by specifying the system
#' directory where the GAMS binaries and libraries are installed. There can be
#' multiple GAMS versions installed, so this functions selects the GAMS version
#' to test with. Specifically, the GDX libraries and GAMS compiler/interpreter
#' located in the set GAMS system directory will be used by the functions in the
#' testGAMS package.
#'
#' Internally, this function uses [gdxrrw::igdx()] via which GDX files are
#' accessed. The currently-set system directory is returned by [get_sys_dir()].
#'
#' This function throws an error if the given directory cannot be set.
#'
#' @param gams_sys_dir Path to GAMS system directory.
#' @export
set_sys_dir <- function(gams_sys_dir) {
  # Check argument
  stopifnot(length(gams_sys_dir) == 1)
  gams_sys_dir <- fs::as_fs_path(gams_sys_dir)
  stopifnot(fs::dir_exists(gams_sys_dir) | fs::link_exists(gams_sys_dir))
  # Set the directory via igdx and check if it was actually used.
  result_sys_dir <- gdxrrw::igdx(gamsSysDir=gams_sys_dir, silent=TRUE , returnStr=TRUE)
  if (result_sys_dir != gams_sys_dir) stop(stringr::str_glue("Could not set '{gams_sys_dir}' as GAMS system directory!"))
}

#' Get GAMS system directory
#'
#' Get the path to the GAMS system directory being used for testing. This is the
#' GAMS installation directory where the GDX libraries and GAMS
#' compiler/interpreter will be loaded from. It therefore determines which GAMS
#' version is used for testing. The GAMS system directory can be set with
#' [set_sys_dir()].
#'
#' When no system directory is set yet, this function will try to get and set a
#' default system directory from an environment variable, first `R_GAMS_SYSDIR`,
#' and if not available via `PATH` (on Windows) or `LD_LIBRARY_PATH` (on Linux).
#' If no such default is available either, this function throws an error.
#'
#' @return Path to the in-use GAMS system directory.
#' @export
#' @examples
#' sys_dir <- get_sys_dir()
get_sys_dir <- function() {
  gams_sys_dir <- gdxrrw::igdx(gamsSysDir = NULL, silent = TRUE, returnStr = TRUE)
  if (gams_sys_dir == "") {
    # GAMS sys dir not set, try R_GAMS_SYDIR or PATH/LD_LIBRARY_PATH
    gams_sys_dir <- gdxrrw::igdx(gamsSysDir = "", silent = TRUE, returnStr = TRUE)
    if (gams_sys_dir == "") stop("No GAMS system directory set!")
  }
  fs::as_fs_path(gams_sys_dir)
}
