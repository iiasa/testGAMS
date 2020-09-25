test_that("script argument of run() is checked", {
  expect_error(run(re_dir = tempdir())) # script argument required
  expect_error(run(script = "", re_dir = tempdir())) # script must be a file
  expect_error(run(c("a", "b"), re_dir = tempdir())) # only a single script supported
  expect_error(run(script = tempdir(), re_dir = tempdir())) # script must be a file
  bad_file <- fs::file_create(fs::file_temp(ext = "bad"))
  withr::defer(fs::file_delete(bad_file))
  expect_error(run(script = bad_file, re_dir = tempdir())) # script must have a gms extension
})

test_that("re_dir argument of run() is checked", {
  gms_script <- fs::file_create(fs::file_temp(ext = "gms"))
  withr::defer(fs::file_delete(gms_script))
  expect_error(run(script = gms_script)) # re_dir argument required
  expect_error(run(script = gms_script, re_dir = tmp_script)) # re_dir must be a directory
})
