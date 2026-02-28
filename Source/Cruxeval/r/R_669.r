f <- function(t) {    a_b <- strsplit(t, '-', fixed=TRUE)[[1]]
    a <- paste(a_b[-length(a_b)], collapse='-')
    b <- a_b[length(a_b)]
    if (nchar(b) == nchar(a)) {
        return('imbalanced')
    }
    paste(a, b, sep = '')
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('fubarbaz'), 'fubarbaz')))
}
test_humaneval()
