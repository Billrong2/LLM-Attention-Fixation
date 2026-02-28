f <- function(d) {    d <- list()
    return(d)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(list("'a'" = '3', "'b'" = '-1', "'c'" = 'Dum')), list())))
}
test_humaneval()
