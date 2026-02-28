f <- function(nums, p) {
    prev_p <- p - 1
    if (prev_p < 0) prev_p <- length(nums) - 1
    return(nums[prev_p + 1])
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(c(6, 8, 2, 5, 3, 1, 9, 7), 6), 1)))
}
test_humaneval()
