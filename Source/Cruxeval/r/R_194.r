f <- function(matr, insert_loc) {
    matr <- append(matr, list(NULL), after = insert_loc)
    return(matr)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(list(c(5, 6, 2, 3), c(1, 9, 5, 6)), 0), list(c(), c(5, 6, 2, 3), c(1, 9, 5, 6)))))
}
test_humaneval()
