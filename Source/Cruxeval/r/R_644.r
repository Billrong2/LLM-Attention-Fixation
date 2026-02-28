f <- function(nums, pos) {    s <- seq_along(nums)
    if (pos %% 2 == 1) {
        s <- seq_along(nums)[-length(nums)]
    }
    nums[s] <- rev(nums[s])
    return(nums)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(c(6, 1), 3), c(6, 1))))
}
test_humaneval()
