f <- function(n) {    length <- nchar(n) + 2
    revn <- strsplit(n, '')[[1]]
    result <- paste(revn, collapse = '')
    revn <- NULL
    return(paste0(result, strrep('!', length)))
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('iq'), 'iq!!!!')))
}
test_humaneval()
