library(testthat)
library(testGAMS)

test_check("testGAMS", reporter = JunitReporter$new(file = "junit_result.xml"))
