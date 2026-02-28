f <- function(array, x, i) {    
    if (i < -length(array) || i > length(array) - 1) {
        return('no')
    } else {
        temp <- array[i+1]
        array[i+1] <- x
        return(array)
    }
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(c(1, 2, 3, 4, 5, 6, 7, 8, 9, 10), 11, 4), c(1, 2, 3, 4, 11, 6, 7, 8, 9, 10))))
}
test_humaneval()
