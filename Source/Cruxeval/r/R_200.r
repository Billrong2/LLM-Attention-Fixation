f <- function(text, value) {    length <- nchar(text)
    index <- 1
    while (length > 0) {
        value <- paste0(substr(text, index, index), value)
        length <- length - 1
        index <- index + 1
    }
    return(value)
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('jao mt', 'house'), 'tm oajhouse')))
}
test_humaneval()
