f <- function(nums, elements) {    result <- vector()
    for (i in seq_along(elements)) {
        result <- c(result, tail(nums, 1))
        nums <- head(nums, -1)
    }
    return(nums)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(c(7, 1, 2, 6, 0, 2), c(9, 0, 3)), c(7, 1, 2))))
}
test_humaneval()
