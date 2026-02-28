f <- function(text, limit, char) {    if (nchar(text) < limit) {
        text <- paste(text, strrep(char, limit - nchar(text)), sep = "")
    }
    substr(text, 1, limit)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('tqzym', 5, 'c'), 'tqzym')))
}
test_humaneval()
