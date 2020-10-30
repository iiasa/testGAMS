# The underscore in the test file name ensures this is the first test
# to run since further tests depend on the GAMS system directory
# being available. Tests run in name sort order.
#
# This test will fail when GAMS the system directory was never set
# and no GAMS system directory is set in either R_GAMS_SYSDIR or
# the PATH|LD_LIBRARY_PATH environment variable.
context("sys_dir")
test_that("get_sys_dir() returns what is set by set_sys_dir() ", {
  sys_dir <- get_sys_dir()
  set_sys_dir(sys_dir)
  expect_equal(sys_dir, get_sys_dir())
})
