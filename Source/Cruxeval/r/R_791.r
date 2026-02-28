f <- function(integer, n) {    i <- 1
    text <- as.character(integer)
    while (i + nchar(text) < n) {
        i <- i + nchar(text)
    }
    return (paste0(strrep("0", i), text))
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate(8999, 2), '08999')))
}
test_humaneval()
