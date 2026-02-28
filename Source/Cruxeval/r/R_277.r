f <- function(lst, mode) {    result <- lst
    if (mode == 1) {
        result <- rev(result)
    }
    return(result)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(c(1, 2, 3, 4), 1), c(4, 3, 2, 1))))
}
test_humaneval()
