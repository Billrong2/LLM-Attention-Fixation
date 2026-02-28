f <- function(nums) {    count <- length(nums) %/% 2
    for (i in 1:count) {
        nums <- nums[-1]
    }
    return(nums)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(c(3, 4, 1, 2, 3)), c(1, 2, 3))))
}
test_humaneval()
