f <- function(num) {    num[length(num) + 1] <- num[length(num)]
    return(num)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(c(-70, 20, 9, 1)), c(-70, 20, 9, 1, 1))))
}
test_humaneval()
