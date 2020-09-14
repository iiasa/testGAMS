set_sys_dir <- function(gams_sys_dir) {
  # Check argument
  stopifnot(length(gams_sys_dir) == 1)
  gams_sys_dir <- fs::as_fs_path(gams_sys_dir)
  stopifnot(fs::dir_exists(gams_sys_dir))
  # Set the directory via igdx and check if it was actually used.
  result_sys_dir <- gdxrrw::igdx(gamsSysDir=gams_sys_dir, silent=TRUE , returnStr=TRUE)
  if (result_sys_dir != gams_sys_dir) stop(stringr::str_glue("Could not set '{gams_sys_dir}' as GAMS system directory!"))
}

get_sys_dir <- function() {
  sys_dir <- gdxrrw::igdx(gamsSysDir=NULL, silent=TRUE, returnStr=TRUE)
  if (sys_dir == "") {
    # GAMS sys dir not set, try R_GAMS_SYDIR or PATH/LD_LIBRARY_PATH
    sys_dir <- gdxrrw::igdx(gamsSysDir="", silent=TRUE, returnStr=TRUE)
    if (sys_dir == "") stop("No GAMS system directory set!")
  }
  fs::as_fs_path(sys_dir)
}
