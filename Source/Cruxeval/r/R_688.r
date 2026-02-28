f <- function(nums) {    l <- vector()
    for (i in nums) {
        if (!(i %in% l)) {
            l <- c(l, i)
        }
    }
    return(l)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(c(3, 1, 9, 0, 2, 0, 8)), c(3, 1, 9, 0, 2, 8))))
}
test_humaneval()
