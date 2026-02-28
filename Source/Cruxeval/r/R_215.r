f <- function(text) {    new_text <- text
    while (nchar(text) > 1 && substr(text, 1, 1) == substr(text, nchar(text), nchar(text))) {
        new_text <- text <- substr(text, 2, nchar(text) - 1)
    }
    return(new_text)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(')'), ')')))
}
test_humaneval()
