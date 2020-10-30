# Handle GAMS error/return codes

# Define test constants for important codes

#' GAMS return code in case of normal completion
#' @export
GAMS_NORMAL_RETURN <- 0

#' Error code returned by GAMS in case of a compilation error
#' @export
GAMS_COMPILATION_ERROR <- 2

#' Error code returned by GAMS in case of an execution error
#' @export
GAMS_EXECUTION_ERROR <- 3

#' Error code returned by GAMS in case of a file error
#' @export
GAMS_FILE_ERROR <- 5

#' Error code returned by GAMS in case of a faulty parameter
#' @export
GAMS_PARAMETER_ERROR <- 6

# Define a list that maps status codes to their description
# Taken from https://www.gams.com/32/docs/UG_GAMSReturnCodes.html#UG_GAMSReturnCodes_ListOfErrorCodes
CODE_DESCRIPTIONS <- list()
CODE_DESCRIPTIONS[[1   ]] <- "Solver is to be called, the system should never return this number"
CODE_DESCRIPTIONS[[2   ]] <- "There was a compilation error"
CODE_DESCRIPTIONS[[3   ]] <- "There was an execution error"
CODE_DESCRIPTIONS[[4   ]] <- "System limits were reached"
CODE_DESCRIPTIONS[[5   ]] <- "There was a file error"
CODE_DESCRIPTIONS[[6   ]] <- "There was a parameter error"
CODE_DESCRIPTIONS[[7   ]] <- "There was a licensing error"
CODE_DESCRIPTIONS[[8   ]] <- "There was a GAMS system error"
CODE_DESCRIPTIONS[[9   ]] <- "GAMS could not be started"
CODE_DESCRIPTIONS[[10  ]] <- "Out of memory"
CODE_DESCRIPTIONS[[11  ]] <- "Out of disk"
CODE_DESCRIPTIONS[[109 ]] <- "Could not create process/scratch directory"
CODE_DESCRIPTIONS[[110 ]] <- "Too many process/scratch directories"
CODE_DESCRIPTIONS[[112 ]] <- "Could not delete the process/scratch directory"
CODE_DESCRIPTIONS[[113 ]] <- "Could not write the script gamsnext"
CODE_DESCRIPTIONS[[114 ]] <- "Could not write the parameter file"
CODE_DESCRIPTIONS[[115 ]] <- "Could not read environment variable"
CODE_DESCRIPTIONS[[400 ]] <- "Could not spawn the GAMS language compiler (gamscmex)"
CODE_DESCRIPTIONS[[401 ]] <- "Current directory (curdir) does not exist"
CODE_DESCRIPTIONS[[402 ]] <- "Cannot set current directory (curdir)"
CODE_DESCRIPTIONS[[404 ]] <- "Blank in system directory (UNIX only)"
CODE_DESCRIPTIONS[[405 ]] <- "Blank in current directory (UNIX only)"
CODE_DESCRIPTIONS[[406 ]] <- "Blank in scratch extension (scrext)"
CODE_DESCRIPTIONS[[407 ]] <- "Unexpected cmexRC"
CODE_DESCRIPTIONS[[408 ]] <- "Could not find the process directory (procdir)"
CODE_DESCRIPTIONS[[409 ]] <- "CMEX library not be found (experimental)"
CODE_DESCRIPTIONS[[410 ]] <- "Entry point in CMEX library could not be found (experimental)"
CODE_DESCRIPTIONS[[411 ]] <- "Blank in process directory (UNIX only)"
CODE_DESCRIPTIONS[[412 ]] <- "Blank in scratch directory (UNIX only)"
CODE_DESCRIPTIONS[[909 ]] <- "Cannot add path / unknown UNIX environment / cannot set environment variable"
CODE_DESCRIPTIONS[[1000]] <- "Driver error: incorrect command line parameters for gams"
CODE_DESCRIPTIONS[[2000]] <- "Driver error: internal error: cannot install interrupt handler"
CODE_DESCRIPTIONS[[3000]] <- "Driver error: problems getting current directory"
CODE_DESCRIPTIONS[[4000]] <- "Driver error: internal error: GAMS compile and execute module not found"
CODE_DESCRIPTIONS[[5000]] <- "Driver error: internal error: cannot load option handling library"

describe_code <- function(code) {
  stopifnot(code >= 0)
  if (code == GAMS_NORMAL_RETURN) {
    # Use str_glue to get a uniform return type
    return(stringr::str_glue("GAMS returned {CODE_NORMAL_RETURN}: Normal return"))
  }
  if (code > length(CODE_DESCRIPTIONS) || is.null(CODE_DESCRIPTIONS[[code]])) {
    return(stringr::str_glue("GAMS returned {code}: Unknown error/return code"))
  }
  stringr::str_glue("GAMS returned {code}: {CODE_DESCRIPTIONS[[code]]}")
}
