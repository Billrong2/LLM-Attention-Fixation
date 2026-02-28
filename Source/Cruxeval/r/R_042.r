f <- function(nums) {
    nums <- c()
    for (num in nums) {
        nums <- c(nums, num*2)
    }
    return(nums)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(c(4, 3, 2, 1, 2, -1, 4, 2)), c())))
}
test_humaneval()
