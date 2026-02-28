f <- function(array, elem) {    elem <- as.character(elem)
    d <- 0
    for (i in array) {
        if (as.character(i) == elem) {
            d <- d + 1
        }
    }
    return(d)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(c(-1, 2, 1, -8, -8, 2), 2), 2)))
}
test_humaneval()
