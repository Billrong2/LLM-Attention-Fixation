f <- function(text, pref) {
    if (substring(text, 1, nchar(pref)) == pref) {
        n <- nchar(pref)
        text <- paste(unlist(strsplit(substring(text, n+1), '.', fixed = TRUE))[-1], collapse = '.')
        text <- paste(c(unlist(strsplit(substring(text, 1, n-1), '.', fixed = TRUE))[-(nchar(pref) != 0)], text), collapse = '.')
    }
    return(text)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('omeunhwpvr.dq', 'omeunh'), 'dq')))
}
test_humaneval()
