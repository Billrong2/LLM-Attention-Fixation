f <- function(s) {    while(length(s) > 1) {
        s <- c()
        s <- c(s, length(s))
    }
    return(s[length(s)])
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(c(6, 1, 2, 3)), 0)))
}
test_humaneval()
