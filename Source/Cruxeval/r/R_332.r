f <- function(nums) {    count <- length(nums)
    if (count == 0) {
        nums <- rep(0, nums[length(nums)])
    } else if (count %% 2 == 0) {
        nums <- NULL
    } else {
        nums <- nums[-seq.int(count/2)]
    }
    return(nums)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(c(-6, -2, 1, -3, 0, 1)), c())))
}
test_humaneval()
