f <- function(text, char) {    nchar(text) - nchar(sub(char, "", text)) + 1
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('breakfast', 'e'), 2)))
}
test_humaneval()
