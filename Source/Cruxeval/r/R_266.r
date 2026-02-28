f <- function(nums) {    for (i in (length(nums):1)) {
        if (nums[i] %% 2 == 1) {
            nums <- c(nums[1:i], nums[i], nums[(i+1):length(nums)])
        }
    }
    return(nums)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(c(2, 3, 4, 6, -2)), c(2, 3, 3, 4, 6, -2))))
}
test_humaneval()
