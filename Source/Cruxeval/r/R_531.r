f <- function(text, x) {
    if (substr(text, 1, nchar(x)) != x) {
        return(f(substr(text, 2, nchar(text)), x))
    } else {
        return(text)
    }
}

test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('Ibaskdjgblw asdl ', 'djgblw'), 'djgblw asdl ')))
}
test_humaneval()
