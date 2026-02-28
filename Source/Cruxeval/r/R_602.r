f <- function(nums, target) {    cnt <- sum(nums == target)
    return(cnt * 2)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(c(1, 1), 1), 4)))
}
test_humaneval()
