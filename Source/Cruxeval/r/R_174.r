f <- function(lst) {
    lst[2:3] <- rev(lst[2:3])
    return(lst)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(c(1, 2, 3)), c(1, 3, 2))))
}
test_humaneval()
