f <- function(array) {
    while (-1 %in% array) {
        array <- array[-length(array) + 2]
    }
    while (0 %in% array) {
        array <- array[-length(array)]
    }
    while (1 %in% array) {
        array <- array[-1]
    }
    if (identical(array, numeric(0))) {
        array <- c()
    }
    return(array)
}


test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(c(0, 2)), c())))
}
test_humaneval()
