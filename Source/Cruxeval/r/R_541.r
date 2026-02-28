f <- function(text) {
    grepl('^\\s*$', text)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(' \t  \u3000'), TRUE)))
}
test_humaneval()
