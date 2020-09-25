test_that("create_re_dir() creates a directory", {
  re_dir <- create_re_dir()
  withr::defer(fs::dir_delete(re_dir))
  expect_true(fs::is_dir(re_dir))
})

test_that("local_re_dir() creates and cleans up a directory", {
  create_local_re_dir <- function() {
    re_dir <- local_re_dir()
    if (fs::dir_exists(re_dir)) {
      # when returning from this function, the directory should be deleted
      return(re_dir)
    }
    NULL
  }
  re_dir <- create_local_re_dir()
  expect_vector(re_dir, ptype = fs::fs_path())
  expect_false(fs::dir_exists(re_dir))
})
