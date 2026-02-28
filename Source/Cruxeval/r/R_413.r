f <- function(s) {    paste0(substr(s, 4, nchar(s)), substr(s, 3, 3), substr(s, 6, 8))
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('jbucwc'), 'cwcuc')))
}
test_humaneval()
