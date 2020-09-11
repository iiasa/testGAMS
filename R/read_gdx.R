# TODO: manage the GAMS directory in unison with run()
read_gdx <- function(new_sysdir) {
  print(pkg_env$sysdir)
  assign('sysdir', new_sysdir, pkg_env)
}
