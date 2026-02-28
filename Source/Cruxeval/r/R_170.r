f <- function(nums, number) {    sum(nums == number)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(c(12, 0, 13, 4, 12), 12), 2)))
}
test_humaneval()
