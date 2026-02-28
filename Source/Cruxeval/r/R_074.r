f <- function(lst, i, n) {    insert <- append(lst, n, after = i)
    return(insert)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(c(44, 34, 23, 82, 24, 11, 63, 99), 4, 15), c(44, 34, 23, 82, 15, 24, 11, 63, 99))))
}
test_humaneval()
