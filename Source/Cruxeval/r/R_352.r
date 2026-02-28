f <- function(nums) {    return(nums[length(nums) %/% 2 + 1])
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(c(-1, -3, -5, -7, 0)), -5)))
}
test_humaneval()
