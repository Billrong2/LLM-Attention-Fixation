f <- function(nums, n) {    pos <- length(nums)
    for (i in seq_along(-length(nums): -1)) {
        nums <- append(nums, nums[i], after = pos)
    }
    return(nums)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(c(), 14), c())))
}
test_humaneval()
