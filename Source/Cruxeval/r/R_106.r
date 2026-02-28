f <- function(nums) {    count <- length(nums)
    for (i in 1:count) {
        nums <- append(nums, nums[i]*2, after = i-1)
    }
    return(nums)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(c(2, 8, -2, 9, 3, 3)), c(4, 4, 4, 4, 4, 4, 2, 8, -2, 9, 3, 3))))
}
test_humaneval()
