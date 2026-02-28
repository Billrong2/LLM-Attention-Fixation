f <- function(nums) {    nums <- integer(0)
    return("quack")
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(c(2, 5, 1, 7, 9, 3)), 'quack')))
}
test_humaneval()
