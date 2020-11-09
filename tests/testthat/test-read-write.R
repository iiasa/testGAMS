test_lines = c("Line one.", "Line two.")

test_that("write_lines() and read_lines() work", {
  path <- tempfile()
  write_lines(path, test_lines)
  lines <- read_lines(path)
  fs::file_delete(path)
  expect_equal(lines, test_lines)
})

test_that("write_lines_cleanup() works", {
  path <- tempfile()
  helper <- function(path) {
    write_lines_cleanup(path, test_lines)
    read_lines(path)
  }
  lines <- helper(path)
  expect_equal(lines, test_lines)
  expect_false(fs::file_exists(path))
})

test_that("read_log(), read_lst(), read_ref(), and read_trace() work", {
  re_dir <- local_re_dir()
  script <- fs::path(re_dir, "test.gms")
  test_string <- "Some text that goes into the listing file" # beware: avoid regex special characters
  write_lines(script, stringr::str_glue('display "{test_string}";'))
  code <- run(script, re_dir)
  expect_equal(code, GAMS_NORMAL_RETURN)

  log <- read_log(re_dir)
  expect_match(log, "Normal completion", all = FALSE)

  lst <- read_lst(re_dir)
  expect_match(lst, test_string, all = FALSE)

  ref <- read_ref(re_dir)
  expect_match(ref, "symboltable", all = FALSE)

  trace <- read_trace(re_dir)
  expect_match(trace, "Trace Record Definition", all = FALSE)
})
