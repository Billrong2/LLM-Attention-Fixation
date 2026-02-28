f <- function(no) {    d <- unique(no)
    return(length(d))
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(c('l', 'f', 'h', 'g', 's', 'b')), 6)))
}
test_humaneval()
