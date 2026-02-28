f <- function(nums, start, k) {
    # Adjust for 1-based indexing in R
    start <- start + 1
    nums[start:(start + k - 1)] <- rev(nums[start:(start + k - 1)])
    return(nums)
}

test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(c(1, 2, 3, 4, 5, 6), 4, 2), c(1, 2, 3, 4, 6, 5))))
}
test_humaneval()
