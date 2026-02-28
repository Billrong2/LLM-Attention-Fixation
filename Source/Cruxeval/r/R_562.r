f <- function(text) {    text == toupper(text)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('VTBAEPJSLGAHINS'), TRUE)))
}
test_humaneval()
