f <- function(text, dng) {
    if (!grepl(dng, text)) {
        return(text)
    }
    if (substr(text, nchar(text) - nchar(dng) + 1, nchar(text)) == dng) {
        return(substr(text, 1, nchar(text) - nchar(dng)))
    }
    return(paste0(substr(text, 1, nchar(text) - 1), f(substr(text, 1, nchar(text) - 2), dng)))
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('catNG', 'NG'), 'cat')))
}
test_humaneval()
