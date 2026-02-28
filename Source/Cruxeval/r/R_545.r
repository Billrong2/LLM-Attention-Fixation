f <- function(array) {    result <- c()
    index <- 1
    while (index <= length(array)) {
        result <- c(result, array[length(array)])
        array <- array[-length(array)]
        index <- index + 2
    }
    return(result)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(c(8, 8, -4, -9, 2, 8, -1, 8)), c(8, -1, 8))))
}
test_humaneval()
