f <- function(text, sep) {    strsplit(text, split = sep, fixed = TRUE)[[1]]
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('a-.-.b', '-.'), c('a', '', 'b'))))
}
test_humaneval()
