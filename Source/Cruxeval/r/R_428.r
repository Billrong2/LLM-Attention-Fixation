f <- function(nums) {    
    for (i in seq_along(nums)) {
        if (i %% 2 == 0) {
            nums <- append(nums, nums[i] * nums[i + 1], after = length(nums))
        }
    }
    return(nums)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(c()), c())))
}
test_humaneval()
