# testGAMS
The **testGAMS** R package serves to test [GAMS](https://www.gams.com/) code. It provides functions that manage GAMS invocation and output. These functions allow you to implement tests for GAMS in R. It is recommended to structure your tests using the [**testthat**](https://testthat.r-lib.org/) framework. This framework is used to test `testGAMS` itself. The self-tests, contained in the `tests/testthat` subdirectory, therefore also serve as examples of using **testGAMS** with **testthat**.

## Installation

From an R or RStudio console, installing the **testGAMS** package is done as follows:

```
# Install the devtools package, if you have not done so already
install.packages("devtools")
# Install globiomvis development version from GitHub, it is not available on CRAN
devtools::install_github("iiasa/testGAMS")
```

This should also install all further required R packages other than [**gdxrrw**](https://www.gams.com/latest/docs/T_GDXRRW.html) which requires following a [special installation procedure](https://support.gams.com/doku.php?id=gdxrrw:interfacing_gams_and_r) that depends on the operating system and R version that you are using.

## Requirements
In addition to the R packages listed in the `DESCRIPTION` file, a GAMS installation is required.
