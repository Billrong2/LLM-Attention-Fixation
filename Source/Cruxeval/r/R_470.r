f <- function(number) {    transl <- list(A=1, B=2, C=3, D=4, E=5)
    result <- c()
    for (key in names(transl)) {
        if (transl[[key]] %% number == 0) {
            result <- c(result, key)
        }
    }
    return(result)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(2), c('B', 'D'))))
}
test_humaneval()
