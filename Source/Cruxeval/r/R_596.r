f <- function(txt, alpha) {
    txt <- sort(txt)
    if ((which(txt == alpha)[1] - 1) %% 2 == 0) {
        return(rev(txt))
    }
    return(txt)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(c('8', '9', '7', '4', '3', '2'), '9'), c('2', '3', '4', '7', '8', '9'))))
}
test_humaneval()
