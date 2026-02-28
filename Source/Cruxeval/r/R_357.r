f <- function(s) {    r <- character(0)
    for (i in seq(nchar(s), 1, by=-1)) {
        r <- c(r, substr(s, i, i))
    }
    paste0(r, collapse="")
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('crew'), 'werc')))
}
test_humaneval()
