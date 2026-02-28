f <- function(n, s) {    if (startsWith(s, n)) {
        parts <- strsplit(s, n)[[1]]
        return(paste0(parts[1], n, substr(s, nchar(n)+1, nchar(s))))
    }
    return(s)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('xqc', 'mRcwVqXsRDRb'), 'mRcwVqXsRDRb')))
}
test_humaneval()
