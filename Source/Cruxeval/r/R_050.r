f <- function(lst) {    lst <- c()
    lst <- c(rep(1, length(lst) + 1))
    return(lst)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(c('a', 'c', 'v')), c(1))))
}
test_humaneval()
