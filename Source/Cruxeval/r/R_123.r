f <- function(array, elem) {    for (idx in 1:length(array)) {
        if (array[idx] > elem && array[idx - 1] < elem) {
            array <- append(array, elem, after = idx - 1)
        }
    }
    return(array)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(c(1, 2, 3, 5, 8), 6), c(1, 2, 3, 5, 6, 8))))
}
test_humaneval()
