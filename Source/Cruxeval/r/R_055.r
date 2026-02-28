f <- function(array) {    array_2 <- array[array > 0]
    sort(array_2, decreasing = TRUE)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(c(4, 8, 17, 89, 43, 14)), c(89, 43, 17, 14, 8, 4))))
}
test_humaneval()
