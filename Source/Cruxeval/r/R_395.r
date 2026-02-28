f <- function(s) {
    for (i in 1:nchar(s)) {
        if (is.numeric(as.integer(substr(s, i, i)))) {
            return (i - 1) + (substr(s, i, i) == '0')
        } else if (substr(s, i, i) == '0') {
            return -1
        }
    }
    return -1
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('11'), 0)))
}
test_humaneval()
