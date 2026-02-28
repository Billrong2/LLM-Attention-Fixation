f <- function(array, elem) {
    ind <- match(elem, array) - 1  # match returns 1-based index, so subtract 1 for 0-based index
    return(ind * 2 + array[length(array) - ind] * 3)
}

test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(c(-1, 2, 1, -8, 2), 2), -22)))
}
test_humaneval()
