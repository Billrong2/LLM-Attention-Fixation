f <- function(text, n) {    length_text <- nchar(text)
    substr(text, length_text * (n%%4) + 1, length_text)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('abc', 1), '')))
}
test_humaneval()
