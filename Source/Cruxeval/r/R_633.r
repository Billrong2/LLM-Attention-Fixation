f <- function(array, elem) {
    array <- rev(array)
    found <- match(elem, array)
    array <- rev(array)
    return(found - 1)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(c(5, -3, 3, 2), 2), 0)))
}
test_humaneval()
