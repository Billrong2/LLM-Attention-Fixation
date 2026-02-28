f <- function(r, w) {    a <- list()
    if (substr(r, 1, 1) == substr(w, 1, 1) & substr(w, nchar(w), nchar(w)) == substr(r, nchar(r), nchar(r))) {
        a <- c(r, w)
    } else {
        a <- c(w, r)
    }
    return(a)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('ab', 'xy'), c('xy', 'ab'))))
}
test_humaneval()
