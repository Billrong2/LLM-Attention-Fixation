f <- function(nums) {    count <- length(nums)
    for (num in 2:count) {
        nums <- sort(nums)
    }
    return(nums)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(c(-6, -5, -7, -8, 2)), c(-8, -7, -6, -5, 2))))
}
test_humaneval()
