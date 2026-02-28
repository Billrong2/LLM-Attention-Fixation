f <- function(text, char) {    if (!grepl(paste0(char, "$"), text)) {
        return(f(paste0(char, text), char))
    }
    return(text)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('staovk', 'k'), 'staovk')))
}
test_humaneval()
