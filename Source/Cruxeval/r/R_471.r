f <- function(val, text) {    indices <- which(text == val)
    if (length(indices) == 0) {
        return(-1)
    } else {
        return(indices[1])
    }
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('o', 'fnmart'), -1)))
}
test_humaneval()
