f <- function(nums) {
    count <- length(nums)
    for (i in seq(from=count, to=1, by=-1)) {
        nums <- append(nums, nums[1], after=i)
        nums <- nums[-1]
    }
    return(nums)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(c(0, -5, -4)), c(-4, -5, 0))))
}
test_humaneval()
