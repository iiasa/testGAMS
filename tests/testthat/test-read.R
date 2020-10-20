test_that("read_lines() works", {
  test_lines = c("Line one.", "Line two.")
  path <- tempfile()
  local_write_lines(path, test_lines)
  lines <- read_lines(path)
  expect_equal(lines, test_lines)
})
