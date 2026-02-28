f <- function(nums) {    n <- length(nums)
    for (i in seq(n, 1, by = -3)) {
        if (nums[i] == 0) {
            nums <- NULL
            return(FALSE)
        }
    }
    return(nums)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(c(0, 0, 1, 2, 1)), FALSE)))
}
test_humaneval()
