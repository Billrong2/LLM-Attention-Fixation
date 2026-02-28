f <- function(nums) {    for (i in 1:length(nums)) {
        nums <- c(nums[1:i-1], nums[i]^2, nums[i:length(nums)])
    }
    return(nums)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(c(1, 2, 4)), c(1, 1, 1, 1, 2, 4))))
}
test_humaneval()
