f <- function(nums) {    count <- length(nums)
    for (i in 0:(count-1)) {
        nums <- c(nums, nums[i %% 2 + 1])
    }
    return(nums)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(c(-1, 0, 0, 1, 1)), c(-1, 0, 0, 1, 1, -1, 0, -1, 0, -1))))
}
test_humaneval()
