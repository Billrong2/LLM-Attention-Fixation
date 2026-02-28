f <- function(st, pattern) {    for (p in pattern) {
        if (substring(st, 1, nchar(p)) != p) {
            return(FALSE)
        }
        st <- substr(st, nchar(p) + 1, nchar(st))
    }
    return(TRUE)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('qwbnjrxs', c('jr', 'b', 'r', 'qw')), FALSE)))
}
test_humaneval()
