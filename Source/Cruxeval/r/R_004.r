f <- function(array) {    s <- ' '
    s <- paste0(s, paste(array, collapse = ''))
    return(s)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(c(' ', '  ', '    ', '   ')), '           ')))
}
test_humaneval()
