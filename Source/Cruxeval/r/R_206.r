f <- function(a) {    a <- gsub('\\s+', ' ', a)
    a <- gsub('^\\s|\\s$', '', a)
    return(a)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(' h e l l o   w o r l d! '), 'h e l l o w o r l d!')))
}
test_humaneval()
