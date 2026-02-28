f <- function(lst) {    lst <- rev(lst)
    lst <- lst[-length(lst)]
    rev(lst)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(c(7, 8, 2, 8)), c(8, 2, 8))))
}
test_humaneval()
