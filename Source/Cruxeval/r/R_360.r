f <- function(text, n) {    if (nchar(text) <= 2) {
        return(text)
    }
    leading_chars <- substr(text, 1, 1) * (n - nchar(text) + 1)
    paste0(leading_chars, substr(text, 2, nchar(text) - 1), substr(text, nchar(text), nchar(text)))
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('g', 15), 'g')))
}
test_humaneval()
