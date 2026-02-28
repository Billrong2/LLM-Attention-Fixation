f <- function(text, start) {    startsWith(text, start)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('Hello world', 'Hello'), TRUE)))
}
test_humaneval()
