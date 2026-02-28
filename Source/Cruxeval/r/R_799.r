f <- function(st) {
    if (substr(st, 1, 1) == '~') {
        e <- strrep("s", 10 - nchar(st))
        st <- paste(e, st, sep = "")
        return(f(st))
    } else {
        e <- strrep("n", 10 - nchar(st))
        return(paste(e, st, sep = ""))
    }
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('eqe-;ew22'), 'neqe-;ew22')))
}
test_humaneval()
