f <- function(text) {    s <- 0
    for (i in 2:nchar(text)) {
        s <- s + nchar(substr(text, 1, i - 1))
    }
    return(s)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('wdj'), 3)))
}
test_humaneval()
