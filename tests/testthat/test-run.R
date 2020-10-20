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
  script <- fs::file_create(fs::file_temp(ext = "gms"))
  withr::defer(fs::file_delete(script))
  expect_error(run(script = script)) # re_dir argument required
  expect_error(run(script = script, re_dir = tmp_script)) # re_dir must be a directory
})

test_that("run() can run a GAMS script", {
  re_dir <- local_re_dir()
  script <- fs::path(re_dir, "test.gms")
  local_write_lines(script, 'display "Hello world!";')
  code <- run(script, re_dir)
  expect_equal(code, CODE_NORMAL_RETURN)
})

test_that("run() can return a GAMS error code", {
  re_dir <- local_re_dir()
  script <- fs::path(re_dir, "test.gms")
  local_write_lines(script, 'abort "Aborting execution!";')
  code <- run(script, re_dir)
  expect_equal(code, CODE_EXECUTION_ERROR)
})

