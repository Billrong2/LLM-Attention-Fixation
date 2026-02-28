f <- function(array, elem) {    k <- 1
    l <- array
    for (i in seq_along(l)) {
        if (l[i] > elem) {
            array <- append(array, elem, after = k-1)
            break
        }
        k <- k + 1
    }
    return(array)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(c(5, 4, 3, 2, 1, 0), 3), c(3, 5, 4, 3, 2, 1, 0))))
}
test_humaneval()
