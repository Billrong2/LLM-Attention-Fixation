f <- function(numbers, elem, idx) {    insert <- c(head(numbers, idx), elem, tail(numbers, -idx))
    return(insert)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(c(1, 2, 3), 8, 5), c(1, 2, 3, 8))))
}
test_humaneval()
