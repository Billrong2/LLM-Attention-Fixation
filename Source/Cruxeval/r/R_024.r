f <- function(nums, i) {
    nums <- nums[-(i + 1)]  # R is 1-indexed, so we need to adjust the index
    return(nums)
}

test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(c(35, 45, 3, 61, 39, 27, 47), 0), c(45, 3, 61, 39, 27, 47))))
}
test_humaneval()
