f <- function(arr) {    arr <- list(arr)
    arr <- list()
    arr <- c(arr, '1', '2', '3', '4')
    return(paste(arr, collapse = ','))
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(c(0, 1, 2, 3, 4)), '1,2,3,4')))
}
test_humaneval()
