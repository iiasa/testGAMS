#' Return info on content of a GDX
#'
#' Returns a list with information on the content of a GDX file. Uses
#' `GDX_FILE_NAME` by default, which is the name used by `run()` to dump
#' an end-of-execution GDX. When using this default, the `dir` argument
#' should be set to the redirection directory used for the `run()`.
#'
#' @param  dir  Directory containing GDX file.
#' @param  name Name of GDX file.
#' @return List describing GDX content.
#' @export
gdx_info <- function(dir, name=GDX_FILE_NAME) {
  gdx_path <- fs::path(dir, name)
  info <- gdxrrw::gdxInfo(fs::path(dir, name), dump=FALSE, returnList=TRUE, returnDF=FALSE)
  info$path <- gdx_path
  info
}

#' Read a parameter from a GDX file as a tibble
#'
#' @param info Info list as returned by `gdx_info()`.
#' @param name Name of the parameter to read.
#' @return Tibble with parameter content.
#' @export
gdx_parameter <- function(info, name) {
  stopifnot('parameters' %in% names(info))
  stopifnot('path' %in% names(info))
  stopifnot(name %in% info$parameters)
  tibble::as_tibble(gdxrrw::rgdx.param(info$path, name, names=NULL, compress=TRUE, ts=FALSE, squeeze=TRUE, useDomInfo=TRUE, check.names=TRUE))
}

#' Read a set from a GDX file
#'
#' @param info Info list as returned by `gdx_info()`.
#' @param name Name of the set to read.
#' @return List with set content.
#' @export
gdx_set <- function(info, name) {
  stopifnot('sets' %in% names(info))
  stopifnot('path' %in% names(info))
  stopifnot(name %in% info$sets)
  gdxrrw::rgdx.set(info$path, name, names=NULL, compress=TRUE, ts=FALSE, useDomInfo=TRUE, check.names=TRUE, te=TRUE)
}
