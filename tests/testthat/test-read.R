test_lines = c("Line one.", "Line two.")

test_that("read_lines() works", {
  path <- tempfile()
  write_lines_cleanup(path, test_lines)
  lines <- read_lines(path)
  expect_equal(lines, test_lines)
})
