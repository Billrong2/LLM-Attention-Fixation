f <- function(array, num) {    reverse <- FALSE
    if (num < 0) {
        reverse <- TRUE
        num <- num * -1
    }
    array <- rev(array) * num
    l <- length(array)
    
    if (reverse) {
        array <- rev(array)
    }
    return(array)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(c(1, 2), 1), c(2, 1))))
}
test_humaneval()
