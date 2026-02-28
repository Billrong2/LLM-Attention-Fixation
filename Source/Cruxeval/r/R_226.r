f <- function(nums) {    for (i in 1:length(nums)) {
        if (nums[i] %% 3 == 0) {
            nums <- c(nums, nums[i])
        }
    }
    return(nums)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(c(1, 3)), c(1, 3, 3))))
}
test_humaneval()
