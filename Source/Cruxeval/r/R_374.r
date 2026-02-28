f <- function(seq, v) {    a <- vector()
    for (i in seq) {
        if (substring(i, nchar(i) - nchar(v) + 1, nchar(i)) == v) {
            a <- c(a, paste0(i, i))
        }
    }
    return(a)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(c('oH', 'ee', 'mb', 'deft', 'n', 'zz', 'f', 'abA'), 'zz'), c('zzzz'))))
}
test_humaneval()
