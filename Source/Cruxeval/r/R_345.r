f <- function(a, b) {    if (a < b) {
        return(c(b, a))
    } else {
        return(c(a, b))
    }
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('ml', 'mv'), c('mv', 'ml'))))
}
test_humaneval()
