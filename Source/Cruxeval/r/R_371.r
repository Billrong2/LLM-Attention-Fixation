f <- function(nums) {    nums <- nums[nums %% 2 == 0]
    sum_ <- sum(nums)
    return(sum_)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(c(11, 21, 0, 11)), 0)))
}
test_humaneval()
