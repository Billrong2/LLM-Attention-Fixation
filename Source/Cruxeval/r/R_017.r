f <- function(text) {    return(regexpr(",", text)[1] - 1)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('There are, no, commas, in this text'), 9)))
}
test_humaneval()
