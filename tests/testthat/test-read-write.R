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
