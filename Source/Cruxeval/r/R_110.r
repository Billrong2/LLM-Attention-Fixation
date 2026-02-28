f <- function(text) {    a <- c('')
    b <- ''
    for (i in strsplit(text, '')[[1]]) {
        if (i != ' ') {
            a <- c(a, b)
            b <- ''
        } else {
            b <- paste0(b, i)
        }
    }
    return(length(a))
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('       '), 1)))
}
test_humaneval()
