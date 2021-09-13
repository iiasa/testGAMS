test_that("gdx_info() can index a GDX", {
  re_dir <- local_re_dir()
  script <- fs::path(re_dir, "test.gms")
  write_lines(script, c(
      'display "Do nothing.";'
    ))
  code <- run(script, re_dir)
  expect_equal(code, GAMS_NORMAL_RETURN)

  info <- gdx_info(re_dir)
  expect_true("gdxLibraryVer" %in% names(info))
  expect_true("gdxFileVer" %in% names(info))
  expect_true("producer" %in% names(info))
  expect_true("symCount" %in% names(info))
  expect_true("uelCount" %in% names(info))
  expect_true("sets" %in% names(info))
  expect_true("parameters" %in% names(info))
  expect_true("variables" %in% names(info))
  expect_true("equations" %in% names(info))
  expect_true("aliases" %in% names(info))
  expect_true("path" %in% names(info))
})

test_that("gdx_parameter() can read a parameter from a GDX", {
  re_dir <- local_re_dir()
  script <- fs::path(re_dir, "test.gms")
  write_lines(script, c(
    "Parameter",
    '    dd(*) "distribution of demand"',
    "        / mexico-df   55,",
    "          guadalaja   15 /;"
  ))
  code <- run(script, re_dir)
  expect_equal(code, GAMS_NORMAL_RETURN)

  info <- gdx_info(re_dir)
  p <- gdx_parameter(info, "dd")
  expect_true(tibble::is_tibble(p))
  expect_true(".i" %in% names(p))
  expect_true(p[[1]][[1]] == "mexico-df")
  expect_true(p[[2]][[2]] ==  15)
})

test_that("gdx_set() can read a parameter from a GDX", {
  re_dir <- local_re_dir()
  script <- fs::path(re_dir, "test.gms")
  write_lines(script, c(
    'Set cf "final products" /',
    'syncrude "refined crude (mil bbls)"',
    'lpg      "liquefied petroleum gas (million bbls)"',
    'ammonia  "ammonia (mil tons)"',
    'coke     "coke (mil tons)"',
    'sulfur   "sulfur (mil tons)" /;'
  ))
  code <- run(script, re_dir)
  expect_equal(code, GAMS_NORMAL_RETURN)

  info <- gdx_info(re_dir)
  s <- gdx_set(info, "cf")
  expect_true(is.list(s))
  expect_true(".i" %in% names(s))
  expect_true(".te" %in% names(s))
  expect_true(s[[1]][[1]] == "syncrude")
  expect_true(s[[2]][[5]] ==  "sulfur (mil tons)")
})
