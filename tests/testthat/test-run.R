test_that("path argument is checked", {
  expect_error(run()) # path argument required
  expect_error(run(c("a", "b"))) # only a single path supported
  expect_error(run(tempdir())) # must be a file, not a directory
})
