f <- function(nums, idx, added) {
    nums <- append(nums, added, after=idx)
    return(nums)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(c(2, 2, 2, 3, 3), 2, 3), c(2, 2, 3, 2, 3, 3))))
}
test_humaneval()
