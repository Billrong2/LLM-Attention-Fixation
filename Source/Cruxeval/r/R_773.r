f <- function(nums, n) {    num <- nums[n+1]
    nums <- nums[-n]
    return(num)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(c(-7, 3, 1, -1, -1, 0, 4), 6), 4)))
}
test_humaneval()
