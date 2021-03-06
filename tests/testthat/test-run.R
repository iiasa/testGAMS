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

test_that("run() can run a GAMS script and produces expected output files", {
  re_dir <- local_re_dir()
  script <- fs::path(re_dir, "test.gms")
  write_lines(script, 'display "Hello world!";')
  code <- run(script, re_dir)
  expect_equal(code, GAMS_NORMAL_RETURN)
  expect_true(fs::file_exists(fs::path(re_dir, GDX_FILE_NAME)))
  expect_true(fs::file_exists(fs::path(re_dir, LOG_FILE_NAME)))
  expect_true(fs::file_exists(fs::path(re_dir, LST_FILE_NAME)))
  expect_true(fs::file_exists(fs::path(re_dir, REF_FILE_NAME)))
  expect_true(fs::file_exists(fs::path(re_dir, TRACE_FILE_NAME)))
})

test_that("run() can return a GAMS error code", {
  re_dir <- local_re_dir()
  script <- fs::path(re_dir, "test.gms")
  write_lines(script, 'abort "Aborting execution!";')
  code <- run(script, re_dir)
  expect_equal(code, GAMS_EXECUTION_ERROR)
})

test_that("report_trace() works, produces expected output files, honors trace_level, and restores working directory", {
  re_dir <- local_re_dir()
  script <- test_path("models", "transport.gms")
  code <- run(script, re_dir)
  expect_equal(code, GAMS_NORMAL_RETURN)

  prior_wd <- getwd()
  code <- report_trace(re_dir)
  expect_equal(code, GAMS_NORMAL_RETURN)
  expect_true(fs::file_exists(fs::path(re_dir, TRACE_LOG_FILE_NAME)))
  expect_true(fs::file_exists(fs::path(re_dir, TRACE_REPORT_FILE_NAME)))
  expect_true(fs::file_exists(fs::path(re_dir, TRACE_SUMMARY_FILE_NAME)))
  expect_equal(getwd(), prior_wd)
})

test_that("report_trace() can return a GAMS error code", {
  re_dir <- local_re_dir()
  script <- test_path("models", "transport.gms")
  code <- run(script, re_dir, "iterLim=0")
  expect_equal(code, GAMS_NORMAL_RETURN)

  wd <- getwd()
  code <- report_trace(re_dir, trace_level = 5)
  expect_equal(code, GAMS_EXECUTION_ERROR)
})
