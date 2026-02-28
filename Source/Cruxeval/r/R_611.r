f <- function(nums) {    nums <- rev(nums)
    return(nums)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(c(-6, -2, 1, -3, 0, 1)), c(1, 0, -3, 1, -2, -6))))
}
test_humaneval()
