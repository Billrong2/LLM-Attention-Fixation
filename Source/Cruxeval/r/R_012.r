f <- function(s, x) {    count <- 0
    while(substr(s, 1, nchar(x)) == x && count < nchar(s) - nchar(x)) {
        s <- substr(s, nchar(x) + 1, nchar(s))
        count <- count + nchar(x)
    }
    return(s)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('If you want to live a happy life! Daniel', 'Daniel'), 'If you want to live a happy life! Daniel')))
}
test_humaneval()
