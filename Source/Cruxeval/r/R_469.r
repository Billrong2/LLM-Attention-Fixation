f <- function(text, position, value) {    length <- nchar(text)
    index <- (position %% length)
    if (position < 0) {
        index <- length %/% 2
    }
    new_text <- strsplit(text, '')[[1]]
    new_text <- append(new_text, value, index)
    new_text <- new_text[-length]
    paste(new_text, collapse = '')
}
test_humaneval <- function() {
    candidate <- f
    stopifnot(isTRUE(all.equal(candidate('sduyai', 1, 'y'), 'syduyi')))
}
test_humaneval()
