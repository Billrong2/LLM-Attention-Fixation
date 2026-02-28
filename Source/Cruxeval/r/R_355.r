f <- function(text, prefix) {    substr(text, start = nchar(prefix) + 1, stop = nchar(text))
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('123x John z', 'z'), '23x John z')))
}
test_humaneval()
