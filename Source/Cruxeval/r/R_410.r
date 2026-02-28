f <- function(nums) {    a <- 1
    for (i in seq_along(nums)) {
        nums <- append(nums, nums[a], after = i)
        a <- a + 1
    }
    return(nums)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(c(1, 3, -1, 1, -2, 6)), c(1, 1, 1, 1, 1, 1, 1, 3, -1, 1, -2, 6))))
}
test_humaneval()
