f <- function(nums) {    middle <- length(nums) %/% 2
    return(c(nums[(middle + 1):length(nums)], nums[1:middle]))
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(c(1, 1, 1)), c(1, 1, 1))))
}
test_humaneval()
