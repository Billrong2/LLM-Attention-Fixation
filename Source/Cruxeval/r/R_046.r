f <- function(l, c) {    paste(l, collapse = c)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(c('many', 'letters', 'asvsz', 'hello', 'man'), ''), 'manylettersasvszhelloman')))
}
test_humaneval()
