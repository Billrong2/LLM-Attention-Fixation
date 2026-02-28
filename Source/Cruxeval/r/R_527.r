f <- function(text, value) {    sprintf("%-*s", nchar(value), text)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('!?', ''), '!?')))
}
test_humaneval()
