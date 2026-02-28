f <- function(s) {    tolower(s)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('abcDEFGhIJ'), 'abcdefghij')))
}
test_humaneval()
