f <- function(a, b, c, d) {
    if (length(a) > 0 && length(b) > 0) {
        return(b)
    } else if (length(c) > 0 && length(d) > 0) {
        return(d)
    } else {
        return(NA)
    }
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('CJU', 'BFS', 'WBYDZPVES', 'Y'), 'BFS')))
}
test_humaneval()
