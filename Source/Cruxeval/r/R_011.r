f <- function(a, b) {    for (key in names(b)) {
        if (!(key %in% names(a))) {
            a[[key]] <- c(b[[key]])
        } else {
            a[[key]] <- c(a[[key]], b[[key]])
        }
    }
    return(a)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(list(), list("'foo'" = 'bar')), list("'foo'" = c('bar')))))
}
test_humaneval()
