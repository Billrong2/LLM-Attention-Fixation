f <- function(s, n) {    if(nchar(s) < n) {
        return(s)
    } else {
        return(substring(s, n + 1))
    }
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('try.', 5), 'try.')))
}
test_humaneval()
