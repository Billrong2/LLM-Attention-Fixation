f <- function(nums, pos, value) {    nums <- c(nums[1:pos], value, nums[(pos+1):length(nums)])
    return(nums)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(c(3, 1, 2), 2, 0), c(3, 1, 0, 2))))
}
test_humaneval()
