f <- function(string, substring) {    while (startsWith(string, substring)) {
        string <- substr(string, nchar(substring) + 1, nchar(string))
    }
    string
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('', 'A'), '')))
}
test_humaneval()
