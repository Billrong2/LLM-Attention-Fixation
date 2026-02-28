f <- function(nums) {
    nums <- sort(nums)
    n <- length(nums)
    new_nums <- c(nums[n %/% 2])

    if (n %% 2 == 0) {
        new_nums <- c(nums[n %/% 2 - 1], nums[n %/% 2])
    }
    
    for (i in 0:(n %/% 2 - 1)) {
        new_nums <- c(nums[n - i - 1], new_nums, nums[i])
    }
    return(new_nums)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(c(1)), c(1))))
}
test_humaneval()
