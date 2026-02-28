f <- function(s, o) {    if (substr(s, 1, nchar(o)) == o) {
        s
    } else {
        paste0(o, f(s, substr(o, nchar(o)-1, 1)))
    }
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('abba', 'bab'), 'bababba')))
}
test_humaneval()
