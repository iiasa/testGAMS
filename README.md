# testGAMS
The `testGAMS` R package serves to test [GAMS](https://www.gams.com/) code. It provides functions that manage GAMS invocation and output. These functions allow you to implement tests for GAMS in R. It is recommended to structure your tests using the [`testthat`](https://testthat.r-lib.org/) framework. This framework is used to test `testGAMS` itself. These tests, contained in the `tests/testthat` subdirectory, therefore also serve as examples of using `testGAMS` with `testthat`.

## Requirements
In addition to the R packages listed in the `DESCRIPTION` file, a GAMS installation is required. Note that the [`gdxrrw`](https://www.gams.com/latest/docs/T_GDXRRW.html) package requires following a [special installation procedure](https://support.gams.com/doku.php?id=gdxrrw:interfacing_gams_and_r) that depends on the operating system and R version that you are using.
