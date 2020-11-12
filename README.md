# testGAMS

<!-- badges: start -->
[![Codecov test coverage](https://codecov.io/github/iiasa/testGAMS/branch/master/graph/badge.svg)](https://codecov.io/github/iiasa/testGAMS?branch=master)
<!-- badges: end -->

The **testGAMS** R package serves to test [GAMS](https://www.gams.com/) code. It provides functions that manage GAMS invocation and output. These functions allow you to implement tests for GAMS in R. It is recommended to structure your tests using the [**testthat**](https://testthat.r-lib.org/) framework. This framework is used to test `testGAMS` itself. The self-tests, contained in the `tests/testthat` subdirectory, therefore also serve as examples of using **testGAMS** with **testthat**.

## Installation

From an R or RStudio console, installing the **testGAMS** package is done as follows:

```
# Install the devtools package, if you have not done so already
install.packages("devtools")
# Install testGAMS development version from GitHub, it is not available on CRAN
devtools::install_github("iiasa/testGAMS")
```

This should also install all further required R packages other than [**gdxrrw**](https://www.gams.com/latest/docs/T_GDXRRW.html) which requires following a [special installation procedure](https://support.gams.com/doku.php?id=gdxrrw:interfacing_gams_and_r) that depends on the operating system and R version that you are using.

## Requirements
In addition to the R packages listed in the `DESCRIPTION` file, a GAMS installation is required.

## Automated testing
Since GAMS tests require GAMS, online automated testing services such as TravisCI or GitHub Actions are not usable as they do not support GAMS. A local [Jenkins](https://www.jenkins.io/) deployment with access to a licensed GAMS installation is a good alternative. The **testGAMS** package itself is tested with Jenkins. See the `Jenkinsfile` and `Makefile` for an example of how this is done through a [Jenkins pipeline](https://www.jenkins.io/doc/book/pipeline/getting-started/). 

Note that the **testGAMS** self-tests use [JunitReporter](https://testthat.r-lib.org/reference/JunitReporter.html) to summarize the test results in JUnit XML format. This XML is ingested by the Jenkins [JUnit plugin](https://plugins.jenkins.io/junit) during the post stage of the Jenkins pipeline defined in the `Jenkinsfile` to produce a test report that is browsable via the Jenkins web interface. Such automated test reporting is very helpful, and a good reason for using **testthat** together with Jenkins.
