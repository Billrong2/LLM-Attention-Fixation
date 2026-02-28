f <- function(text, delim) {    substr(text, 1, nchar(text) - nchar(sub(delim, "", text)))
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('dsj osq wi w', ' '), 'd')))
}
test_humaneval()
