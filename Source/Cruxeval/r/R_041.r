f <- function(array, values) {    array <- rev(array)
    for (value in values) {
        array <- append(array, value, after = length(array) %/% 2)
    }
    rev(array)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(c(58), c(21, 92)), c(58, 92, 21))))
}
test_humaneval()
