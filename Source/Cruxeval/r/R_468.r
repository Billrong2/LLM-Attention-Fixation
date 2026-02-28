f <- function(a, b, n) {    result <- m <- b
    for (i in 1:n) {
        if (nchar(m) > 0) {
            parts <- unlist(strsplit(a, m))
            a <- paste(parts, collapse = '')
            m <- NULL
            result <- m <- b
        }
    }
    return(paste(unlist(strsplit(a, b)), collapse = ''))
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('unrndqafi', 'c', 2), 'unrndqafi')))
}
test_humaneval()
