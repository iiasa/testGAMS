if (requireNamespace("lintr", quietly = TRUE)) {
  context("lint")
  test_that("code is style-compliant and lint-free", {
    lintr::expect_lint_free()
  })
}
